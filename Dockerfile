# Dependencies required to build line-collision-detector
FROM gcc:latest AS base
MAINTAINER Torbjørn Ludvigsen (tobben@hangprinter.org)

WORKDIR /root/
RUN curl -sSfO https://download.build2.org/0.12.0/build2-install-0.12.0.sh && \
  sh build2-install-0.12.0.sh --yes --trust yes


# Build shfmt
FROM golang:1.12-alpine3.9 AS shfmt-builder

ARG SRC_PATH=/go/src/mvdan.cc/sh
ARG MODULE_VERSION=2.6.4
ARG GITHUB_URI=https://github.com/mvdan/sh.git
ARG BUILD_DIR=./cmd/shfmt
ARG SRC_PATH=/root/shfmt-src

WORKDIR /root/shfmt-src

RUN set -x && \
    apk add --no-cache git=2.20.1-r0 && \
    git clone ${GITHUB_URI} ./ && \
    git checkout a3dcc70 && \
    mkdir -p /go/src/mvdan.cc/sh && \
    cp -R . /go/src/mvdan.cc/sh && \
    CGO_ENABLED=0 go install -ldflags '-w -s -extldflags "-static"' mvdan.cc/sh/cmd/shfmt


# Do apt-get installs
FROM base AS tools

WORKDIR /root/
RUN apt-get update && apt-get install -y --no-install-recommends \
  clang-format \
  vim \
  xsel && \
  apt-get autoremove -y && \
  apt-get clean


# Copy the needed stuff
FROM tools AS compile

RUN useradd -ms /bin/bash user

COPY .gitconfig /home/user/.gitconfig
COPY .vimrc /home/user/.vimrc
COPY .bashrc /home/user/.bashrc
COPY --from=shfmt-builder /go/bin/shfmt /bin/shfmt

WORKDIR /
