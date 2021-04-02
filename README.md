# beginor/postgis

Version info:

- PostgreSQL 13.x
- PostGIS 3.x
- TimeScaleDB 2.x

Example usage:

```sh
if [ ! -d "$(pwd)/postgis/data" ]; then
    mkdir -p "$(pwd)/postgis/data"
fi


docker run \
    --detach \
    --name postgis \
    --env POSTGRES_PASSWORD=YOUR_PASSWORD \
    --volume $(pwd)/postgis/data:/var/lib/postgresql/data \
    --publish 5432:5432 \
    --restart unless-stopped \
    --hostname postgis \
    beginor/postgis:13
```
