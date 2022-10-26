#!/bin/sh
# /etc/crontab
# * *	* * *	sql_viewer	/sql_viewer/scripts/green.sh
# chmod +x /sql_viewer/scripts/green.sh

mysql -B -N -u sql_user -ppasswd dbname -e "select id from pc where (UNIX_TIMESTAMP(NOW()) + 14400 - UNIX_TIMESTAMP(ttl_answ)) < 300;" | sed "s/$/,/" | tr -d '\n' | sed "s/,$//"| awk '{printf "["$1"]"}' > /tmp/green.json

scp -q /tmp/green.json backup:statAndAdm/
