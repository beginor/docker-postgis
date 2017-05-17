FROM mdillon/postgis:9.3

ADD postgres_support/libst_raster_pg.so /usr/lib/postgresql/9.3/lib/
ADD postgres_support/st_geometry.so /usr/lib/postgresql/9.3/lib/

ENV LD_LIBRARY_PATH=/usr/lib/postgresql/9.3/lib/
