FROM alpine:3.16

RUN \
	addgroup -S mysql && adduser -S -G mysql mysql && \
	apk add --update --no-cache  mysql mysql-client dumb-init && \
	rm -rf /var/lib/mysql  && \
	mkdir -p /var/run/mysqld /var/lib/mysql && \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
