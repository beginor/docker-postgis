#!/bin/bash -e
# Update and install tools packages
apt-get update && apt-get upgrade -y
apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates gnupg lsb-release
# PostGIS
apt-get install -y --no-install-recommends postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
  postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts postgresql-$PG_MAJOR-pgvector
# TimescaleDB package
echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main" | tee /etc/apt/sources.list.d/timescaledb.list
# TimescaleDB GPG key
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | gpg --dearmor -o /etc/apt/trusted.gpg.d/timescaledb.gpg
apt-get update
apt-get install -y timescaledb-2-postgresql-$PG_MAJOR
# Init scripts
mkdir -p /docker-entrypoint-initdb.d
mv /tmp/src/initdb-postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
mv /tmp/src/timescaledb-tune.sh /docker-entrypoint-initdb.d/99_timescaledb-tune.sh
mv /tmp/src/update-postgis.sh /usr/local/bin/
# Remove unused package and cleanup.
apt-get remove -y --purge wget apt-transport-https ca-certificates gnupg lsb-release
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
# Final cleanup
rm -rf /tmp/src
