ARG REPOSITORY="docker.io"
FROM ${REPOSITORY}/library/debian:bookworm-slim
LABEL org.opencontainers.image.authors="deB4SH @ github"
#build arguments
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH
RUN printf "I'm building for TARGETPLATFORM=${TARGETPLATFORM}" \
    && printf ", TARGETARCH=${TARGETARCH}" \
    && printf ", TARGETVARIANT=${TARGETVARIANT} \n" \
    && printf "With uname -s : " && uname -s \
    && printf "and  uname -m : " && uname -m
#install required packages
RUN apt update \
    && apt install -y curl wget unzip gpg git nodejs
# install helm
RUN wget -O helm.tar.gz https://get.helm.sh/helm-v3.18.6-linux-${TARGETARCH}.tar.gz \
    && tar -xvzf helm.tar.gz \
    && mv linux-${TARGETARCH}/helm /usr/local/bin/helm
# install yq
RUN wget -O /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.47.1/yq_linux_${TARGETARCH}   \ 
    && chmod +x /usr/local/bin/yq
#clean up leftovers
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*
