#!/bin/bash
cd terraform
terraform taint upcloud_server.jenkins_controller
terraform apply -auto-approve
static_ip="$(terraform output -raw jenkins_controller_static_ip)"
floating_ip="$(terraform output -raw jenkins_controller_floating_ip)"
cd ../ansible
sed -i "2s/.*/${static_ip}/" inventory/hosts
sleep 10
ansible-playbook -i inventory/hosts playbook.yml --extra-vars "jenkins_controller_floating_ip=${floating_ip}"
