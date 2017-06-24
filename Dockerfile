FROM elixir

MAINTAINER sunder.narayanaswamy@gmail.com

ENV HOME /root
ENV PGDATA /var/lib/postgresql/main
ENV PG_VERSION 9.4

RUN bash -c "curl -sL https://deb.nodesource.com/setup_6.x | bash -"

# Install postgres & node required for Phoenix framework
RUN apt-get update && apt-get install -y \
	postgresql postgresql-contrib \
    emacs \
    nodejs
	
VOLUME [$HOME, $PGDATA]


RUN apt-get -y autoremove && \
    apt-get -y clean  && \
    apt-get -y autoclean  && \
    rm -rf /var/lib/apt/lists/* 

EXPOSE 4000

RUN pg_dropcluster --stop $PG_VERSION main && \
	pg_createcluster --encoding UTF8 -d $PGDATA --start $PG_VERSION main && \
	su postgres -c "psql --command \"ALTER USER postgres WITH PASSWORD 'postgres';\" " 

WORKDIR /home/user

CMD	pg_ctlcluster $PG_VERSION main start && /bin/bash

# docker run -it --rm -p 80:4000 -v $HOME/workspace/elixir:/home/user -v $HOME/postgres/elixir-dev:/var/lib/postgresql sundernarayanaswamy/elixir-dev
