FROM mdillon/postgis:9.5

COPY ["postgres_support/9.5/libst_raster_pg.so", "postgres_support/9.5/PGSQLEngine.so", "postgres_support/9.5/st_geometry.so", "/usr/lib/postgresql/9.5/lib/"]

ENV LD_LIBRARY_PATH=/usr/lib/postgresql/9.5/lib/
