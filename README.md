# Whatsapp Business API deployment Docker image for Google Cloud

To run use `deployment/run.sh` and `monitoring/run.sh` scripts or commands below.
Meta documentation for sender deployment: https://developers.facebook.com/docs/whatsapp/on-premises/get-started/installation

Based on Meta's scripts: https://github.com/WhatsApp/WhatsApp-Business-API-Setup-Scripts

## Whatsapp sender deployment run
```bash
docker run -i --rm --user=root \
-v /var/run/docker.sock:/var/run/docker.sock \
-v "$(pwd)":/whatsapp-sender \
-e NFS_SHARE_OPTS='nfsvers=4,addr=10.83.1.2,nolock,soft,rw' \
-e WA_DB_HOSTNAME='db.host.ip' \
-e WA_DB_PORT='3306' \
-e WA_DB_USERNAME='root' \
-e WA_DB_PASSWORD='mysqlpass' \
-e SERVER_IP="$(hostname -i | awk '{print $1}')" \
-e EXTERNAL_HOSTNAME="${SERVER_IP}" \
-e HOST="$(hostname | awk '{split($0,a,"."); print a[1]}')}" \
-e WA_SERVICES='wacore cadvisor node-exporter' \
morgulio/whatsapp-sender:latest
```

## Whatsapp deployment monitoring run
```bash
docker run -i --rm --user=root \
-v /var/run/docker.sock:/var/run/docker.sock \
-v "$(pwd)":/whatsapp-monitoring \
-e WA_DB_HOSTNAME='db.host.ip' \
-e WA_DB_PORT='3306' \
-e WA_DB_USERNAME='root' \
-e WA_DB_PASSWORD='mysqlpass' \
-e WA_WEB_ENDPOINT='http://wa-lb.url:80' \
-e WA_WEB_USERNAME='admin' \
-e WA_WEB_PASSWORD='webapp.changed.password' \
-e WA_CORE_ENDPOINT="http://wa-lb.url:80" \
-e GF_SECURITY_ADMIN_PASSWORD='monitor' \
morgulio/whatsapp-monitoring:latest
```
