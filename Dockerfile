FROM postgres:14-bullseye

LABEL maintainer="beginor - https://beginor.github.io"

ENV POSTGIS_MAJOR 3
ENV POSTGIS_VERSION 3.2.1+dfsg-1.pgdg110+1

COPY ./src /tmp/src
RUN /tmp/src/install.sh
