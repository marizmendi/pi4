FROM golang:alpine

ARG version=0.12.26

RUN wget https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_arm.zip
RUN unzip terraform_${version}_linux_arm.zip
RUN rm terraform_${version}_linux_arm.zip
RUN rm -rf bin src

ENTRYPOINT ["./terraform"]
