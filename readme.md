# Battlefield 1942 server in docker

## Requirements
 - docker
 - docker-compose

## Build
```
docker build -t bf1942 .
```

## Ports
 - 14567/udp
 - 15667/tcp
 - 22000/udp
 - 23000/udp

## Run
```
docker-compose up bf1942
```

## Multiple servers (not tested)
```
docker-compose up -p 14568:14567/udp bf1942
docker-compose up -p 14569:14567/udp bf1942
```

## Configuration
Changes in mods folder are persistent.  

Settings can be changed using nano.  
Example:
```
docker-compose run bf1942 bash
nano /bf1942/mods/bf1942/settings/serversettings.con
```

Reset mods folder (admins, mods, maps, settings, etc.)  
**USE WITH CARE**
```
docker-compose down --volumes
```
