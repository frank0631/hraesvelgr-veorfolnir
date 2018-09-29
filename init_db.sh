#!/usr/bin/env bash
set -o xtrace

DB_HOST=${DB_HOST:-db}
DB_USER=${DB_USER:-root}
DB_PASSWORD=${DB_PASSWORD:-mysql}
DB_DATABASE=${DB_DATABASE:-mysql}

VEOR_HOST=${VEOR_HOST:-db} #fixed
VEOR_USER=${VEOR_USER:-veorfolnir} #fixed
VEOR_PASSWORD=${VEOR_PASSWORD:-veorfolnir} #fixed
VEOR_DATABASE=${VEOR_DATABASE:-veorfolnir} #fixed

#check if mysql can connect
mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -D $DB_DATABASE  -e "SHOW DATABASES;"

#create veorfolnir database and user
mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -D $DB_DATABASE  -e "CREATE DATABASE IF NOT EXISTS $VEOR_DATABASE;"
mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -D $DB_DATABASE  -e "CREATE DATABASE IF NOT EXISTS sqitch;"
mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -D $DB_DATABASE  -e "CREATE USER IF NOT EXISTS '$VEOR_USER'@'%' IDENTIFIED BY '$VEOR_PASSWORD';"
mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -D $DB_DATABASE  -e "GRANT ALL PRIVILEGES ON $VEOR_DATABASE.* TO '$VEOR_USER'@'%';"
mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -D $DB_DATABASE  -e "GRANT ALL PRIVILEGES ON sqitch.* TO '$VEOR_USER'@'%';"
mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -D $DB_DATABASE  -e "GRANT SUPER ON *.* TO '$VEOR_USER'@'%';"

#check if veorfolnir can connect
mysql -h $VEOR_HOST -u $VEOR_USER -p$VEOR_PASSWORD -D $VEOR_DATABASE  -e "SHOW DATABASES;"
mysql -h $VEOR_HOST -u $VEOR_USER -p$VEOR_PASSWORD -D $VEOR_DATABASE  -e "set global log_bin_trust_function_creators=1;"

#run sqitch
sqitch target add veorfolnir db:mysql://$VEOR_USER:$VEOR_PASSWORD@$VEOR_HOST/$VEOR_DATABASE
sqitch deploy veorfolnir
