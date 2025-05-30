#!/usr/bin/env bash

sudo systemctl start docker

sudo docker compose down \
  --rmi local
  --volumes
  --remove-orphans

docker system prune -a --volumes

sudo docker compose build --no-cache
sudo docker compose run --rm rpi_imagegen

sudo docker compose down \
  --rmi local
  --volumes
  --remove-orphans

docker system prune -a --volumes

sudo systemctl stop docker

#docker cp 63de2036f016:/home/imagegen/Linko-OS/work/linko/deploy/linko.img ~/Downloads/