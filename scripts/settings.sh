#!/bin/bash

SETTINGS="/bf1942/mods/bf1942/settings"
SERVER_SETTINGS="${SETTINGS}/serversettings.con"
SERVER_MANAGER="${SETTINGS}/servermanager.con"

function settings_get()
{
    echo "Set ${1} to ${2}"
    sed -i "s|${1} .*|${1} ${2}|g" "${SERVER_SETTINGS}"
    sed -i "s|${1} .*|${1} ${2}|g" "${SERVER_MANAGER}"
}

function settings_set()
{
    echo "Set ${1} to ${2}"
    sed -i "s|${1} .*|${1} ${2}|g" "${SERVER_SETTINGS}"
    sed -i "s|${1} .*|${1} ${2}|g" "${SERVER_MANAGER}"
}
