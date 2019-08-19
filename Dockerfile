FROM postgres:10

COPY ./src /tmp/src
RUN /tmp/src/install.sh

ENV LD_LIBRARY_PATH=/usr/lib/postgresql/10/lib/
