This is a small set of scripts to automatize my job of setting up an amazon ec2 instance, it works as following:

1 - launch_instance.sh - this is the main script, it should fetches private information from local ~/ec2/ directory (that is, the key name and security group ID, both that should not be made public for security reasons -- as well as the amazon image ID of choice, which is kept in the same directory just for convenience). 
If you wish to use this script, you should change these variables to fetch your credentials, or store them in ~/.ec2 in the following format:

(yet to be written)...

2 -
