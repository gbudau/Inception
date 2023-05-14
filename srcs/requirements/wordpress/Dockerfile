FROM alpine:3.17

ARG SHARED_UID
ARG SHARED_GID
ARG SHARED_GROUP
ENV SHARED_UID=${SHARED_UID}
ENV SHARED_GID=${SHARED_GID}
ENV SHARED_GROUP=${SHARED_GROUP}

RUN \
	apk add --update --no-cache \
	dumb-init \
	coreutils \
	mysql-client \
	php81 \
	php81-fpm \
	php81-opcache \
	php81-mysqli \
	php81-curl \
	php81-dom \
	php81-mbstring \
	php81-exif \
	php81-fileinfo \
	php81-pecl-imagick \
	php81-openssl \
	php81-xml \
	php81-zip \
	php81-bcmath \
	php81-iconv \
	php81-intl \
	php81-phar \
	php81-pecl-redis \
	php81-tokenizer \
	php81-ctype

RUN ln -s /usr/sbin/php-fpm81 /usr/sbin/php-fpm && \
	ln -s /etc/php81 /etc/php

# Create shared group and www-data user
RUN  addgroup -g "${SHARED_GID}" "${SHARED_GROUP}" && \
	adduser -u "${SHARED_UID}" -D -S -G "${SHARED_GROUP}" www-data

# Install wordpress and wp-cli
RUN \
	mkdir -p /var/www/html && \
	wget -q https://wordpress.org/latest.tar.gz -P tmp && \
	tar xzf tmp/latest.tar.gz -C tmp && \
	cp -r tmp/wordpress/* /var/www/html && \
	chown -R "${SHARED_UID}:${SHARED_GID}" /var/www/html && \
	cd /var/www/html && \
	wget -q https://api.wordpress.org/secret-key/1.1/salt/ -O salt && \
	csplit -s wp-config-sample.php '/AUTH_KEY/' '/NONCE_SALT/+1' && \
	cat xx00 salt xx02 > wp-config.php && \
	rm salt xx00 xx01 xx02 && \
	cd / && \
	wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /tmp/ && \
	chmod +x tmp/wp-cli.phar && \
	mv tmp/wp-cli.phar usr/local/bin/wp && \
	rm -rf tmp/*


# Copy and set permission for config files and starting script
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
	mkdir -p /var/log/php81 && \
	chown -R www-data:www-data /var/log/php81

# Ports that needs to be exposed
EXPOSE 9000

VOLUME ["/var/www/html"]

USER www-data

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
