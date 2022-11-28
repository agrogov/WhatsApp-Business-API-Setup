#!/usr/bin/env bash

#docker build -t whatsapp-sender .

docker run -i --rm --user=root \
-v /var/run/docker.sock:/var/run/docker.sock \
-v "$(pwd)":/whatsapp-sender \
-e NFS_SHARE_OPTS='nfsvers=4,addr=10.83.1.2,nolock,soft,rw' \
-e WA_DB_HOSTNAME='' \
-e WA_DB_PORT='3306' \
-e WA_DB_USERNAME='root' \
-e WA_DB_PASSWORD='mysqlpass' \
-e SERVER_IP="$(hostname -i | awk '{print $1}')" \
-e EXTERNAL_HOSTNAME="${SERVER_IP}" \
-e HOST="$(hostname | awk '{split($0,a,"."); print a[1]}')}" \
-e WA_SERVICES='wacore cadvisor node-exporter' \
morgulio/whatsapp-sender:latest
