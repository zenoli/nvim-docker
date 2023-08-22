#!/bin/bash
tag=${1:-arch}
image="zenoli/zenovim:$tag"
docker run \
    -it \
    --rm \
    --mount type=bind,source="$(pwd)"/nvim,target=/home/dev/.config/nvim \
    --name zenovim \
    $image

