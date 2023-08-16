FROM archlinux:latest
RUN groupadd --gid 1000 dev \
  && useradd --uid 1000 --gid dev --shell /bin/bash --create-home dev
RUN pacman -Sy
RUN pacman -S --noconfirm gcc nodejs curl wget git unzip make ripgrep fd neovim
RUN chown -R dev:dev /home/dev
USER dev
COPY --chown=dev awesome /home/dev/awesome
WORKDIR /home/dev
CMD ["nvim"]

