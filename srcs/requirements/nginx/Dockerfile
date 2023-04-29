FROM alpine:3.16

RUN apk add --update --no-cache nginx openssl dumb-init

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/CN=127.0.0.1' && \
	openssl dhparam -out /etc/nginx/dhparam.pem 1024

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
