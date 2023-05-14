FROM alpine:3.17

RUN addgroup -S -g 1000 redis && adduser -S -G redis -u 999 redis

RUN apk add --update --no-cache redis dumb-init

RUN mkdir /data && chown redis:redis /data

VOLUME ["/data"]

WORKDIR /data

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
