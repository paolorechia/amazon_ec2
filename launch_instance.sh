#!/bin/bash
# fetch private information from local directory
key_name=$(cat ~/.ec2/key_name)
image=$(cat ~/.ec2/amazon_image)
groupID=$(cat ~/.ec2/groupID)
local_repo_parent_dir=~/
local_repo=arena_game/

# start instance
echo "Attemping to launch instance..."
instance=$(aws ec2 run-instances --image-id $image --count 1 --instance-type t2.micro --key-name $key_name --security-group-ids $groupID --output json)
echo $instance > instance.json 
echo "The instance.json has been updated"

# fetch instance_id 
instance_id=$(echo $instance | jq .Instances[0].InstanceId | tr -d '"')
echo "instance id: $instance_id"

#check system status
desired_status="ok"
fetched_status="unknown"
wait_time=60
echo "Checking System Status..."
while [ $desired_status != $fetched_status ]; do
    fetched_status=$(aws ec2 describe-instance-status --instance-id $(./fetch_instanceID.sh) --output json | jq .InstanceStatuses[0].InstanceStatus.Status |tr -d '"')
    if [ $desired_status != $fetched_status ];
    then
        echo "System status is: $fetched_status"
        echo "Waiting up $wait_time seconds to try again..."
        sleep $wait_time
    fi
done
echo "Server is $fetched_status!"

# fetch instance description and public dns name
instance_info=$(aws ec2 describe-instances --instance-id $(fetch_instanceID.sh) --output json)
# echo $instance_info > "instance_info.json"
public_dns_name=$(echo $instance_info | jq .Reservations[0].Instances[0].NetworkInterfaces[0].Association.PublicDnsName | tr -d '"')
echo "Public dns name: $public_dns_name"

echo "Creating archive from local repo"
current_dir=$(pwd)
cd $local_repo_parent_dir
tar -czf arena_game.tar.gz $local_repo
mv arena_game.tar.gz $current_dir/
cd $current_dir/ 
echo "Transfering script and archive to target server..."
scp -oStrictHostKeyChecking=no -i ~/.ssh/$key_name.pem arena_game.tar.gz install_ec2.sh ec2-user@$public_dns_name:~/

#echo "Transfering local repo to target server..."
#scp -oStrictHostKeyChecking=no -i ~/.ssh/$key_name.pem arena_game.tar.gz ec2-user@$public_dns_name:~/

echo "Attempting to SSH and run installation script on target server..."
ssh -oStrictHostKeyChecking=no -i ~/.ssh/$key_name.pem ec2-user@$public_dns_name "chmod 700 install_ec2.sh && ./install_ec2.sh && cd arena_game && node app.js"

echo "If all is went all game should be running on:"
echo "$public_dns_name:3000"
