FROM jenkins:latest

USER root

RUN apt-get clean && apt-get update && apt-get install -y \
	build-essential \
	python-setuptools \
	python-dev \
	pylint \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN easy_install pip \
	&& pip install --upgrade setuptools \
	&& pip install \
		virtualenv \
		ansible==2.4.2.0 \
		awscli==1.11.117 \
		docker-py \
		psycopg2

ENV DOCKER_VERSION 17.05.0-ce

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz && tar --strip-components=1 -xvzf docker-${DOCKER_VERSION}.tgz -C /usr/local/bin

USER jenkins