This is a small set of scripts to automatize my job of setting up an amazon ec2 instance, it works as following:

1 - launch_instance.sh - This is the main script, it fetches private information from local ~/.ec2/ directory (that is, the key name and security group ID, both that should not be made public for security reasons -- as well as the amazon image ID of choice, which is kept in the same directory just for convenience). 
If you wish to use this script, you should change these variables to fetch your credentials and amazon image. Alternatively you can just save the values on plain text files in ~/.ec2/ and use the script as it is. 
Also do notice that this script sends install.ec2.sh through scp at the end, together with a tar file, which you should edit/delete according to your needs.

2 - fetch_instance.sh - Once the instance is launched, the main script should've saved an json file named "instance.json". This small scripts parses the json file using jq, remove the double quotes with tr and then prints the instance_id on standard output. Please note that the "instance.json" file contains sensitive information, such as security group ID, be careful with it.

3 - fetch_publicdns.sh - Same as fetch_instance.sh, except it actually sends a request through the aws cli to receive the necessary information. Prints the public dns name on standard output. 

4 - check_status.sh - Sends a request through aws cli to receive the instance status -- not necessary.

5 - install_ec2.sh - Contains the list of commands that should be executed inside the ec2 instance.
