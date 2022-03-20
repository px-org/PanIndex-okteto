#!/bin/bash
version="$PAN_INDEX_VERSION"
export TZ=Asia/Shanghai
export DB_TYPE=postgres
export DATABASE_URL="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRESQL_HOST}:5432/${POSTGRES_DB}"
if [ "$version" = "" ]
then
    version=`curl --silent "https://api.github.com/repos/libsgh/PanIndex/releases" \
        | grep '"tag_name":' \
        | sed -E 's/.*"([^"]+)".*/\1/'`
fi
curl -sOL "https://github.com/libsgh/PanIndex/releases/download/${version}/PanIndex-linux-amd64.tar.gz"
tar --same-owner -zxf "PanIndex-linux-amd64.tar.gz"
rm -rf README.md LICENSE
mv PanIndex-linux-amd64 PanIndex
chmod +x PanIndex
/app/PanIndex