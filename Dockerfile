FROM ubuntu:20.04 AS build

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
    python3-pip \
    unrar-free \
    unzip \
    wget \
    xz-utils

RUN pip3 -q install \
    gdown

# Server from LinuxGSM
WORKDIR /bf1942
RUN echo "Installing bf1942 1.612 server" && \
    wget -q 'http://linuxgsm.download/BattleField1942/bf1942_lnxded-1.61-hacked-to-1.612.full.tar.xz' && \
    tar -xf 'bf1942_lnxded-1.61-hacked-to-1.612.full.tar.xz' && \
    rm 'bf1942_lnxded-1.61-hacked-to-1.612.full.tar.xz'

# Patched binaries from Arkyliën/Henk
WORKDIR /bf1942_lnxded
RUN echo "Installing bf1942_lnxded patches" && \
    gdown -q 'https://drive.google.com/uc?id=1KllDkPW4CXsnj6sblldbSPZJWy9ObbND' && \
    unzip 'bf1942_lnxded_patched.zip' > /dev/null && \
    mv -f bf1942_lnxded_patched/bf1942_lnxded* /bf1942

# Maps from Doubti/Mourits Google Drive
WORKDIR /maps
RUN echo "Installing custom maps" && \
    gdown -q https://drive.google.com/uc?id=1N1fA0V02lpU3UiO6KtoxZ4TAnbFKn4PL && \
    unzip 'all-server-maps.zip' > /dev/null && \
    cp -R all-server-maps/* /bf1942/mods/bf1942/archives/bf1942/levels/

# BFSM from https://www.bf-games.net/downloads/204/bf-server-manager-21-linux.html
WORKDIR /bfsmd
RUN echo "Installing BFSM" && \
    wget -q 'https://www.bf-games.net/downloads/mirror/902' -O 'BFServerManager201.tgz' && \
    tar -xvf 'BFServerManager201.tgz' > /dev/null && \
    cp bfsmd /bf1942/bfsmd && \
    cp *.con /bf1942/mods/bf1942/settings/

# PB from BF-League Google Drive
WORKDIR /pb
RUN echo "Fixing Punk Buster"; \
    gdown -q https://drive.google.com/uc?id=0BxvRmo2i0njkTENkU3RhTU1UWHM && \
    unrar 'pb-linuxserver-files.rar' > /dev/null && \
    cd pb-serverfiles && \
    cp -R dll htm *.cfg *.so /bf1942/pb/

FROM ubuntu:20.04

# PORTS: Server, ASE, BFSM, GameSpy LAN, and GameSpy
EXPOSE 14567/udp 14690/udp 15667/udp 22000/udp 23000/udp

COPY --from=build /bf1942/ /bf1942

RUN dpkg --add-architecture i386 && \
    apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
    libc6:i386 \
    libncurses5:i386 \
    libstdc++5:i386 \
    nano

WORKDIR /
ADD scripts/* /
RUN chmod +x /*.sh

CMD /start.sh
