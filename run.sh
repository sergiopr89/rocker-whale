#!/bin/bash

CONTAINER_NAME="rocker"
WORKSPACE="workspace/"
ABS_WORKSPACE="$(pwd)/${WORKSPACE}"

docker build -t ${CONTAINER_NAME} .

xhost +
docker run -it --rm \
  --hostname ${CONTAINER_NAME} \
  -w ${ABS_WORKSPACE} \
  -v ${ABS_WORKSPACE}:${ABS_WORKSPACE} \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY \
  ${CONTAINER_NAME}
xhost -
