#!/usr/bin/env bash

#docker build -t whatsapp-monitoring .

mkdir -p /root/whatsapp-sender

docker run -i --rm --user=root \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/whatsapp-sender:/whatsapp-monitoring \
-e WA_DB_HOSTNAME='db.host.ip' \
-e WA_DB_PORT='5432' \
-e WA_DB_USERNAME='root' \
-e WA_DB_PASSWORD='mysqlpass' \
-e WA_WEB_ENDPOINT='https.wa-lb.ip' \
-e WA_WEB_USERNAME='admin' \
-e WA_WEB_PASSWORD='webapp.changed.password' \
-e WA_CORE_ENDPOINT="https.wa-lb.ip" \
-e GF_SECURITY_ADMIN_PASSWORD='monitor' \
morgulio/whatsapp-monitoring:latest
