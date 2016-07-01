#!/bin/bash
if [ ! -f /var/www/wp-config.php ]; then
  #mysql has to be started this way as it doesn't work to call from /etc/init.d
  # /usr/bin/mysqld_safe &
  # sleep 10s
  # Here we generate random passwords (thank you pwgen!). The first two are for mysql users, the last batch for random keys in wp-config.php
  # WORDPRESS_DB="wordpress"
  # MYSQL_PASSWORD=`pwgen -c -n -1 12`
  # WORDPRESS_PASSWORD=`pwgen -c -n -1 12`
  #This is so the passwords show up in logs.
  # echo mysql root password: $MYSQL_PASSWORD
  # echo wordpress password: $WORDPRESS_PASSWORD
  # echo $MYSQL_PASSWORD > /mysql-root-pw.txt
  # echo $WORDPRESS_PASSWORD > /wordpress-db-pw.txt

  #Update linux user password to the new random one
  #  usermod -p $(openssl passwd -1 $SSH_PASSWORD) wordpress
  #Not running the above because its taken care of in Dockerfile when adding the container user used for SSH


  sed -e "s/database_name_here/$WP_DB_NAME/
  s/username_here/$WP_DB_USER/
  s/password_here/$WP_DB_PASS/
  /'AUTH_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
  /'SECURE_AUTH_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
  /'LOGGED_IN_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
  /'NONCE_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
  /'AUTH_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
  /'SECURE_AUTH_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
  /'LOGGED_IN_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
  /'NONCE_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/"

  mysqladmin -h $WP_DB_HOST -u root password $MYSQL_ROOT_PASSWORD
  mysql -h $WP_DB_HOST -u root -p $MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
  mysql -h $WP_DB_HOST -u root -p $MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $MYSQL_DATABASE; GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"
fi
