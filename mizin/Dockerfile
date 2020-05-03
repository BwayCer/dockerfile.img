# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


FROM local/mizin:sshentry

RUN apk upgrade --no-cache

ENV PIPENV_VENV_IN_PROJECT=1
RUN apk add --no-cache python3 py3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    pip install pipenv

RUN apk add --no-cache go nodejs npm

