# Neovim Docker

## Setup

Build: `docker build -t neovim-docker .`
Run: `./scripts/zenovim-launch.sh`

This is a simple wrapper around running the docker image as follows:

```shell
docker run \
    -it \
    --rm \
    --mount type=bind,source="$(pwd)"/nvim,target=/home/dev/.config/nvim \
    --name zenovim \
    neovim-docker
```

Attach to running container: `./scripts/zenovim-attach.sh`

This is a wrapper script calling:

`docker exec -it zenovim bash`


Hello
