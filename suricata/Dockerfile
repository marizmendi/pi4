FROM alpine:latest
#
# Include dist
ADD dist/ /root/dist/
#
# Install packages
RUN apk -U --no-cache add \
                 ca-certificates \
                 curl \
                 file \
                 libcap \
                 wget
RUN apk -U add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
                 suricata
#
# Setup user, groups and configs
RUN addgroup -g 2000 suri
RUN adduser -S -H -u 2000 -D -g 2000 suri
RUN chmod 644 /etc/suricata/*.config
RUN cp /root/dist/suricata.yaml /etc/suricata/suricata.yaml
RUN cp /root/dist/*.bpf /etc/suricata/
#
# Download the latest EmergingThreats ruleset, replace rulebase and enable all rules
RUN cp /root/dist/update.sh /usr/bin/
RUN chmod 755 /usr/bin/update.sh
RUN update.sh OPEN
#
# Clean up
RUN rm -rf /root/*
RUN rm -rf /tmp/*
RUN rm -rf /var/cache/apk/*
#
# Start suricata
STOPSIGNAL SIGINT
CMD SURICATA_CAPTURE_FILTER=$(update.sh $OINKCODE) && exec suricata -v -F $SURICATA_CAPTURE_FILTER -i $INTERFACE
