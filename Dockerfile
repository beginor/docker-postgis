FROM postgis/postgis:11-3.0

COPY ./src /tmp/src
RUN /tmp/src/install.sh

ENV LD_LIBRARY_PATH=/usr/lib/postgresql/11/lib/
