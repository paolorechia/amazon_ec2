#!/bin/bash
instance=$(cat instance.json)
instance_id=$(echo $instance | jq .Instances[0].InstanceId | tr -d '"')
echo $instance_id
