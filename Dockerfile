FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends build-essential curl
RUN sudo apt-get update && sudo apt-get install -y perl
RUN curl -L http://cpanmin.us | perl - --sudo App::cpanminus

RUN sudo apt-get install -y libdatetime-perl
RUN sudo apt-get update && sudo apt-get install -y postgresql-client libpq-dev
RUN sudo apt-get update && sudo apt-get install -y mysql-client libmysqlclient-dev

RUN sudo cpanm App::Sqitch
RUN sudo cpanm DBD::Pg
RUN sudo cpanm DBD::mysql

COPY . .
ENTRYPOINT ["./init_db.sh"]