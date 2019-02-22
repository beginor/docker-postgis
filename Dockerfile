FROM mdillon/postgis:10

COPY ["postgres_support/10/PGSQLEngine.so", "postgres_support/10/st_geometry.so", "/usr/lib/postgresql/10/lib/"]

ENV LD_LIBRARY_PATH=/usr/lib/postgresql/10/lib/
