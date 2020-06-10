FROM perl:latest

ADD https://curl.haxx.se/ca/cacert.pem /etc/ssl/certs/cacert.pem
ADD https://github.com/ddclient/ddclient/archive/master.zip master.zip
RUN apt-get update
RUN apt-get install -y zip libsys-hostname-long-perl libdata-validate-ip-perl libjson-any-perl libio-socket-ssl-perl gettext-base
RUN unzip master.zip
RUN apt-get remove -y zip unzip
RUN rm -rf /var/lib/apt/lists/*

RUN cp ddclient-master/ddclient /bin/ddclient
RUN mkdir -p /etc/ddclient
RUN mkdir -p /var/cache/ddclient
RUN rm -rf ddclient-master master.zip

WORKDIR /

ENTRYPOINT ["/bin/ddclient"]
