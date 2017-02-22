#!/usr/bin/env python

import smtplib
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email.MIMEBase import MIMEBase
from email import encoders

fromaddr = ""
tuapass = ""
toaddr = "c"
soggetto = "NOT REPLY"
body = "Ciao sono il raspberry dei DEMOTIC!"
#nomefile = "NOME DEL FILE DA MANDARE COMPLETO DI ESTENSIONE"
# Esempio: report.txt
#percfile = "PERCORSO ASSOLUTO DEL FILE DA MANDARE"
# Esempio: /tmp/report.txt

msg = MIMEMultipart()

msg['From'] = fromaddr
msg['To'] = toaddr
msg['Subject'] = soggetto


server = smtplib.SMTP('smtp.gmail.com', 587)
server.starttls()
server.login(fromaddr, tuapass)
text = "Ciao sono i raspberry di DEMOTIC"
server.sendmail(fromaddr, toaddr, text)
server.quit()
