FROM postgres:10

COPY ["src", "/tmp/"]
RUN /tmp/src/install.sh

ENV LD_LIBRARY_PATH=/usr/lib/postgresql/10/lib/
