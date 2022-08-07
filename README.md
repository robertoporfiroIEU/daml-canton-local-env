# canton-locally

## Usage
Use makefile: <br/>
```make [help | up | down | clear]```

1. Start the local environment (Docker) ````make up````
2. Shutdown the local environment (Docker) ````make down````

### Makefile 
| Command        | Description           |
| ------------- |:-------------:|
| up      | start docker container |
| down      | stop docker container      |
| clear | remove all containers and images  |

## Remote Administration

Canton allows you to connect domains, add parties, and add new DAML application DARs at runtime.
The nodes expose an admin-api and canton itself can be used as a client to perform these actions remotely.

[`remote.conf`](./remote.conf) contains configuration to point a local client at these remote nodes. We can launch a canton container with this config to start an interactive console using:

```sh
docker run --network host -it --rm -v "./data/canton/remote:/canton/remote" digitalasset/canton-open-source:2.3.2 --config canton/remote/participant1.conf,canton/remote/domain1.conf
```

You can access the Canton console using the `bin/node-console.sh` script. 