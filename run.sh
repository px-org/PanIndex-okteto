#!/bin/bash
version="$PAN_INDEX_VERSION"
export TZ=Asia/Shanghai
export DB_TYPE=postgres
export DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRESQL_HOST}:5432/${POSTGRES_DB}"
if [ "$version" = "" ]
then
    TAG_URL="https://api.github.com/repos/libsgh/PanIndex/releases"
    version="$(curl ${PROXY} \
        -H "Accept: application/json" \
        -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:74.0) Gecko/20100101 Firefox/74.0" \
        -s "${TAG_URL}" --connect-timeout 20 | awk -F'[ "]+' '$0~"tag_name"{print $4;exit}' )"
fi
env
echo ${version}
curl -sOL "https://github.com/libsgh/PanIndex/releases/download/${version}/PanIndex-linux-amd64.tar.gz"
tar --same-owner -zxf "PanIndex-linux-amd64.tar.gz"
rm -rf README.md LICENSE
mv PanIndex-linux-amd64 PanIndex
chmod +x PanIndex
/app/PanIndex