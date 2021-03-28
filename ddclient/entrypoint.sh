cd /ddclient

mkdir -p /etc/ddclient/

envsubst < "ddclient.conf.template" > "/etc/ddclient/ddclient.conf"

while true
do
    /bin/ddclient --cache /var/cache/ddclient.cache
    sleep 300s
done
