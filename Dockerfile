FROM postgres:16-bullseye

LABEL maintainer="beginor - https://beginor.github.io"

ENV POSTGIS_MAJOR 3
ENV POSTGIS_VERSION 3.4.2+dfsg-1.pgdg110+1

COPY ./src /tmp/src
RUN /tmp/src/install.sh
