#!/bin/bash

docker buildx build \
  --platform linux/amd64 \
  -t beginor/postgis:10-3.2 \
  -t beginor/postgis:10-3.2.$(date +%Y%m%d) \
  --output type=image \
  .
