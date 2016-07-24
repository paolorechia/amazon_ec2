This is a small set of scripts to automatize my job of setting up an amazon ec2 instance, it works as following:

1 - launch_instance.sh - This is the main script, it fetches private information from local ~/.ec2/ directory, launches an ec2 instance through aws cli, awaits until the instance is fully initialized. Once the server is ready, the script then sends an installation script and a local repository of a node.js app through scp, ssh into it, install the dependecies and run the node app.js. 

The private information fetched from ~/.ec2/ is basically the key name and security group ID, both that should not be made public for security reasons (the amazon image ID of choice is kept in the same directory just for convenience). 

If you wish to use this script, you should change these variables to fetch your credentials and amazon image. Alternatively you can just save the values on plain text files in ~/.ec2/ and use the script as it is. 
Also do make sure to change the install_ec2.sh and sent file according to your needs. 

2 - fetch_instance.sh - Once the instance is launched, the main script should've saved an json file named "instance.json". This small scripts parses the json file using jq, removes the double quotes with tr and then prints the instance_id on standard output. Please note that the "instance.json" file contains sensitive information, such as security group ID, be careful with it.

3 - fetch_publicdns.sh - Same as fetch_instance.sh, except it actually sends a request through the aws cli to receive the necessary information. Prints the public dns name on standard output. 

4 - check_status.sh - Sends a request through aws cli to receive the instance status -- not necessary.

5 - install_ec2.sh - Contains the list of commands that should be executed inside the ec2 instance.
