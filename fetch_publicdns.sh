instance_info=$(aws ec2 describe-instances --instance-id $(fetch_instanceID.sh) --output json)
echo $instance_info > "status.json"
# echo $instance_info
public_dns_name=$(echo $instance_info | jq .Reservations[0].Instances[0].NetworkInterfaces[0].Association.PublicDnsName | tr -d '"')
echo "public dns name: $public_dns_name"
