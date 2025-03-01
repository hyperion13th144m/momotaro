FROM python:3.11.11-bookworm

ARG USERNAME=pyuser
ARG GROUPNAME=pygroup
ARG UID=1000
ARG GID=1000
ARG WORKDIR=/workspace
ENV TZ=Asia/Tokyo

RUN apt-get update
RUN groupadd -g $GID $GROUPNAME && useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
RUN mkdir -p /data/contents /var/log/poodle && chown -R $USERNAME.$GROUPNAME /data /var/log/poodle

WORKDIR $WORKDIR
USER $USERNAME
