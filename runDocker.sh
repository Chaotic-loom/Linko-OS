#!/usr/bin/env bash

sudo systemctl start docker

sudo docker compose build
sudo docker compose run --rm rpi_imagegen bash

sudo systemctl stop docker