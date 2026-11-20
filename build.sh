#!/bin/bash -e

# usage: ./build.sh [registry-url]
#   registry-url: target registry, e.g. 127.0.0.1:5000, defaults to docker hub
REGISTRY="${1%/}"
REPO="beginor/postgis"
IMAGE="${REGISTRY:+$REGISTRY/}$REPO"

TAG="18-3.7"
VERSION_TAG="$TAG.$(date +"%Y%m%d%H%M%S")"
ARCHS="amd64 arm64"

# private registry may use http, so allow insecure manifest operations
MANIFEST_OPTS=""
if [ -n "$REGISTRY" ] && [ "$REGISTRY" != "docker.io" ]; then
    MANIFEST_OPTS="--insecure"
fi

# per-arch image list, e.g. beginor/postgis:amd64-xxx beginor/postgis:arm64-xxx
ARCH_IMAGES=""
for arch in $ARCHS; do
    ARCH_IMAGES="$ARCH_IMAGES $IMAGE:$arch-$VERSION_TAG"
done

# build and push images for each arch
for arch in $ARCHS; do
    docker build --platform linux/$arch -t $IMAGE:$arch-$VERSION_TAG .
    docker push $IMAGE:$arch-$VERSION_TAG
done

# create and push multi-arch manifests
for tag in $TAG $VERSION_TAG; do
    docker manifest create $MANIFEST_OPTS $IMAGE:$tag $ARCH_IMAGES
    docker manifest push $MANIFEST_OPTS $IMAGE:$tag
    docker manifest rm $IMAGE:$tag
done

# remove per-arch tags, keep multi-arch tags only
if [ -n "$MANIFEST_OPTS" ]; then
    for arch in $ARCHS; do
        curl -s -o /dev/null -X DELETE "http://$REGISTRY/v2/$REPO/manifests/$arch-$VERSION_TAG"
    done
else
    # docker hub only allows tag deletion from its web api, do it by hand
    echo "Delete these tags manually on Docker Hub (Manage Repository -> Tags):"
    for arch in $ARCHS; do
        echo "  $IMAGE:$arch-$VERSION_TAG"
    done
fi

# cleanup local images
docker rmi $ARCH_IMAGES

echo "Final image is: $IMAGE:$TAG ($VERSION_TAG)"
