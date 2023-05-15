FROM alpine:3.17

ARG CADVISOR_VERSION=0.47.0

RUN apk add --update --no-cache wget dumb-init && \
	wget "https://github.com/google/cadvisor/releases/download/v${CADVISOR_VERSION}/cadvisor-v${CADVISOR_VERSION}-linux-amd64" -O cadvisor && \
	chmod +x cadvisor

COPY --chmod=0755 tools/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/entrypoint.sh"]
