#!/bin/bash

source /settings.sh

# init env
BFSM=${BFSM:-}

cd /bf1942

if [[ "${BFSM}" != "" ]]; then
    # start bfsm
    ./bfsmd -port 15667 -adminlog -nodelay -restart -start -noadmin
else
    # start server
    ./bf1942_lnxded +statusMonitor 1
fi
