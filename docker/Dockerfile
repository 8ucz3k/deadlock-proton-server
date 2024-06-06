FROM cm2network/steamcmd:root

RUN apt-get update && apt-get install -y gosu cron wget python3 libfreetype6

ARG APPID=1422450

ENV STEAM_HOME="/home/${USER}" \
    STEAM_USER="${USER}" \
    STEAM_PATH="/home/${USER}/.steam/steam" \
    APPID=$APPID

RUN mkdir -p ${STEAM_PATH}
WORKDIR ${STEAM_PATH}

# Install Proton build from Glorious Eggroll
ENV PROTON_VERSION=GE-Proton9-5

RUN mkdir -p compatibilitytools.d/
RUN wget -O - \
    https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${PROTON_VERSION}/${PROTON_VERSION}.tar.gz \
    | tar -xz -C compatibilitytools.d/
RUN mkdir -p steamapps/compatdata/${APPID}
RUN cp -r compatibilitytools.d/${PROTON_VERSION}/files/share/default_pfx steamapps/compatdata/${APPID}
RUN wget https://buczek.ru/steamclient64.dll
RUN mkdir -p "/home/steam/.steam/steam/steamapps/compatdata/1422450/pfx/drive_c/Program Files (x86)/Steam"
RUN cp steamclient64.dll "/home/steam/.steam/steam/steamapps/compatdata/1422450/pfx/drive_c/Program Files (x86)/Steam/steamclient64.dll"

RUN chown -R ${USER}:${USER} ${STEAM_HOME}

# Export Proton paths
ENV STEAM_COMPAT_CLIENT_INSTALL_PATH=$STEAM_PATH
ENV STEAM_COMPAT_DATA_PATH=${STEAM_PATH}/steamapps/compatdata/${APPID}
ENV PROTON=${STEAM_PATH}/compatibilitytools.d/${PROTON_VERSION}/proton


COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
