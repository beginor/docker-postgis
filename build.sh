#!/bin/bash

docker buildx build \
  --platform linux/amd64 \
  --platform linux/arm64 \
  -t beginor/postgis:17-3.5 \
  -t beginor/postgis:17-3.5.$(date +"%Y%m%d%H%M%S") \
  --push \
  .
