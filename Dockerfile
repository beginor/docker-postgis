FROM postgres:10-bullseye

LABEL maintainer="beginor - https://beginor.github.io"

ENV POSTGIS_MAJOR 3
ENV POSTGIS_VERSION 3.2.2+dfsg-1.pgdg110+1

ENV LD_LIBRARY_PATH=/usr/lib/postgresql/10/lib/

COPY ./src /tmp/src
RUN /tmp/src/install.sh
