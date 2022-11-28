#!/usr/bin/env bash

#docker build -t whatsapp-monitoring .

docker run -i --rm --user=root \
-v /var/run/docker.sock:/var/run/docker.sock \
-v "$(pwd)":/whatsapp-monitoring \
-e WA_DB_HOSTNAME='' \
-e WA_DB_PORT='3306' \
-e WA_DB_USERNAME='root' \
-e WA_DB_PASSWORD='mysqlpass' \
-e WA_WEB_ENDPOINT='http://wa-lb.url:80' \
-e WA_WEB_USERNAME='admin' \
-e WA_WEB_PASSWORD='' \
-e WA_CORE_ENDPOINT="http://wa-lb.url:80" \
-e GF_SECURITY_ADMIN_PASSWORD='monitor' \
morgulio/whatsapp-monitoring:latest
