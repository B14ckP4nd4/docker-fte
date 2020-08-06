FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="BlackPanda version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

ENV DEBIAN_FRONTEND noninteractive

ENV MODE='server'
ENV CLIENT_IP=127.0.0.1
ENV CLIENT_PORT=8079
ENV SERVER_IP=127.0.0.1
ENV SERVER_PORT=8080
ENV PROXY_IP=127.0.0.1
ENV PROXY_PORT=8081
ENV TZ='Etc/UTC'
ENV TRANSFER_KEY='5733F9F169FE5E868CAD5A2CF6C3F43B2CD36D7A0D727F8EEE6BC359DEA29E4C'

RUN \
 echo "**** install dependencies ****" && \
 apt-get update && \
 apt-get install -y \
	bridge-utils \
	gnupg \
	iproute2 \
	iptables \
	liblzo2-2 \
	libmariadbclient18 \
	libmysqlclient-dev \
	net-tools \
	python \
	python-dev \
	python-pip \
	libgmp-dev \
	build-essential \
	python-mysqldb \
	python-pkg-resources \
	python-pyrad \
	python-serial \
	rsync \
	wget \
	sqlite3 \
	git \
	ucarp && \
 echo "**** Install FTEPROXY With pip ****" && \
 pip install fteproxy && \
 echo "**** ensure home folder for abc user set to /config ****" && \
 usermod -d /config abc

# add local files
COPY /root /

#volumes
VOLUME /config