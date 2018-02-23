FROM debian:jessie

RUN echo "deb http://http.debian.net/debian sid main" > /etc/apt/sources.list.d/debian-unstable.list && \
echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/default

ENV R_BASE_VERSION 3.4.3

RUN apt-get update && \
apt-get install -t unstable -y --no-install-recommends wget r-base=${R_BASE_VERSION}* r-base-dev=${R_BASE_VERSION}* r-recommended=${R_BASE_VERSION}*

RUN echo 'install.packages("Rcmdr", repos="https://cran.rediris.es/")' > /tmp/install.R && Rscript /tmp/install.R && rm /tmp/install.R

ADD entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
