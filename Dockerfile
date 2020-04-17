# Dependencies required to build line-collision-detector
FROM gcc:latest AS base
MAINTAINER Torbjørn Ludvigsen (tobben@hangprinter.org)

# Setup a user with no-password sudo
USER root
RUN useradd -ms /bin/bash user
RUN apt-get update && apt-get install -y --no-install-recommends sudo && \
    echo "user ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-user-for-password
USER user

RUN sudo curl -sSfO https://download.build2.org/0.12.0/build2-install-0.12.0.sh && \
    sudo sh build2-install-0.12.0.sh --yes --trust yes

# Build shfmt
FROM golang:1.12-alpine3.9 AS shfmt-builder

ARG SRC_PATH=/go/src/mvdan.cc/sh
ARG MODULE_VERSION=2.6.4
ARG GITHUB_URI=https://github.com/mvdan/sh.git
ARG BUILD_DIR=./cmd/shfmt
ARG SRC_PATH=/root/shfmt-src

WORKDIR /home/user/shfmt-src

RUN set -x && \
    apk add --no-cache git=2.20.3-r0 && \
    git clone ${GITHUB_URI} ./ && \
    git checkout a3dcc70 && \
    mkdir -p /go/src/mvdan.cc/sh && \
    cp -R . /go/src/mvdan.cc/sh && \
    CGO_ENABLED=0 go install -ldflags '-w -s -extldflags "-static"' mvdan.cc/sh/cmd/shfmt

# Do apt-get and pip-based installs
FROM base AS tools

WORKDIR /home/user
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
      clang-format \
      vim \
      xsel \
      python3-setuptools \
      python3-wheel \
      python3-pip && \
    sudo -H pip3 install compiledb && \
    sudo chmod o+w /usr/local/lib/python3.7/dist-packages/bashlex && \
    sudo apt-get remove -y \
      python3-setuptools \
      python3-wheel \
      python3-pip && \
    sudo apt-get autoremove -y && \
    sudo apt-get clean

# Create a symlink so it becomes easier to run the binary...
RUN sudo ln -s /line-collision-detector/linc-out/linc/linc /usr/bin/run

COPY .gitconfig /home/user/.gitconfig
COPY .vimrc /home/user/.vimrc
COPY .bashrc /home/user/.bashrc
COPY --from=shfmt-builder /go/bin/shfmt /bin/shfmt

WORKDIR /
