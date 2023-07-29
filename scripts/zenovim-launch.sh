#!/bin/bash
docker run \
    -it \
    --rm \
    --mount type=bind,source="$(pwd)"/nvim,target=/home/dev/.config/nvim \
    --name zenovim \
    neovim-docker

