# Dependencies required to build line-collision-detector
FROM gcc:latest AS base
MAINTAINER Torbjørn Ludvigsen (tobben@hangprinter.org)

WORKDIR /root/
RUN curl -sSfO https://download.build2.org/0.10.0/build2-install-0.10.0.sh && \
  sh build2-install-0.10.0.sh --yes --trust yes

FROM base AS tools

WORKDIR /root/
RUN apt-get update && apt-get install -y --no-install-recommends \
  vim && \
  apt-get autoremove -y && \
  apt-get clean

FROM tools AS compile

COPY .gitconfig /root/.gitconfig

WORKDIR /
