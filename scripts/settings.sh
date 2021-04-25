#!/bin/bash

SETTINGS="/bf1942/mods/bf1942/settings"
SERVER_AUTOEXEC="${SETTINGS}/serverautoexec.con"
SERVER_MANAGER="${SETTINGS}/servermanager.con"
SERVER_SETTINGS="${SETTINGS}/serversettings.con"

function settings_set()
{
    echo "Set ${1} to ${2}"
    for f in ${SERVER_MANAGER} ${SERVER_SETTINGS}; do
        sed -i "s/${1} .*/${1} ${2}/g" "${f}"
    done
}

# initial settings (run once)
if grep "BFSERVER" $SERVER_MANAGER > /dev/null; then

    # prompt user for unique settings
    echo 'Enter settings (press ctrl+c to cancel/restart)'
    read -p 'Choose server name: ' server_name
    read -p 'Choose server password (leave empty for no password): ' server_password
    read -p 'Choose server message: ' server_message
    read -p 'Choose admin password: ' admin_password
    read -p 'Press enter to continue..' dummy

    # add a map so server can start
    printf "game.addLevel battleaxe GPM_CQ bf1942\ngame.setCurrentLevel battleaxe GPM_CQ bf1942" > "${SETTINGS}/maplist.con"
    cp "${SETTINGS}/maplist.con" "${SETTINGS}/servermaplist.con"

    # fix gamespy
    echo "94.23.196.155 master.gamespy.com # bf1942 gamespy" >> /etc/hosts

    # set settings according to bf-league
    settings_set "game.serverName" "\"${server_name}\""
    settings_set "game.serverPassword" "\"${server_password}\""
    settings_set "game.setServerWelcomeMessage 0" "\"${server_message}\""
    settings_set "manager.consolePassword" "\"${admin_password}\""
    settings_set "game.serverDedicated" 1
    settings_set "game.serverGameTime" 20
    settings_set "game.serverMaxPlayers" 32
    settings_set "game.serverScoreLimit" 0
    settings_set "game.serverInternet" 1
    settings_set "game.serverNumberOfRounds" 5
    settings_set "game.serverSpawnTime" 20
    settings_set "game.serverSpawnDelay" 3
    settings_set "admin.spawnWaveTime" 3
    settings_set "game.serverGameStartDelay" 20
    settings_set "game.serverGameRoundStartDelay" 10
    settings_set "game.serverSoldierFriendlyFire" 100
    settings_set "game.serverVehicleFriendlyFire" 100
    settings_set "game.serverTicketRatio" 100
    settings_set "game.serverAlliedTeamRatio" 1
    settings_set "game.serverAxisTeamRatio" 1
    settings_set "game.serverCoopAiSkill" 50
    settings_set "game.serverCoopCpu" 100
    settings_set "game.serverReservedPassword" ""
    settings_set "game.serverNumReservedSlots" 0
    settings_set "game.serverBandwidthChokeLimit" 0
    settings_set "game.serverMaxAllowedConnectionType" CTLanT1
    settings_set "game.serverAllowNoseCam" 1
    settings_set "game.serverFreeCamera" 0
    settings_set "game.serverExternalViews" 1
    settings_set "game.serverAutoBalanceTeams" 0
    settings_set "game.serverNameTagDistance" 100
    settings_set "game.serverNameTagDistanceScope" 300
    settings_set "game.serverKickBack" 0.000000
    settings_set "game.serverKickBackOnSplash" 0.000000
    settings_set "game.serverSoldierFriendlyFireOnSplash" 100
    settings_set "game.serverVehicleFriendlyFireOnSplash" 100
    settings_set "game.serverPort" 14567
    settings_set "game.gameSpyLANPort" 22000
    settings_set "game.gameSpyPort" 23000
    settings_set "game.ASEPort" 14690
    settings_set "game.serverHitIndication" 1
    settings_set "game.serverTKPunishMode" 1
    settings_set "game.serverCrossHairCenterPoint" 1
    settings_set "game.serverDeathCameraType" 0
    settings_set "game.serverContentCheck" 0
    settings_set "game.serverEventLogging" 1
    settings_set "game.serverEventLogCompression" 0
    settings_set "game.objectiveAttackerTicketsMod" 100
    settings_set "game.serverPunkBuster" 1
    settings_set "game.serverUnpureMods" ""

fi

# runtime settings
LOCAL_IP=$(hostname -I | xargs)
settings_set "game.serverIP" "${LOCAL_IP}"
