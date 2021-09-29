#!/bin/bash

openssl_minversion=1.1.0

if echo "$(openssl version|awk '{print $2}')\n${openssl_minversion}" | sort -V | head -1 | grep -q ^${openssl_minversion}$;then
  echo "Host is up to date"
else
        if cat /etc/ca-certificates.conf | grep -e "^mozilla/DST_Root_CA_X3.crt" ;then
                sed -i 's/^mozilla\/DST_Root_CA_X3.crt/!mozilla\/DST_Root_CA_X3.crt/g' /etc/ca-certificates.conf
                update-ca-certificates > /dev/null
                echo "Need fixing. Fixes appended"
        else
                echo "Already fixed"
        fi
fi