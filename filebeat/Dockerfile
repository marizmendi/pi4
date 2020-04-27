FROM golang as builder

RUN mkdir -p ${GOPATH}/src/github.com/elastic
RUN git clone --branch 7.6 https://github.com/elastic/beats ${GOPATH}/src/github.com/elastic/beats
WORKDIR /go/src/github.com/elastic/beats/filebeat
RUN make
RUN ./filebeat test config

FROM golang
COPY --from=builder /go/src/github.com/elastic/beats/filebeat/filebeat /
ADD dist/filebeat.yml /
CMD ["/filebeat"]