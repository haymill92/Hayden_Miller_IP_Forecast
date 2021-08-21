#!/bin/bash

getlocation()
{
    IPINFO=`curl -s http://ipinfo.io/$1`
    IP=`echo $IPINFO |jq '.ip'`
    IP=`sed -e 's/^"//' -e 's/"$//' <<< "$IP"`
    LOCATION=`echo $IPINFO |jq '.loc'`
    LOCATION=`sed -e 's/^"//' -e 's/"$//' <<< "$LOCATION"`
    CITY=`echo $IPINFO |jq '.city'`
    CITY=`sed -e 's/^"//' -e 's/"$//' <<< "$CITY"`
    IFS=','
    read -a LOCARRAY <<< "$LOCATION"
    LATITUDE=${LOCARRAY[0]}
    LONGITUDE=${LOCARRAY[1]}
    LOCINFO="Weather forecast for $IP ($CITY):"
    echo $LOCINFO
}

getweather()
{
    FORECAST=`curl -s "http://api.openweathermap.org/data/2.5/onecall?lat=$LATITUDE&lon=$LONGITUDE&appid=a95ce5898d5ed605589d10056a233619" |jq -r '.daily[].weather[].description'`
    IFS=$'\n'
    FORECAST=($FORECAST)
    TOMORROW=`date -d '+1 day' +%Y-%m-%d`
    TWODAY=`date -d '+2 day' +%Y-%m-%d`
    THREEDAY=`date -d '+3 day' +%Y-%m-%d`
    TOMORROW="$TOMORROW: ${FORECAST[1]} throughout the day."
    TWODAY="$TWODAY: ${FORECAST[2]} throughout the day."
    THREEDAY="$THREEDAY: ${FORECAST[3]} throughout the day."
    echo $TOMORROW
    echo $TWODAY
    echo $THREEDAY
}

getlocation $1
getweather
