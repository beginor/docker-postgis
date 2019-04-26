FROM mdillon/postgis:10

COPY ["postgres_support/10/PGSQLEngine.so", "postgres_support/10/st_geometry.so", "/usr/lib/postgresql/10/lib/"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates && \
    wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add - && \
    sh -c "echo 'deb https://packagecloud.io/timescale/timescaledb/debian/ `lsb_release -c -s` main' > /etc/apt/sources.list.d/timescaledb.list" && \
    apt-get update && \
    apt-get install -y timescaledb-postgresql-10 && \
    apt-get remove -y --purge wget apt-transport-https ca-certificates && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
COPY ["timescaledb-tune.sh", "/docker-entrypoint-initdb.d/"]

ENV LD_LIBRARY_PATH=/usr/lib/postgresql/10/lib/
