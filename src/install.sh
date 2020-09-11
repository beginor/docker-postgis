#!/bin/bash -e
# ArcGIS support files
mv /tmp/src/postgres_support/11/*.so /usr/lib/postgresql/11/lib/
# Update and install tools packages
apt-get update && apt-get upgrade -y
apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates
# TimescaleDB repository
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add -
sh -c "echo 'deb https://packagecloud.io/timescale/timescaledb/debian/ stretch main' > /etc/apt/sources.list.d/timescaledb.list"
apt-get update
apt-get install -y timescaledb-postgresql-11
# Init scripts
mkdir -p /docker-entrypoint-initdb.d
mv /tmp/src/timescaledb-tune.sh /docker-entrypoint-initdb.d/
# Remove unused package and cleanup.
apt-get remove -y --purge wget apt-transport-https ca-certificates
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
# Final cleanup
rm -rf /tmp/src
