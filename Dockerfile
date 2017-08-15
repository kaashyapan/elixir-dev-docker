FROM elixir:slim

MAINTAINER sunder.narayanaswamy@gmail.com

ENV HOME /root
ENV PG_VERSION 9.4

RUN bash -c "curl -sL https://deb.nodesource.com/setup_6.x | bash -"

# Install postgres & node required for Phoenix framework
RUN apt-get update && apt-get install -y \
    postgresql postgresql-contrib \
    nodejs inotify-tools \
    emacs sudo \
    python3-pip
    
RUN apt-get -y autoremove && \
    apt-get -y clean  && \
    apt-get -y autoclean  && \
    rm -rf /var/lib/apt/lists/* 

EXPOSE 4000

RUN pg_dropcluster --stop $PG_VERSION main && \
    pg_createcluster --encoding UTF8 --start $PG_VERSION main && \
    su postgres -c "psql --command \"ALTER USER postgres WITH PASSWORD 'postgres';\" " && \
    pg_ctlcluster $PG_VERSION main stop  

WORKDIR /root

RUN bash -c "pip3 install --upgrade s3cmd awscli"

CMD pg_ctlcluster $PG_VERSION main start && \
    /bin/bash
# tail -f /dev/null
