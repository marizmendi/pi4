FROM perl:latest

ARG version=3.9.1

ADD https://curl.haxx.se/ca/cacert.pem /etc/ssl/certs/cacert.pem
ADD https://github.com/ddclient/ddclient/archive/v$version.zip $version.zip
RUN apt-get update
RUN apt-get install -y zip libsys-hostname-long-perl libdata-validate-ip-perl libjson-any-perl libio-socket-ssl-perl gettext-base
RUN unzip $version.zip
RUN apt-get remove -y zip unzip
RUN rm -rf /var/lib/apt/lists/*

RUN cp ddclient-$version/ddclient /bin/ddclient
RUN mkdir -p /etc/ddclient
RUN mkdir -p /var/cache/ddclient
RUN rm -rf ddclient-$version $version.zip

WORKDIR /

ENTRYPOINT ["/bin/ddclient"]
