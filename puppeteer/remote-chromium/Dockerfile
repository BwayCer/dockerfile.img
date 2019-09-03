
FROM node:alpine

RUN apk update && apk upgrade && \
    apk add --no-cache chromium && \
    rm -rf /var/cache/apk/* /usr/share/man /tmp/*

CMD ["/usr/bin/chromium-browser", \
    "--lang=zh-TW,zh,en-US,en", \
    "--headless", "--no-sandbox", "--disable-setuid-sandbox", "--disable-dev-shm-usage", \
    "--remote-debugging-port=9222", "--user-data-dir=/chrome-remote_data_dir", \
    "--no-first-run", "--no-default-browser-check" ]

