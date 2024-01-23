FROM docker.io/library/alpine:3.19.0

COPY --chown=root:root --chmod=0600 ./jobs /etc/crontabs/root

CMD ["crond", "-f", "-d", "8"]
