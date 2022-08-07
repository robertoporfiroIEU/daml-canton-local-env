#
# Copyright (c) 2019, Digital Asset (Switzerland) GmbH and/or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#

FROM ubuntu:20.04

ARG sdk_version=2.3.2

RUN useradd -ms /bin/bash sdk

#COPY ui-backend.conf frontend-config.js /home/sdk/
COPY install-daml.sh /home/sdk/
RUN chown sdk /home/sdk/install-daml.sh
RUN /bin/bash -c "apt-get update --no-show-upgraded && apt-get install wget openjdk-11-jdk -y"

USER sdk
WORKDIR /home/sdk
RUN /home/sdk/install-daml.sh ${sdk_version}

ENV PATH=$PATH:/home/sdk/.daml/bin