#!/usr/bin/env bash

sudo systemctl start docker

sudo docker compose down \
  --rmi local
  --volumes
  --remove-orphans

docker system prune -a --volumes

sudo docker compose build --no-cache
sudo docker compose run --rm rpi_imagegen


sudo systemctl stop docker

#sudo cp work/linko/deploy/linko.img /host-downloads/linko.img