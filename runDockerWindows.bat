docker compose down `
  --rmi local `
  --volumes `
  --remove-orphans

docker system prune -a --volumes -f

docker compose build --no-cache
docker compose run --rm rpi_imagegen