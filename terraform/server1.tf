resource "upcloud_floating_ip_address" "jenkins_controller_ip" {
  mac_address = upcloud_server.jenkins_controller.network_interface[0].mac_address
}

resource "upcloud_server" "jenkins_controller" {
  hostname = "jenkins-controller"
  zone = "uk-lon1"
  plan = "1xCPU-1GB"
  template {
    size = 25
    storage = "Debian GNU/Linux 11 (Bullseye)"
  }
  network_interface {
    type = "public"
  }
  network_interface {
    type = "utility"
  }
  login {
    user = "root"
    keys = [var.ssh_public_key]
  }
  connection {
    host = self.network_interface[0].ip_address
    type = "ssh"
    user = "root"
  }
}

resource "upcloud_server" "jenkins_agent" {
  hostname = "jenkins-agent"
  zone = "uk-lon1"
  plan = "1xCPU-1GB"
  template {
    size = 40
    storage = "Debian GNU/Linux 11 (Bullseye)"
  }
  network_interface {
    type = "public"
  }
  network_interface {
    type = "utility"
  }
  login {
    user = "root"
    keys = [var.ssh_public_key]
  }
  connection {
    host = self.network_interface[0].ip_address
    type = "ssh"
    user = "root"
  }
}
