#!/bin/bash
function update () {
  yum update -y  
}
function setup_teleport_node () {
  # Add teleport repo, install node agent and start background proccess pointing to DEV cluster
  yum-config-manager --add-repo https://rpm.releases.teleport.dev/teleport.repo
  yum install -y teleport-12.*
  teleport start --roles=node --token=/home/opc/.teleport_token --auth-server=teleport.services.dev.neosdata.net:443 > /var/log/teleport.log 2>&1 &

}
echo "update"
update
echo "setup teleport node"
setup_teleport_node