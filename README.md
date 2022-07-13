# Speed Dreams Jenkins Deployment
This project deploys a Jenkins controller and agent, with a single
[pipeline](https://github.com/MatthewRFennell/speed-dreams-pipeline) that builds
[Speed Dreams](https://speed-dreams.net/).

# Install requirements
This project uses a combination of [Terraform](https://www.terraform.io/) (to
create the VMs on which to run the controller and agent) and
[Ansible](https://www.ansible.com/)
(to install the Jenkins server, configure the machines by opening ports,
installing nginx, etc.)

## Terraform
Terraform can be installed by following these
[instructions](https://learn.hashicorp.com/tutorials/terraform/install-cli).
The project currently only supports UpCloud as the host (Although PRs to
generalise this are very welcome!) In order to set up Terraform with UpCloud,
follow
[these instructions](https://upcloud.com/resources/tutorials/get-started-terraform/).

## Ansible
As of Debian 11, Ansible, and the dependencies required to run the playbook, can
be installed using
```
sudo apt install ssh-keygen ansible
```
Then, to install the roles needed to run the playbook, from inside the `ansible`
folder, run
```
ansible-galaxy install -r requirements.txt
```

# Set-up

## Terraform

### terraform/terraform.tfvars
In this file, you will need to add the path to the public key that you would
like to be copied to the newly created host. This key should correspond to the
private key that you would like to use to ssh into the host. For example, you
could set the following value in the file:
```
ssh_public_key="~/.ssh/id_rsa.pub"
```

Then, inside the `terraform` folder, run `terraform init`

## Ansible

### ansible/inventory/hosts file
In order for the ansible playbook to work, you will need to create a file at
```
ansible/inventory/hosts
```
With the following format:
```
[jenkins_controllers]
<IP address of Jenkins controller>

[jenkins_agents]
<IP address of Jenkins agent>
```
Importantly, the playbook only currently supports a single host for both the
controller and the agent. Additionally, since the `deploy-fresh.sh` script edits
the IP addresses of the `inventory/hosts` file directly, line 2 the IP address
of the Jenkins controller must be on line 2, and the IP address of the agent
must be on line 5.

### ansible/inventory/group\_vars/all.yml file
You will also need to specify some variables in the above file, as follows:
```
---
admin_email: 'youremail@example.com' # the email address you would like certbot notifications to be sent to
admin_password: 'adminPassword' # the password of the admin account in the Jenkins web interface
admin_username: 'admin' # the username of the admin account in the Jenkins web interface
hostname: 'example.com' # the hostname (with "www." removed) of the server that you would like the server to be installed to
jenkins_user: 'ansible' # the linux user that you would like Jenkins-related processes to run as on the agent and controller
```
You will have to modify these to suit your needs - especially the
`admin_password`.

# Known instances
[speed-dreams.fennell.dev](https://speed-dreams.fennell.dev)
