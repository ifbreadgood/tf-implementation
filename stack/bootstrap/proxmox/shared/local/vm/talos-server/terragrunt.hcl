include "backend" {
  path = find_in_parent_folders("aws-backend.hcl")
}

terraform {
  source = "github.com/ifbreadgood/tf-module-proxmox.git//vm?ref=e3a9bc496f03a32a782e4948368d5a5323600ada"
}

inputs = {
  name = "controller"
  node_name = "px"
  cpu = 2
  memory = 8096
  iso = "metal-amd64.iso"
  volume_size = 50
  ip = {
    address = "dhcp"
  }
  mac_address = "AA:AA:AA:AA:AA:AA"
}

