#!/bin/bash
chown -R steam:steam /app
chmod a+x /app/start.sh
exec gosu steam /app/start.sh
