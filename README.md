## Usage
Use makefile: <br/>
```make [help | up | down | cleanup]```

1. Start the local environment (Docker) ````make up````
2. Shutdown the local environment (Docker) ````make down````
3. Remove all containers and images (Docker) ````make cleanup````

### Makefile 
| Command        | Description           |
| ------------- |:-------------:|
| up      | start docker container |
| down      | stop docker container      |
| cleanup | remove all containers and images  |

# Docker Compose Connect Setup

This docker compose example allows you to run a dockerized version of daml
connect building blocks for a participant node including a local domain. So far, 
it contains
- connect node with ledger api on 4011
- a local domain (not exposed outside of the docker environment) 
- navigator at http://localhost:4000
- json api at http://localhost:4001
- trigger service at http://localhost:4002
- a postgres database at port 4032

## Configuring

The deployment can be customized using the directory `data`. You can amend the Canton configuration using the 
configuration mixin in `data/canton/config.canton` or the configuration file `data/canton/participant.conf`. However,
do not change the ports, as some node services depend on it.

There are a few environment variables that control the versions used:
```
    CANTON_VERSION=2.3.2
    SDK_VERSION=2.3.2
    CANTON_TYPE=open-source    
```
You can set them before starting up to define which docker images will be used in your deployment.

### Parties and Domain Connections

The simplest way to define parties and domain connections is to configure them using environment variables.
You can allocate new parties by defining an environment variable (party hints separated using `;`)
```
    CANTON_ALLOCATE_PARTIES="alice;bob"
```
and you can set domain connections (also separated using `;`) 
```
    CANTON_CONNECT_DOMAINS="domain1#http://localhost:10018"
```

Please note that the domain connections will get the priority equivalent to their
position in the environment string. Therefore, the most important domain should be mentioned last.
You need to separate the alias from the URL using '#'.   

Docker-compose will let you define environment variables using an `.env` file in the working directory. 
However, be careful to not use quotes "" in such a file, as the quotes will be escaped and added to the 
string.

Parties and domain connections can also be configured in `data/canton/bootstrap.canton`. 

### Exposed Ports

You can define the exposed ports using the environment variable `BASE_PORT`. The default value is 40. 
As a result, the ports exposed on the host machine will be at `BASE_PORT + "x"`:
- Ledger Api at `BASE_PORT + 11, default 4011`
- Admin Api at `BASE_PORT + 12, default 4012`
- JSON Api at `BASE_PORT + 01, default 4001`
- Trigger Service at `BASE_PORT + 02, default 4002`
- Navigator at `BASE_PORT + 00, default 4000`
- Postgres at  `BASE_PORT + 32, default 4032` 

This way, you can run several deployments on the same host.

### Dars

Dars will automatically be uploaded if placed in the directory `data/dars`. If you need to upload
a DAR on a running system, use the Canton console to connect to the participant and run
```
    myparticipant.dars.upload("<filename>")
```
### Static Content

You can drop your static content to `data/static-content` and access it on the JSON API using `localhost:4001/static`.

## Starting

Enter the example directory where you find the `docker-compose.yml` and run the compose 
commands there: `docker-compose up`

Please note that the Docker user must be able to write to the `data` directory (and its subdirectories).
If you just need to fix the permissions for a demo, you can use ``chmod -R 777 data``

### Triggers

In order to start triggers, you can use the small helper utilities:

```
    ./utils/trigger_upload_dar.sh <darfile>
```

and
 
```
    ./utils/trigger_start.sh dars/CantonExamples.dar alice "testtrigger:digger"
```

### JSON Api

There are a few jwt tokens generated on the fly for all local parties which can be used to access the JSON api.

```
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $(cat shared/alice.jwt)" localhost:4001/v1/query
```

## Inspecting

You can access the Canton console using the `bin/node-console.sh` script. 

## Resetting

The postgres data is stored on the Docker pgdata volume. You need to wipe this Docker volume to reset your deployment.

A quick and easy way to reset the entire deployment is to prune the volumes and containers:

`docker container prune -f && docker volume prune -f`

You can also remove everything, including any downloaded image:

`docker system prune -a`


## Remote Administration

Canton allows you to connect domains, add parties, and add new DAML application DARs at runtime.
The nodes expose an admin-api and canton itself can be used as a client to perform these actions remotely.

[`remote.conf`](./remote.conf) contains configuration to point a local client at these remote nodes. We can launch a canton container with this config to start an interactive console using:

```sh
docker run --network host -it --rm -v "./data/canton/remote:/canton/remote" digitalasset/canton-open-source:2.3.2 --config canton/remote/participant1.conf,canton/remote/domain1.conf
```

You can access the Canton console using the `bin/node-console.sh` script. 

## Remote Deployment

e.g.
daml ledger upload-dar --host <ledger_api_host> --port <ledger_api_port> ${CI_PROJECT_DIR}/daml-ledger-0.0.1.dar

daml ledger upload-dar --host localhost --port 4011 data/dar/voting-0.0.1.dar