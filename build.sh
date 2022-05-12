#!/bin/bash

docker buildx build \
  --platform linux/amd64 \
  --platform linux/arm64 \
  -t beginor/postgis:14-3.2 \
  -t beginor/postgis:14-3.2.$(date +%Y%m%d) \
  --push \
  .
