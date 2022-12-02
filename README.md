# Whatsapp Business API deployment Docker image for Google Cloud

To run use `deployment/run.sh` and `monitoring/run.sh` scripts or commands below.

Meta documentation for sender deployment: https://developers.facebook.com/docs/whatsapp/on-premises/get-started/installation
Network requirements: https://developers.facebook.com/docs/whatsapp/guides/network-requirements/

Based on Meta's scripts: https://github.com/WhatsApp/WhatsApp-Business-API-Setup-Scripts

## Whatsapp sender deployment run on CentOS7
```bash
yum update -y
yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce-19.03.15-3.el7

systemctl start docker
systemctl enable docker

mkdir -p /root/whatsapp-sender

docker volume create --driver local \
    --opt type=none \
    --opt device=/root/whatsapp-sender \
    --opt o=bind whatsappData

docker run -i --rm --user=root \
-v /var/run/docker.sock:/var/run/docker.sock \
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
```

## Whatsapp monitoring run on CentOS7
```bash
yum update -y
yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce-19.03.15-3.el7

systemctl start docker
systemctl enable docker

mkdir -p /root/whatsapp-monitoring

docker run -i --rm --user=root \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/whatsapp-monitoring:/whatsapp-monitoring \
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
```

## Whatsapp sender deployment run on Container Optimized OS
```bash
docker volume create --driver local \
    --opt type=none \
    --opt device=/mnt/stateful_partition/whatsapp-sender \
    --opt o=bind whatsappData

docker run -i --rm --user=root \
-v /var/run/docker.sock:/var/run/docker.sock \
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
```
