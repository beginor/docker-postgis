FROM mdillon/postgis:9.6

COPY ["postgres_support/9.6/PGSQLEngine.so", "postgres_support/9.6/st_geometry.so", "/usr/lib/postgresql/9.6/lib/"]

ENV LD_LIBRARY_PATH=/usr/lib/postgresql/9.6/lib/
