FROM alpine:latest
MAINTAINER kellman
USER root
COPY IPS /.IPS
COPY .aws /root/.aws
COPY BucketSync /BucketSync
RUN echo -n "Gateway In The Sky Project " > /etc/motd && \
	echo -n "Bucket Sync for efs [Alpine:latest] " >> /etc/motd && \
	echo -n "overlaynetwork[TRUSTED] " >> /etc/motd && \
	apk -Uuvv add --no-cache tini tzdata bash build-base ca-certificates curl git libtool \
	python py-pip util-linux coreutils findutils grep jq linux-headers && \
	pip install --upgrade pip && \
	pip install awscli && \
	apk del --purge build-base linux-headers libtool py-pip && \
    rm -rf /root/.cache && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin TERM=vt100 TZ=America/New_York
ENTRYPOINT ["/sbin/tini", "--", "/BucketSync"]

