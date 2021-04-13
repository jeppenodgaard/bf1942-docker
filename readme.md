# Battlefield 1942 server

## Requirements
 - docker
 - docker-compose

## Build
```
docker build -t bf1942 .
```

## Ports
14567/udp 15667/udp 22000/udp 23000/udp

## Run
```
docker-compose run bf1942
```

## Multiple servers
```
docker-compose run -p 14568:14567/udp bf1942
docker-compose run -p 14569:14567/udp bf1942
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
