# Battlefield 1942 server

## Requirements
 - docker
 - docker-compose

## Build
docker build -t bf1942 .

## Ports
14567/udp 14690/udp 15667/udp 22000/udp 23000/udp

## Run
docker-compose run bf1942

## Multiple servers
docker-compose run -p 14568:14567/udp bf1942
docker-compose run -p 14569:14567/udp bf1942

## Configuration
Changes in mods folder are persistent.
