#!/usr/bin/env bash
USAGE="Usage: $0 DOCKER_TAG BASE_IMAGE

Creates DOCKER_TAG/Dockerfile with ./Dockerfile as a template
Note: BASE_IMAGE should be an image based on alpine"
if [ $# -ne 2 ]; then
  echo "$USAGE"
  exit 1
fi

DOCKERFILE=Dockerfile
DOCKER_TAG=${1}
BASE_IMAGE=${2}
NEW_DOCKERFILE=$DOCKER_TAG/Dockerfile

echo "Creating new Dockerfile for tag \`$DOCKER_TAG\` based on \`$BASE_IMAGE\`"
mkdir -p $DOCKER_TAG
sed 's/^FROM alpine/FROM '${BASE_IMAGE}'/; s/^COPY entrypoint.sh/COPY ..\/entrypoint.sh/' $DOCKERFILE > $NEW_DOCKERFILE