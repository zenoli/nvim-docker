# Neovim Docker

## Setup

Build: `docker build -t neovim-docker .`
Run:

```
docker run \
    -it \
    --rm \
    --mount type=bind,source="$(pwd)"/nvim,target=/home/dev/.config/nvim \
    neovim-test
```

