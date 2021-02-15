# Copyright 2021 Sean Kelleher. All rights reserved.
# Use of this source code is governed by an MIT
# licence that can be found in the LICENCE file.

FROM node:15.5.1-alpine3.10

RUN \
    apk add \
        --update \
        --no-cache \
        git \
        make \
    && npm install \
        --global \
        markdownlint-cli@0.26.0
