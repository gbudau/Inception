#!/usr/bin/env ash

DIR="/var/lib/mysql"
if [ -z "$(ls -A -- "$DIR")" ]; then
	/usr/bin/mysql_install_db --basedir=/usr --user=mysql --datadir="$DIR"
	cat << EOF > tmp.sql
USE mysql;
FLUSH PRIVILEGES ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
CREATE DATABASE ${MYSQL_DATABASE};
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF
	/usr/bin/mysqld --defaults-file=/etc/my.cnf --user=mysql --bootstrap < tmp.sql
	rm -f tmp.sql
fi
exec /usr/bin/mysqld --user=mysql
