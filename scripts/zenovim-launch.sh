#!/bin/bash
tag=${1:-arch}
image="zenoli/zenovim:$tag"
docker run \
    -it \
    --rm \
    --mount type=bind,source="$(pwd)"/nvim,target=/home/dev/.config/nvim \
    --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix,readonly \
    --env DISPLAY=$DISPLAY \
    --name zenovim \
    $image

