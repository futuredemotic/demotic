#!/bin/bash
Tail -fn0 /home/pi/domoticz/Config/OZW_Log.txt | \
While read line; do
Echo "$ line" | Grep NodeXXX. * "$ 1"
If [$? = 0]
Then
Sudo curl -s -i -H "Accept: application / json" "http://192.168.1.100:8080/json.htm?type=command&param=switchlight&idx=$2&switchcmd=$3&level=0&passcode="
Fi
Done