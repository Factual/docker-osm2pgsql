FROM boritzio/docker-base

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
RUN apt-get install wget
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN apt-get update

RUN apt-get -y install autoconf automake libtool make g++ pkg-config libboost-dev \
  libboost-system-dev libboost-filesystem-dev libboost-thread-dev libexpat1-dev \
  libgeos-dev libgeos++-dev libpq-dev libbz2-dev libproj-dev \
  protobuf-compiler libprotobuf-dev lua5.2 liblua5.2-dev git postgresql-client-9.4

RUN git clone git://github.com/openstreetmap/osm2pgsql.git
RUN cd osm2pgsql && ./autogen.sh && ./configure && make && make install
RUN export PATH=~/osm2pgsql/:$PATH