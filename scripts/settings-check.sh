#!/bin/bash

source /settings.sh

# set custom settings
test -n "${BF_SERVER_NAME}" || { echo "BF_SERVER_NAME not set"; exit 1; }
test -n "${BF_SERVER_PASSWORD}" || { echo "BF_SERVER_NAME not set (leave empty for no password)" && exit 1; }
test -n "${BF_SERVER_WELCOME}" && echo "BF_SERVER_WELCOME not set"
test -n "${BFSM_PASSWORD}" || { echo "BFSM_PASSWORD not set" && exit 1; }
