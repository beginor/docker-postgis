#!/bin/bash -e
POSTGIS_MAJOR=3
POSTGIS_VERSION=3.0.0+dfsg-2~exp1.pgdg90+1
# ArcGIS support files
mv /tmp/src/postgres_support/10/*.so /usr/lib/postgresql/10/lib/
# Update and install tools packages
apt-get update && apt-get upgrade -y
apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates
# TimescaleDB repository
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add -
sh -c "echo 'deb https://packagecloud.io/timescale/timescaledb/debian/ stretch main' > /etc/apt/sources.list.d/timescaledb.list"
apt-get update
apt-get install -y timescaledb-postgresql-10
# Install PostGIS
apt-get install -y --no-install-recommends \
    postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
    postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
    postgis=$POSTGIS_VERSION
# Init scripts
mkdir -p /docker-entrypoint-initdb.d
mv /tmp/src/initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh
mv /tmp/src/update-postgis.sh /usr/local/bin
mv /tmp/src/timescaledb-tune.sh /docker-entrypoint-initdb.d/
# Remove unused package and cleanup.
apt-get remove -y --purge wget apt-transport-https ca-certificates
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
# Final cleanup
rm -rf /tmp/src
