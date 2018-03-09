FROM debian:jessie

RUN echo "deb http://http.debian.net/debian sid main" > /etc/apt/sources.list.d/debian-unstable.list && \
echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/default

ENV R_BASE_VERSION 3.4.3

RUN apt-get update && \
apt-get install -t unstable -y --no-install-recommends wget r-base=${R_BASE_VERSION}* r-base-dev=${R_BASE_VERSION}* r-recommended=${R_BASE_VERSION}*

# rgl package requires X11 and cannot be installed in docker build, the error shown:
#   configure: error: X11 not found but required, configure aborted.
RUN echo 'install.packages("Rcmdr", repos="https://cran.rediris.es/")' > /tmp/install.R && \
    echo 'install.packages("sem", repos="https://cran.rediris.es/")' >> /tmp/install.R && \
    echo 'install.packages("rmarkdown", repos="https://cran.rediris.es/")' >> /tmp/install.R && \
    echo 'install.packages("rgl", repos="https://cran.rediris.es/")' >> /tmp/install.R && \
    echo 'install.packages("multcomp", repos="https://cran.rediris.es/")' >> /tmp/install.R && \
    echo 'install.packages("lmtest", repos="https://cran.rediris.es/")' >> /tmp/install.R && \
    echo 'install.packages("leaps", repos="https://cran.rediris.es/")' >> /tmp/install.R && \
    echo 'install.packages("aplpack", repos="https://cran.rediris.es/")' >> /tmp/install.R && \
    Rscript /tmp/install.R && \
    rm /tmp/install.R

ADD entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
