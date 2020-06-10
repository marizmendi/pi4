FROM golang:alpine

ARG version=0.12.26

ADD https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_arm.zip terraform.zip
RUN unzip terraform.zip
RUN cp /go/terraform /bin/terraform
RUN rm -rf /go

WORKDIR /

ENTRYPOINT ["/bin/terraform"]
