#!/bin/bash
cd terraform
terraform taint upcloud_server.jenkins_controller
terraform taint upcloud_server.jenkins_agent
terraform apply -auto-approve
controller_static_ip="$(terraform output -raw jenkins_controller_static_ip)"
controller_floating_ip="$(terraform output -raw jenkins_controller_floating_ip)"
agent_floating_ip="$(terraform output -raw jenkins_agent_floating_ip)"
cd ../ansible
sed -i "2s/.*/${controller_static_ip}/" inventory/hosts
sed -i "5s/.*/${agent_static_ip}/" inventory/hosts
sleep 10
ansible-playbook -i inventory/hosts playbook.yml --extra-vars "jenkins_controller_floating_ip=${controller_floating_ip} jenkins_agent_floating_ip=${agent_floating_ip}"
