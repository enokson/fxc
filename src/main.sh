#!/usr/bin/env bash
TICKER=$1
if [[ $TICKER != "TJS" && $TICKER != "USD" ]]; then
    exit 1
fi

if [[ -z "$2" ]]; then
    DATE=$(date +%F)
else
    DATE=$2
fi

RATE=$(curl --no-progress-meter https://nbt.tj/en/kurs/export_csv.php?date=$DATE | grep "USD" | awk '{print $4}')
#RATE="10.6374"

if [[ $TICKER = "USD" ]]; then
    echo $(printf %.4f $RATE)
else
    RATE=$(perl -e "print 1 / $RATE")
    echo $(printf %.9f $RATE)
fi

