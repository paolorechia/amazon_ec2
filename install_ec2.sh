# bash script para configurar o ec2 automagicamente
#!/bin/bash
sudo yum -y update
sudo yum -y install git
curl --silent --location https://rpm.nodesource.com/setup_6.x |sudo bash -
sudo yum -y install nodejs
tar -xvzf arena_game.tar.gz
cd arena_game
npm install express jade favicon cookie-parser body-parser socket.io serve-favicon morgan 
