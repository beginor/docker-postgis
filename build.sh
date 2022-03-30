#!/bin/bash

docker buildx build \
  --platform linux/amd64 \
  --platform linux/arm64 \
  -t beginor/postgis:latest \
  -t beginor/postgis:$(date +%Y%m%d) \
  --push \
  .
