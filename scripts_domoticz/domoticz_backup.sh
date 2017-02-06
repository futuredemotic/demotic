#!/bin/bash
    # LOCAL/FTP/SCP/MAIL PARAMETERS
    SERVER="ftp.sparchitettura.org"   # IP of Network disk, used for ftp
    USERNAME="4916475@aruba.it"         # FTP username of Network disk used for ftp
    PASSWORD="LUNAPORTOS77"         # FTP password of Network disk used for ftp
    DESTDIR="/opt/backup"   # used for temorarily storage
    DOMO_IP="192.168.1.100"  # Domoticz IP 
    DOMO_PORT="8080"        # Domoticz port 
    LOGFILE="domoticz.txt"

    ### END OF USER CONFIGURABLE PARAMETERS
    TIMESTAMP=`/bin/date +%Y%m%d%H%M%S`
    BACKUPFILE="domoticz_$TIMESTAMP.db" # backups will be named "domoticz_YYYYMMDDHHMMSS.db.gz"
    BACKUPFILEGZ="$BACKUPFILE".gz
    
    ### Stop Domoticz, create backup, ZIP it and start Domoticz again
    service domoticz.sh stop
    /usr/bin/curl -s http://$DOMO_IP:$DOMO_PORT/backupdatabase.php > /tmp/$BACKUPFILE
    /bin/cp /tmp/$LOGFILE /tmp/"$LOGFILE_$TIMESTAMP"
    service domoticz.sh start
    gzip -9 /tmp/$BACKUPFILE
    

    ### Send to Network disk through FTP
    curl -s --disable-epsv -v -T"/tmp/$BACKUPFILEGZ" -u"$USERNAME:$PASSWORD" "ftp://$SERVER/www.sparchitettura.org/demotic/backup/"
    curl -s --disable-epsv -v -T"/tmp/$LOGFILE_$TIMESTAMP" -u"$USERNAME:$PASSWORD" "ftp://$SERVER/www.sparchitettura.org/demotic/backup/"
    ### Remove temp backup file
    /bin/rm /tmp/$BACKUPFILEGZ
    /bin/rm /tmp/$LOGFILE_$TIMESTAMP
    ### Done!
