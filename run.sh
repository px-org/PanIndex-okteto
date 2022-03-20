#!/bin/bash
version="$PAN_INDEX_VERSION"
export TZ=Asia/Shanghai
if [ "$version" = "" ]
then
    TAG_URL="https://api.github.com/repos/libsgh/PanIndex/releases"
    version="$(curl ${PROXY} \
        -H "Accept: application/json" \
        -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:74.0) Gecko/20100101 Firefox/74.0" \
        -s "${TAG_URL}" --connect-timeout 20 | awk -F'[ "]+' '$0~"tag_name"{print $4;exit}' )"
fi
env
cat > "/app/config.json" << EOF
{
  "host": "0.0.0.0",
  "port": 5238,
  "log_level": "info",
  "data_path": "/app/data",
  "cert_file": "",
  "key_file": "",
  "config_query": "",
  "db_type": "postgres",
  "dsn": "host=${POSTGRESQL_HOST} user=${POSTGRESQL_USERNAME} password=${POSTGRESQL_PASSWORD} dbname=${POSTGRESQL_DATABASE} port=${DB_SERVICE_PORT} sslmode=require TimeZone=Asia/Shanghai"
}
EOF
curl -sOL "https://github.com/libsgh/PanIndex/releases/download/${version}/PanIndex-linux-amd64.tar.gz"
tar --same-owner -zxf "PanIndex-linux-amd64.tar.gz"
rm -rf README.md LICENSE
mv PanIndex-linux-amd64 PanIndex
chmod +x PanIndex
/app/PanIndex -c=/app/config.json