FROM postgis/postgis:14-3.2

COPY ./src /tmp/src
RUN /tmp/src/install.sh
