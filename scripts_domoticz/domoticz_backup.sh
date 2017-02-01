#!/bin/bash
 
    ## LOCAL/FTP/SCP/MAIL PARAMETERS
    SERVER="ft.sparchitettura.org"         # IP of Network disk, used for: ftp mail scp
    USERNAME="4916475@aruba.it"         # FTP username of Network disk used for: ftp mail scp
    PASSWORD="LUNAPORTOS77"               # FTP password of Network disk used for: ftp mail scp
    DESTDIR="/www.sparchitettura.org/demotic/backup"      # used for: local
    DOMO_IP="192.168.1.100"      # Domoticz IP used for all
    DOMO_PORT="8080"         # Domoticz port used for all
    ## END OF USER CONFIGURABLE PARAMETERS
 
    TIMESTAMP=`/bin/date +%Y%m%d%H%M%S`
    BACKUPFILEDIR="domoticz_x_xxx_$TIMESTAMP.tar.gz" # Change the xxx to yours
 
    ### Create backup and ZIP it
    tar -zcvf /tmp/$BACKUPFILEDIR /home/pi/domoticz/xxxx/   # Change the xxx to yours    # Or try /home/pi/domoticz/
 
    ### Send to Network disk through FTP
    curl -s --disable-epsv -v -T"/tmp/$BACKUPFILEDIR" -u"$USERNAME:$PASSWORD" "ftp://$SERVER/media/hdd/Domoticz_backup/"  # Change the ftp to yours !!!
 
    ### Remove temp backup file
    /bin/rm /tmp/$BACKUPFILEDIR
 
    ### Done!