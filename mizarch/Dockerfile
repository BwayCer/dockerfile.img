# MAINTAINER BwayCer (https://github.com/BwayCer/image.docker)


FROM local/mizarch:bwaycer

RUN pacman -Syu --noconfirm

RUN pacman -S --noconfirm python python-pip && \
    pip install pipenv

RUN pacman -S --noconfirm go dart nodejs npm

