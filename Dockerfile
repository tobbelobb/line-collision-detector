# Build shfmt
FROM golang:1.12-alpine3.9 AS shfmt-builder

ARG SRC_PATH=/go/src/mvdan.cc/sh
ARG MODULE_VERSION=2.6.4
ARG GITHUB_URI=https://github.com/mvdan/sh.git
ARG BUILD_DIR=./cmd/shfmt
ARG SRC_PATH=/root/shfmt-src

WORKDIR /home/user/shfmt-src

RUN set -x && \
    apk add --no-cache git=2.20.4-r0 && \
    git clone ${GITHUB_URI} ./ && \
    git checkout a3dcc70 && \
    mkdir -p /go/src/mvdan.cc/sh && \
    cp -R . /go/src/mvdan.cc/sh && \
    CGO_ENABLED=0 go install -ldflags '-w -s -extldflags "-static"' mvdan.cc/sh/cmd/shfmt

# Confirmed to work with
# gcc:10.1.0
FROM gcc:latest AS tools
MAINTAINER Torbjørn Ludvigsen (tobben@hangprinter.org)

# Setup a user with no-password sudo
USER root
RUN useradd -ms /bin/bash user
RUN apt-get update && apt-get install -y --no-install-recommends sudo && \
    echo "user ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/dont-prompt-user-for-password
USER user

WORKDIR /home/user
RUN \
echo "# llvm" | sudo tee --append /etc/apt/sources.list && \
echo "deb http://apt.llvm.org/buster/ llvm-toolchain-buster-10 main" | sudo tee --append /etc/apt/sources.list && \
echo "deb-src http://apt.llvm.org/buster/ llvm-toolchain-buster-10 main" | sudo tee --append /etc/apt/sources.list && \
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add - && \
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
      clang-format-10 \
      clang-tidy-10 \
      clang++-10 \
      vim \
      xsel \
      gdb \
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

# build with clang++-10 since build2 fails to build with gcc v10.1.0
RUN sudo curl -sSfO https://download.build2.org/0.12.0/build2-install-0.12.0.sh && \
    sudo sh build2-install-0.12.0.sh --yes --trust yes --cxx clang++-10 && \
    sudo rm -rf build2-toolchain-0.12.0.tar.xz build2-toolchain-0.12 build2-install-0.12.0.sh


# Create a symlink so it becomes easier to run the binary...
RUN sudo ln -s /line-collision-detector/linc/linc/linc /usr/bin/run

COPY .gitconfig /home/user/.gitconfig
COPY .vimrc /home/user/.vimrc
COPY .bashrc /home/user/.bashrc
COPY .gdbinit /home/user/.gdbinit
COPY --from=shfmt-builder /go/bin/shfmt /bin/shfmt

WORKDIR /
