FROM node:22.14.0-bookworm

ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

RUN apt update
RUN mkdir /var/log/pheasant && chown node /var/log/pheasant

USER node
WORKDIR /workspace
