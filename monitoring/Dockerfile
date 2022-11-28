FROM docker:19.03.15-alpine3.13

ENV WA_API_VERSION='2.41.3' \
    WA_DB_HOSTNAME='' \
    WA_DB_PORT='3306' \
    WA_DB_USERNAME='' \
    WA_DB_PASSWORD='' \
    WA_WEB_ENDPOINT='' \
    WA_WEB_USERNAME='' \
    WA_WEB_PASSWORD='' \
    WA_CORE_ENDPOINT=$WA_WEB_ENDPOINT \
    GF_SECURITY_ADMIN_PASSWORD='' \
    HOME_APP='/whatsapp-monitoring'

RUN apk add --update docker-compose \
    && docker-compose --version

COPY docker-compose.yml start.sh /opt/app/

VOLUME ${HOME_APP}

WORKDIR /opt/app
CMD ./start.sh ${WA_SERVICES}
