#!/bin/bash

docker buildx build \
  --platform linux/amd64 \
  --platform linux/arm64 \
  -t beginor/postgis:16-3.4 \
  -t beginor/postgis:16-3.4.$(date +"%Y%m%d%H%M%S") \
  --push \
  .
