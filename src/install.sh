#!/bin/bash -e
# add arcgis support files for pg 10
mv /tmp/src/postgres_support/10/*.so /usr/lib/postgresql/10/lib/

# Update and install tools packages
apt-get update && apt-get upgrade -y

# install postgis
apt-get install -y --no-install-recommends postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
  postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts

# Init scripts
mkdir -p /docker-entrypoint-initdb.d
mv /tmp/src/initdb-postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
mv /tmp/src/update-postgis.sh /usr/local/bin/
# Remove unused package and cleanup.
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
# Final cleanup
rm -rf /tmp/src