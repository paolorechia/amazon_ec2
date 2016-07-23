#!/bin/bash
instance_status=$(aws ec2 describe-instance-status --instance-id $(fetch_instanceID.sh) --output json | jq .InstanceStatuses[0].InstanceState.Code)
echo $instance_status
system_status=$(aws ec2 describe-instance-status --instance-id $(fetch_instanceID.sh) --output json | jq .InstanceStatuses[0].InstanceStatus.Status)
echo $system_status
