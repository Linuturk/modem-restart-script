#!/usr/bin/env bash

LOG="~/.modemCheck.log"
HOST="192.168.100.1"

# Test for connectivity
curl -m 5 -s $HOST/indexData.htm &> /dev/null

if [ $? -eq 0 ]; then
    # Check modem for Failed status.
    FAILED="$(curl -m 5 -s $HOST/indexData.htm | grep '<TD>' | grep 'Failed')"
    UPTIME="$(curl -s $HOST/indexData.htm | grep 'days' | sed -e 's/    <TD>//g' | sed -e 's/<\/TD><\/TR>//g')"
    if [ "$FAILED" = "" ]; then
        echo "[$(date)] The modem is operational. Uptime: $UPTIME" >> $LOG
    else
        echo "[$(date)] Modem Failure. Restarting modem. Uptime was: $UPTIME" >> $LOG
        curl -m 5 -s $HOST/reset.htm?reset_modem="Restart Cable Modem" &> /dev/null
        echo "[$(date)] Modem restarted." >> $LOG
    fi
else
    echo "[$(date)] No network connectivity." >> $LOG
    exit 1
fi
