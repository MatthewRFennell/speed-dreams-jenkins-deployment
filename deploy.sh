#!/bin/bash
cd terraform
terraform untaint upcloud_server.jenkins_controller
terraform untaint upcloud_server.jenkins_agent
terraform apply -auto-approve
controller_floating_ip="$(terraform output -raw jenkins_controller_floating_ip)"
agent_floating_ip="$(terraform output -raw jenkins_agent_floating_ip)"
cd ../ansible
ansible-playbook -i inventory/hosts playbook.yml --extra-vars "jenkins_controller_floating_ip=${controller_floating_ip} jenkins_agent_floating_ip=${agent_floating_ip}"
