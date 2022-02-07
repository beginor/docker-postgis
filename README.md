# beginor/postgis

Version info:

- PostgreSQL 14.1
- PostGIS 3.2.0
- TimeScaleDB 2.5.1

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
    beginor/postgis:14-3.2.2022.0207
```
