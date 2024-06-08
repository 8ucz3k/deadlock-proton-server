#!/bin/bash

die() {
    echo "$0 script failed, hanging forever..."
    while [ 1 ]; do sleep 10;done
    # exit 1
}

id
if [ "$(id -u)" != "1000" ];then
    echo "script must run as steam"
    die
fi

steamcmd=${STEAM_HOME}/steamcmd/steamcmd.sh

ACTUAL_PORT=27015
if [ "${PORT}" != "" ];then
    ACTUAL_PORT=${PORT}
fi
ARGS="${ARGS}-port ${ACTUAL_PORT}"

if [ "${SERVER_PASSWORD}" != "" ];then
    ARGS="${ARGS} +sv_password ${SERVER_PASSWORD}"
fi
if [ "${MAP}" != "" ];then
    ARGS="${ARGS} +map ${MAP}"
fi

# args
ARGS="-dedicated -console -usercon -ip 0.0.0.0 -convars_visible_by_default -allow_no_lobby_connect -novid ${ARGS}"

DeadlockDir=/app/Deadlock

mkdir -p ${DeadlockDir}
DirPerm=$(stat -c "%u:%g:%a" ${DeadlockDir})
if [ "${DirPerm}" != "1000:1000:755" ];then
    echo "${DeadlockDir} has unexpected permission ${DirPerm} != 1000:1000:755"
    die
fi

set -x
$steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir ${DeadlockDir} +login ${STEAM_LOGIN} ${STEAM_PASSWORD} ${STEAM_2FA_CODE} +app_update ${APPID} validate +quit || die
set +x

DeadlockExe="${DeadlockDir}/game/bin/win64/project8.exe"
if [ ! -f ${DeadlockExe} ];then
    echo "${DeadlockExe} does not exist"
    die
fi

CMD="$PROTON run $DeadlockExe ${ARGS}"
echo "starting server with: ${CMD}"
${CMD}
