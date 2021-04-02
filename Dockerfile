FROM postgis/postgis:13-3.1

COPY ./src /tmp/src
RUN /tmp/src/install.sh
