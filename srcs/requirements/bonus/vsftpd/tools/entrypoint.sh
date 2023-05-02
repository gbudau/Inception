#!/usr/bin/env ash

adduser -D -h "/home/$FTPS_USER" -s /sbin/nologin "$FTPS_USER"
echo "$FTPS_USER:$FTPS_USER_PASSWORD" | chpasswd
mkdir -p /var/run/vsftpd/empty
mkdir -p /vsftpd/"$FTPS_USER"/ftp/files
chown nobody:nogroup /vsftpd/"$FTPS_USER"/ftp
chmod a-w /vsftpd/"$FTPS_USER"/ftp
chown "$FTPS_USER:$FTPS_USER" /vsftpd/"$FTPS_USER"/ftp/files
echo "$FTPS_USER" > /etc/vsftpd.chroot_list
/usr/sbin/vsftpd "-opasv_address=$FTPS_PASV_ADDRESS" /etc/vsftpd/vsftpd.conf
