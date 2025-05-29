#!/usr/bin/env bash

sudo systemctl start docker

sudo docker compose down \
  --rmi local
  --volumes
  --remove-orphans

docker system prune -a --volumes

sudo docker compose build --no-cache
sudo docker compose run --rm \
  --entrypoint bash \
  rpi_imagegen -ic "\
    cd Linko-OS && \
    ./linko-build.sh && \
    cp work/linko/deploy/linko.img /host-downloads/linko.img && \
    exec bash"


sudo systemctl stop docker