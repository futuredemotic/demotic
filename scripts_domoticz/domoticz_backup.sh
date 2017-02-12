#!/bin/bash
    # LOCAL/FTP/SCP/MAIL PARAMETERS
    SERVER="xxx.xxxxxxxxxxx.xx"   # IP of Network disk, used for ftp
    USERNAME="xxxxxxxxxxx"         # FTP username of Network disk used for ftp
    PASSWORD="xxxxxxxxxxx"         # FTP password of Network disk used for ftp
    DESTDIR="/opt/backup"   # used for temorarily storage
    DOMO_IP="192.168.xxx.xxx"  # Domoticz IP 
    DOMO_PORT="8080"        # Domoticz port 
    LOGFILE="domoticz.txt"

    ### END OF USER CONFIGURABLE PARAMETERS
    TIMESTAMP=`/bin/date +%Y%m%d%H%M%S`
    BACKUPFILE="domoticz_$TIMESTAMP.db" # backups will be named "domoticz_YYYYMMDDHHMMSS.db.gz"
    BACKUPFILEGZ="$BACKUPFILE".gz
    BACKUPFILEDIR="domoticz_www_$TIMESTAMP.tar.gz" # Change the xxx to yours
    BACKUPFILEDIR2="domoticz_scripts_$TIMESTAMP.tar.gz" # Change the xxx to yours
    
    ### Stop Domoticz, create backup, ZIP it and start Domoticz again
    /usr/bin/curl -s http://$DOMO_IP:$DOMO_PORT/backupdatabase.php > /tmp/$BACKUPFILE
    /bin/cp /tmp/$LOGFILE /tmp/"$LOGFILE_$TIMESTAMP"
    tar -zcvf /tmp/$BACKUPFILEDIR /home/pi/domoticz/www/   # Change the xxx to yours    # Or try /home/pi/domoticz/
    tar -zcvf /tmp/$BACKUPFILEDIR2 /home/pi/domoticz/scripts/   # Change the xxx to yours    # Or try /home/pi/domoticz/
    service domoticz.sh restart
    gzip -9 /tmp/$BACKUPFILE
    

    ### Send to Network disk through FTP
    curl -s --disable-epsv -v -T"/tmp/$BACKUPFILEGZ" -u"$USERNAME:$PASSWORD" "ftp://$SERVER/xxx.xxxxxxxxxxx.xx/demotic/backup/"
    curl -s --disable-epsv -v -T"/tmp/$LOGFILE_$TIMESTAMP" -u"$USERNAME:$PASSWORD" "ftp://$SERVER/xxx.xxxxxxxxxxx.xx/demotic/backup/"
    curl -s --disable-epsv -v -T"/tmp/$BACKUPFILEDIR" -u"$USERNAME:$PASSWORD" "ftp://$SERVER/xxx.xxxxxxxxxxx.xx/demotic/backup/"  # Change the ftp to yours !!!
    curl -s --disable-epsv -v -T"/tmp/$BACKUPFILEDIR2" -u"$USERNAME:$PASSWORD" "ftp://$SERVER/xxx.xxxxxxxxxxx.xx/demotic/backup/"  # Change the ftp to yours !!!
    ### Remove temp backup file
    /bin/rm /tmp/$BACKUPFILEGZ
    /bin/rm /tmp/$LOGFILE_$TIMESTAMP
    /bin/rm /tmp/$BACKUPFILEDIR
    /bin/rm /tmp/$BACKUPFILEDIR2
    ### Done!
