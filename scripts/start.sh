#!/bin/bash

source /settings.sh

# init env
BFSM=${BFSM:-}
LOCAL_IP=$(hostname -I | xargs)

# init settings
settings_set "game.serverIP" "${LOCAL_IP}"

cd /bf1942

if [[ "${BFSM}" != "" ]]; then
    # start bfsm
    ./bfsmd -port 15667 -adminlog -nodelay -restart -start -noadmin
else
    # start server
    ./bf1942_lnxded +statusMonitor 1
fi
