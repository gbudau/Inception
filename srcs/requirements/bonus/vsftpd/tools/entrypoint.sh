#!/usr/bin/env ash

addgroup -g "${SHARED_GID}" "${SHARED_GROUP}"
adduser -D -h "/home/$FTPS_USER" -s /sbin/nologin -u "$SHARED_UID" -G "$SHARED_GROUP" "$FTPS_USER"
echo "$FTPS_USER:$FTPS_USER_PASSWORD" | chpasswd
mkdir -p /var/run/vsftpd/empty
mkdir -p /vsftpd/"$FTPS_USER"/ftp/wordpress
chown nobody:nogroup /vsftpd/"$FTPS_USER"/ftp
chmod a-w /vsftpd/"$FTPS_USER"/ftp
chown -R "$SHARED_UID:$SHARED_GID" /vsftpd/"$FTPS_USER"/ftp/wordpress
echo "$FTPS_USER" > /etc/vsftpd.chroot_list
/usr/sbin/vsftpd "-opasv_address=$FTPS_PASV_ADDRESS" /etc/vsftpd/vsftpd.conf
