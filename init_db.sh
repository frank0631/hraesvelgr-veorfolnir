#!/usr/bin/env bash

MYSQL_HOST=${MYSQL_HOST:-db}
MYSQL_USER=${MYSQL_USER:-root}
MYSQL_PASS=${MYSQL_PASS:-mysql}
MYSQL_DATA=${MYSQL_DATA:-mysql}

VEOR_HOST=${VEOR_HOST:-db} #fixed
VEOR_USER=${VEOR_USER:-veorfolnir} #fixed
VEOR_PASS=${VEOR_PASS:-veorfolnir} #fixed
VEOR_DATA=${VEOR_DATA:-veorfolnir} #fixed

#check if mysql can connect
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASS -D $MYSQL_DATA  -e "SHOW DATABASES;"

#create veorfolnir database and user
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASS -D $MYSQL_DATA  -e "CREATE DATABASE IF NOT EXISTS $VEOR_DATA;"
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASS -D $MYSQL_DATA  -e "CREATE DATABASE IF NOT EXISTS sqitch;"
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASS -D $MYSQL_DATA  -e "CREATE USER IF NOT EXISTS '$VEOR_USER'@'%' IDENTIFIED BY '$VEOR_PASS';"
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASS -D $MYSQL_DATA  -e "GRANT ALL PRIVILEGES ON $VEOR_DATA.* TO '$VEOR_USER'@'%';"
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASS -D $MYSQL_DATA  -e "GRANT ALL PRIVILEGES ON sqitch.* TO '$VEOR_USER'@'%';"
mysql -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASS -D $MYSQL_DATA  -e "GRANT SUPER ON *.* TO '$VEOR_USER'@'%';"

#check if veorfolnir can connect
mysql -h $VEOR_HOST -u $VEOR_USER -p$VEOR_PASS -D $VEOR_DATA  -e "SHOW DATABASES;"
mysql -h $VEOR_HOST -u $VEOR_USER -p$VEOR_PASS -D $VEOR_DATA  -e "set global log_bin_trust_function_creators=1;"


#run sqitch
sqitch target add veorfolnir db:mysql://$VEOR_USER:$VEOR_PASS@$VEOR_HOST/$VEOR_DATA
sqitch deploy veorfolnir


