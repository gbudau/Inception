FROM alpine:3.17

RUN \
	apk add --update --no-cache \
	wget \
	dumb-init \
	php81 \
	php81-fpm \
	php81-mysqli \
	php81-session

RUN ln -s /usr/bin/php81 /usr/bin/php && \
	ln -s /usr/sbin/php-fpm81 /usr/sbin/php-fpm && \
	ln -s /etc/php81 /etc/php && \
	sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php81/php.ini

# Create www-data user and group
RUN adduser -u 82 -D -S -G www-data www-data

RUN \
	mkdir -p /var/www/adminer/html && \
	chown -R www-data:www-data /var/www/adminer/html

# Copy and set permission for config files and starting script
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Ports that needs to be exposed
EXPOSE 8080

VOLUME ["/var/www/adminer/html"]

USER www-data

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
