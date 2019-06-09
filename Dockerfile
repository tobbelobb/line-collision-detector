FROM gcc:latest
MAINTAINER Torbjørn Ludvigsen (tobben@hangprinter.org)

RUN apt-get update && apt-get install -y --no-install-recommends \
  vim && \
  apt-get autoremove -y && \
  apt-get clean

RUN curl -sSfO https://download.build2.org/0.10.0/build2-install-0.10.0.sh && \
  sh build2-install-0.10.0.sh --yes
