# A docker container to run Deadlock Windows dedicated server

A temporary solution until Valve publishes a Linux build. No working console, all commands must be issued through RCON.
If you are logging in with an account that has Steam Guard enabled use the “Show Steam Guard code” option in the app on your phone and enter this code in your .env

## Instructions
- build the docker image
```
./docker/build-docker-image.sh
```

-  make .env file and edit settings
```
cp env.sample .env
nano .env
...
```

- start the server
```
docker compose up -d
```

- (optional) check docker log
```
docker compose logs -f
```

- shutdown server
```
docker compose down
```


## Files
the server installation will be under `server/Deadlock`, this is where you can add server.cfg and MetaMod with plugins
