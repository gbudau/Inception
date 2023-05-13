FROM alpine:3.17

ARG DOMAIN_NAME

RUN apk add --update --no-cache vsftpd openssl dumb-init && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj "/CN=${DOMAIN_NAME}"

# Copy and set permission for config files and starting script
COPY tools/entrypoint.sh /entrypoint.sh
COPY conf/config.conf /etc/vsftpd/vsftpd.conf
RUN chmod +x /entrypoint.sh

VOLUME ["/vsftpd"]

EXPOSE 20 21 30020-30039

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
