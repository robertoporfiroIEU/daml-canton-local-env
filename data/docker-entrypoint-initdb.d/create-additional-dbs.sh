#!/bin/bash
# Copyright (c) 2022 Digital Asset (Switzerland) GmbH and/or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

    CREATE DATABASE domain1;
    CREATE DATABASE participant1;
    CREATE DATABASE jsonapi;
    CREATE DATABASE triggers;
    
    GRANT ALL PRIVILEGES ON DATABASE domain1 TO canton;
    GRANT ALL PRIVILEGES ON DATABASE participant1 TO canton;
    GRANT ALL PRIVILEGES ON DATABASE jsonapi TO canton;
    GRANT ALL PRIVILEGES ON DATABASE triggers TO canton;
EOSQL
