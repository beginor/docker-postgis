#!/bin/bash

docker buildx build \
  --platform linux/amd64 \
  --platform linux/arm64 \
  -t beginor/postgis:18-3.6 \
  -t beginor/postgis:18-3.6.$(date +"%Y%m%d%H%M%S") \
  --push \
  .
