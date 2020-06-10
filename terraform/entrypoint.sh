cd /terraform

/bin/terraform init;

while true
do
    /bin/terraform apply -auto-approve;
    sleep 300s
done
