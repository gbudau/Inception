FROM alpine:3.16

RUN apk add --update --no-cache nginx dumb-init

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
