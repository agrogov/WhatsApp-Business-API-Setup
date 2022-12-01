#!/usr/bin/env bash

#docker build -t whatsapp-sender .

mkdir -p /root/whatsapp-sender

docker run -i --rm --user=root \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/whatsapp-sender:/whatsapp-sender \
-e NFS_SHARE_OPTS='nfsvers=3,addr=10.83.1.2,nolock,hard,retrans=3,timeo=600,resvport,rw' \
-e WA_DB_HOSTNAME='db.host.ip' \
-e WA_DB_PORT='5432' \
-e WA_DB_USERNAME='root' \
-e WA_DB_PASSWORD='mysqlpass' \
-e SERVER_IP="$(hostname -i | awk '{print $1}')" \
-e EXTERNAL_HOSTNAME="$(hostname -i | awk '{print $1}')" \
-e HOST="$(hostname | awk '{split($0,a,"."); print a[1]}')}" \
-e WA_SERVICES='master cadvisor node-exporter' \
#-e WA_SERVICES='wacore cadvisor node-exporter' \
#-e WA_SERVICES='waweb cadvisor node-exporter' \
morgulio/whatsapp-sender:latest
