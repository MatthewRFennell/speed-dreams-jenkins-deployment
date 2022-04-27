#!/bin/bash
cd terraform
terraform untaint upcloud_server.jenkins_controller
floating_ip="$(terraform output -raw jenkins_controller_floating_ip)"
cd ../ansible
ansible-playbook -i inventory/hosts playbook.yml --extra-vars "jenkins_controller_floating_ip=${floating_ip}"
