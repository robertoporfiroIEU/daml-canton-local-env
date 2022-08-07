#!/bin/bash
# Copyright (c) 2022 Digital Asset (Switzerland) GmbH and/or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

docker-compose exec connect.node ./bin/canton -c data/canton/remote/participant1.conf,data/canton/remote/domain1.conf
