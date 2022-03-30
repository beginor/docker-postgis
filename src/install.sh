#!/bin/bash -e
# Update and install tools packages
apt-get update && apt-get upgrade -y
apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates
# PostGIS
apt-get install -y --no-install-recommends postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
  postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts
# TimescaleDB repository
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add -
sh -c "echo 'deb https://packagecloud.io/timescale/timescaledb/debian/ bullseye main' > /etc/apt/sources.list.d/timescaledb.list"
apt-get update
apt-get install -y timescaledb-2-postgresql-14
# Init scripts
mkdir -p /docker-entrypoint-initdb.d
mv /tmp/src/initdb-postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
mv /tmp/src/timescaledb-tune.sh /docker-entrypoint-initdb.d/99_timescaledb-tune.sh
mv /tmp/src/update-postgis.sh /usr/local/bin/
# Remove unused package and cleanup.
apt-get remove -y --purge wget apt-transport-https ca-certificates
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
# Final cleanup
rm -rf /tmp/src
