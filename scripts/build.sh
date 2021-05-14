#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

IMAGE_TAG=${IMAGE_TAG:-latest}
IMAGE_REPOSITORY=${IMAGE_REPOSITORY:-quay.io/evanshortiss/shipwars-client}

cd ${DIR}/..
rm -rf build
yarn install
yarn build

# Copy nginx conf into the build dir. Enables GZIP compression
cp nginx.conf ./build/nginx.conf

# Use the local build/ folder as the source
s2i build ./build registry.access.redhat.com/ubi8/nginx-118 ${IMAGE_REPOSITORY}:${IMAGE_TAG}
