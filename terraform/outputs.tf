output "jenkins_controller_static_ip" {
  description = "The static IP of the Jenkins controller"
  value = upcloud_server.jenkins_controller.network_interface[0].ip_address
}

output "jenkins_controller_floating_ip" {
  description = "The dynamic IP of the Jenkins controller"
  value = upcloud_floating_ip_address.jenkins_controller_ip.ip_address
}
