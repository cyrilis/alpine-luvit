#
# Luvit v2.9.1
#

FROM alpine:latest
MAINTAINER Cyril Hou <houshoushuai@gmail.com>

#
# Pkg
#

WORKDIR /tmp
RUN apk update && \
    apk upgrade && \
    apk add --update git perl build-base cmake linux-headers curl && \
    git clone --recursive https://github.com/luvit/luvi.git && \
    cd luvi && \
    make regular-asm test && \
    mkdir ~/bin && \
    install build/luvi /usr/local/bin && \
    cd && curl https://lit.luvit.io/packages/luvit/lit/latest.zip -O && \
    luvi latest.zip -- make latest.zip /usr/local/bin/lit /usr/local/bin/luvi && \
    echo '#!/usr/local/bin/luvi --' > prefix && \
    lit make lit://luvit/lit /usr/local/bin/lit prefix && \
    lit make lit://luvit/luvit /usr/local/bin/luvit prefix && \
    apk del git perl build-base && \
    rm -rf /tmp/luvi && \
    cd && rm latest.zip
