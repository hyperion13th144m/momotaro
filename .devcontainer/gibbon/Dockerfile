FROM python:3.11.12-bookworm

ARG USERNAME=pyuser
ARG GROUPNAME=pygroup
ARG UID=1000
ARG GID=1000
ARG WORKDIR=/workspace
ENV TZ=Asia/Tokyo

### prevent pytesseract to freeze
# https://stackoverflow.com/questions/63070716/how-to-configure-omp-thread-limit-in-tesseract-directly-in-python-code-to-disabl
# https://groups.google.com/g/tesseract-ocr/c/kHJkPoxS8dY?pli=1
ENV OMP_THREAD_LIMIT=1

RUN apt-get update
RUN apt-get install -y tesseract-ocr tesseract-ocr-jpn jq
RUN groupadd -g $GID $GROUPNAME && useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
RUN mkdir -p /data/src && chown -R $USERNAME.$GROUPNAME /data

WORKDIR $WORKDIR
USER $USERNAME
