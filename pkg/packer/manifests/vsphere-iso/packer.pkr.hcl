# This file was autogenerated by the 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
packer {
  required_plugins {
    sshkey = {
      version = ">= 1.0.1"
      source = "github.com/ivoronin/sshkey"
    }
    vsphere = {
      version = ">= 1.0.8"
      source = "github.com/hashicorp/vsphere"
    }
    ansible = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/ansible"
    }
  }
}


variable "vsphere_user" {
  type    = string
  default = "${env("VSPHERE_USERNAME") == "" ? env("VSPHERE_USER") : env("VSPHERE_USERNAME") }"
}

variable "ansible_extra_vars" {
  type    = string
  default = ""
}

variable "build_name_extra" {
  type    = string
  default = ""
}

variable "cluster" {
  type    = string
  default = ""
}

variable "cpu" {
  type    = string
  default = "4"
}

variable "cpu_cores" {
  type    = string
  default = "1"
}

variable "datastore" {
  type    = string
  default = ""
}


variable "disk_size" {
  type    = string
  default = "20480"
}

variable "distribution" {
  type    = string
  default = ""
}

variable "distribution_version" {
  type    = string
  default = ""
}

variable "existing_ansible_ssh_args" {
  type    = string
  default = "${env("ANSIBLE_SSH_ARGS")}"
}

variable "export_manifest" {
  type    = string
  default = "none"
}

variable "firmware" {
  type    = string
  default = "bios"
}

variable "folder" {
  type    = string
  default = ""
}

variable "gpu" {
  type    = string
  default = "false"
}

variable "gpu_nvidia_version" {
  type    = string
  default = ""
}

variable "gpu_types" {
  type    = string
  default = ""
}

variable "guest_os_type" {
  type = string
}

variable "ib_version" {
  type    = string
  default = "${env("IB_VERSION")}"
}

variable "insecure_connection" {
  type    = string
  default = "false"
}

variable "kubernetes_full_version" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "iso_checksum" {
  type    = string
  default = "none"
}

variable "manifest_output" {
  type    = string
  default = "manifest.json"
}

variable "memory" {
  type    = string
  default = "8192"
}

variable "ssh_password" {
  type    = string
  default = ""
}

variable "ssh_timeout" {
  type    = string
  default = "60m"
}

variable "ssh_username" {
  type    = string
  default = "builder"
}

variable "vcenter_server" {
  type    = string
  default = "${env("VSPHERE_SERVER")}"
}

variable "vsphere_guest_os_type" {
  type = string
  default = "rhel7_64Guest"
}

variable "vsphere_password" {
  type    = string
  default = "${env("VSPHERE_PASSWORD")}"
}


variable "http_proxy" {}
variable "no_proxy" {}
variable "network" {}
variable "ssh_bastion_private_key_file" {}
variable "resource_pool" {
  default = null
}
variable "ssh_bastion_password" {}
variable "https_proxy" {}

variable "ssh_bastion_username" {}
variable "ssh_bastion_host" {}
variable "build_name" {}
variable "containerd_version" {}
variable "konvoy_image_builder_version" {}
variable "datacenter" {}

variable "custom_role" {
  default = ""
}
variable "distro_arch" {
  default = ""
}
variable "distro_name" {
  default = ""
}
variable "distro_version" {
  default = ""
}
variable "kubernetes_cni_semver" {
  default = ""
}
variable "kubernetes_semver" {
  default = ""
}
variable "kubernetes_source_type" {
  default = ""
}
variable "kubernetes_typed_version" {
  default = ""
}
variable "os_display_name" {
  default = ""
}

variable "goss_binary" {
  type = string
  default = "/usr/local/bin/goss-amd64"
}

variable "goss_entry_file" {
  type    = string
  default = null
}

variable "goss_inspect_mode" {
  type    = bool
  default = false
}

variable "goss_tests_dir" {
  type    = string
  default = null
}

variable "goss_url" {
  type    = string
  default = null
}

variable "goss_vars_file" {
  type    = string
  default = null
}
variable "goss_format" {
  type    = string
  default = null
}
variable "goss_format_options" {
  type    = string
  default = null
}
variable "goss_arch" {
  type    = string
  default = null
}
variable "goss_version" {
  type    = string
  default = null
}

variable "dry_run" {
  type    = bool
  default = false
}

variable "remote_folder" {
  type    = string
  default = "/tmp"
}

# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# All locals variables are generated from variables that uses expressions
# that are not allowed in HCL2 variables.
# Read the documentation for locals blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/locals
locals {
  build_timestamp              = "${local.timestamp}"
  ssh_bastion_host             = "${var.ssh_bastion_host}"
  ssh_bastion_password         = "${var.ssh_bastion_password}"
  ssh_bastion_private_key_file = "${var.ssh_bastion_private_key_file}"
  ssh_bastion_username         = "${var.ssh_bastion_username}"
  vm_name                      = "konvoy-${var.build_name}-${var.kubernetes_full_version}-${local.build_timestamp}"


  # lookup by <distro_name>-<distro_version> fallback to <distro_version>
  distro_version_bootfile_lookup = {
    "RHEL-7" = "kickstart_el7"
    "RHEL-8" = "kickstart_el8"
    "CentOS-7" = "kickstart_el7"
    "CentOS-8" = "kickstart_el8"
    "Ubuntu" = "cloudconfig_ubuntu"
    "rockylinux-9" = "kickstart_el9"
   }

   el_bootcommand = [
   "<tab><wait>",
   " ks=hd:sr1:/bootfile.cfg<enter>"
   ]

   ubuntu_bootcommand = [
       "<esc><esc><esc><esc><esc><esc><esc><esc>",
       "<esc><wait>",
       "<esc><wait>",
       "linux /casper/vmlinuz autoinstall ds=nocloud",
       "<enter><wait>",
       "initrd /casper/initrd",
       "<enter><wait>",
       "boot",
       "<enter>"
   ]

   ubuntu_jammy_bootcommand = [
      "c<wait>",
      "linux /casper/vmlinuz --- autoinstall ds=nocloud",
      "<enter><wait>",
      "initrd /casper/initrd",
      "<enter><wait>",
      "boot",
      "<enter>"
   ]

   # lookup by <distro_name>-<distro_version> fallback to <distro_version>
   distro_boot_command_lookup = {
     "RHEL" = local.el_bootcommand
     "CentOS" = local.el_bootcommand
     "Ubuntu-20.04" = local.ubuntu_bootcommand
     "Ubuntu-22.04" = local.ubuntu_jammy_bootcommand
    }

  default_firmware = "bios"
  # lookup by <distro_name>-<distro_version> fallback to <distro_version> fallback to local.default_firmware
  distro_firmware_lookup = {
    "Ubuntu" = "efi-secure"
  }

  default_bootwait = "10s"
  # lookup by <distro_name>-<distro_version> fallback to <distro_version> fallback to local.default_bootwait
  distro_bootwait_lookup = {
    "Ubuntu" = "1s"
  }

  # lookup by <distro_name>-<distro_version> fallback to <distro_version> fallback to ""
  distro_cd_label_lookup = {
    "Ubuntu" = "cidata"
  }

  bootfile_name = lookup(local.distro_version_bootfile_lookup, "${var.distro_name}-${var.distro_version}", lookup(local.distro_version_bootfile_lookup, "${var.distro_name}", ""))
  bootfile = lookup(local.bootfiles_reg, local.bootfile_name , "")
  boot_command_distro = lookup(local.distro_boot_command_lookup, "${var.distro_name}", [""])
  boot_command = lookup(local.distro_boot_command_lookup, "${var.distro_name}-${var.distro_version}", local.boot_command_distro)

  firmware = lookup(local.distro_firmware_lookup, "${var.distro_name}-${var.distro_version}", lookup(local.distro_firmware_lookup, "${var.distro_name}", local.default_firmware))
  boot_wait = lookup(local.distro_bootwait_lookup, "${var.distro_name}-${var.distro_version}", lookup(local.distro_bootwait_lookup, "${var.distro_name}", local.default_bootwait))
  cd_label = lookup(local.distro_cd_label_lookup, "${var.distro_name}-${var.distro_version}", lookup(local.distro_cd_label_lookup, "${var.distro_name}", ""))
}

data "sshkey" "install" {}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "vsphere-iso" "kib" {
  CPUs                         = var.cpu
  RAM                          = var.memory
  cluster                      = var.cluster
  disk_controller_type         = ["pvscsi"]
  guest_os_type                = var.vsphere_guest_os_type
  network_adapters {
    network_card = "vmxnet3"
    network      = var.network
  }
  boot_wait = local.boot_wait
  boot_command = local.boot_command
  firmware = local.firmware

  cd_content = {
    "/bootfile.cfg" = local.bootfile,
    # make it cloud-config compatible
    "/user-data" = local.bootfile,
    "/meta-data" = ""
  }

  cd_label = local.cd_label

  storage {
    disk_size             = 40000
  }

  communicator                 = "ssh"
  cpu_cores                    = "${var.cpu_cores}"
  datacenter                   = "${var.datacenter}"
  resource_pool                = "${var.resource_pool}"
  datastore                    = "${var.datastore}"
  folder                       = "${var.folder}"
  insecure_connection          = "${var.insecure_connection}"
  iso_url                      = "${var.iso_url}"
  iso_checksum                 = "${var.iso_checksum}"
  password                     = "${var.vsphere_password}"
  ssh_bastion_host             = "${local.ssh_bastion_host}"
  ssh_bastion_password         = "${local.ssh_bastion_password}"
  ssh_private_key_file         = data.sshkey.install.private_key_path
  ssh_clear_authorized_keys    = true
  ssh_bastion_username         = "${local.ssh_bastion_username}"
  ssh_key_exchange_algorithms  = ["curve25519-sha256@libssh.org", "ecdh-sha2-nistp256", "ecdh-sha2-nistp384", "ecdh-sha2-nistp521", "diffie-hellman-group14-sha1", "diffie-hellman-group1-sha1"]
  ssh_password                 = "${var.ssh_password}"
  ssh_timeout                  = "4h"
  ssh_username                 = "${var.ssh_username}"
  username                     = "${var.vsphere_user}"
  vcenter_server               = "${var.vcenter_server}"
  vm_name                      = "${local.vm_name}"

  create_snapshot     = !var.dry_run
  convert_to_template = !var.dry_run
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.vsphere-iso.kib"]

  provisioner "ansible" {
    ansible_env_vars = ["ANSIBLE_SSH_ARGS='${var.existing_ansible_ssh_args} -o IdentitiesOnly=yes -o HostkeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa'", "ANSIBLE_REMOTE_TEMP='${var.remote_folder}/.ansible/'"]
    extra_arguments  = ["--extra-vars", "${var.ansible_extra_vars}"]
    playbook_file    = "./ansible/provision.yaml"
    user             = "${var.ssh_username}"
  }

  provisioner "shell" {
    inline = ["mkdir -p ${var.remote_folder}/.goss-dir"]
  }

  provisioner "file" {
    destination = "${var.remote_folder}/.goss-dir/goss"
    direction   = "upload"
    max_retries = "10"
    source      = var.goss_binary
  }

  provisioner "goss" {
    arch           = var.goss_arch
    download_path  = "${var.remote_folder}/.goss-dir/goss"
    format         = var.goss_format
    format_options = var.goss_format_options
    goss_file      = var.goss_entry_file
    inspect        = var.goss_inspect_mode
    skip_install   = true
    tests          = var.goss_tests_dir == null ? null : [var.goss_tests_dir]
    url            = var.goss_url
    use_sudo       = true
    vars_env = {
      HTTPS_PROXY = var.https_proxy
      HTTP_PROXY  = var.http_proxy
      NO_PROXY    = var.no_proxy
      http_proxy  = var.http_proxy
      https_proxy = var.https_proxy
      no_proxy    = var.no_proxy
    }
    vars_file = var.goss_vars_file
    vars_inline = {
      ARCH     = "amd64"
      OS       = lower(var.distribution)
      PROVIDER = "amazon"
    }
    version = var.goss_version
  }

  provisioner "shell" {
    inline = ["rm -r  ${var.remote_folder}/.goss-dir"]
  }

  post-processor "manifest" {
    custom_data = {
      build_date               = "${timestamp()}"
      build_name               = "${var.build_name}"
      build_timestamp          = "${local.build_timestamp}"
      build_type               = "node"
      containerd_version       = "${var.containerd_version}"
      custom_role              = "${var.custom_role}"
      disk_size                = "${var.disk_size}"
      distro_arch              = "${var.distro_arch}"
      distro_name              = "${var.distro_name}"
      distro_version           = "${var.distro_version}"
      firmware                 = "${var.firmware}"
      gpu                      = "${var.gpu}"
      gpu_nvidia_version       = "${var.gpu_nvidia_version}"
      gpu_types                = "${var.gpu_types}"
      guest_os_type            = "${var.guest_os_type}"
      ib_version               = "${var.ib_version}"
      kubernetes_cni_semver    = "${var.kubernetes_cni_semver}"
      kubernetes_semver        = "${var.kubernetes_semver}"
      kubernetes_source_type   = "${var.kubernetes_source_type}"
      kubernetes_typed_version = "${var.kubernetes_typed_version}"
      os_name                  = "${var.os_display_name}"
      vsphere_guest_os_type    = "${var.vsphere_guest_os_type}"
    }
    name       = "packer-manifest"
    output     = "${var.manifest_output}"
    strip_path = true
  }
}

# hardcoded text blobs
locals {
  bootfiles_reg = {
    "kickstart_el7" = local.kickstart_el7
    "kickstart_el8" = local.kickstart_el8
    "cloudconfig_ubuntu" = local.cloudconfig_ubuntu
  }
  kickstart_el7 = <<EOF
# Perform a fresh install, not an upgrade
install
cdrom

# Perform a text installation
text

# Do not install an X server
skipx

# Configure the locale/keyboard
lang en_US.UTF-8
keyboard us

# Configure networking
network --onboot yes --bootproto dhcp --hostname kib-el7
firewall --disabled
selinux --permissive
timezone UTC

# Don't flip out if unsupported hardware is detected
unsupported_hardware

# Configure the user(s)
auth --enableshadow --passalgo=sha512 --kickstart
user --name=${var.ssh_username} --groups=${var.ssh_username},wheel
sshkey --username=${var.ssh_username} "${data.sshkey.install.public_key}"

# Disable general install minutia
firstboot --disabled
eula --agreed

# Create a single partition with no swap space
bootloader --location=mbr
zerombr
clearpart --all --initlabel
part / --grow --asprimary --fstype=ext4 --label=slash

%packages --ignoremissing --excludedocs
openssh-server
sed
sudo

# Remove unnecessary firmware
-*-firmware

# Remove other unnecessary packages
-postfix
%end

# Enable/disable the following services
services --enabled=sshd

# Perform a reboot once the installation has completed
reboot

# The %post section is essentially a shell script
%post --erroronfail

# Update the root certificates
update-ca-trust force-enable

# Ensure that the "${var.ssh_username}" user doesn't require a password to use sudo,
# or else Ansible will fail
echo '${var.ssh_username} ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/${var.ssh_username}
chmod 440 /etc/sudoers.d/${var.ssh_username}

# Install open-vm-tools
yum install -y open-vm-tools

# Remove the package cache
yum -y clean all

# Disable swap
swapoff -a
rm -f /swapfile
sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab

# Ensure on next boot that network devices get assigned unique IDs.
sed -i '/^\(HWADDR\|UUID\)=/d' /etc/sysconfig/network-scripts/ifcfg-*

%end
EOF
  kickstart_el8 = <<EOF
# version=RHEL8
# Install OS instead of upgrade
install
cdrom
# License agreement
eula --agreed
# Use text mode install
text
# Disable Initial Setup on first boot
firstboot --disable
# Keyboard layout
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8
# Network information
network --bootproto=dhcp --device=link --activate
network --hostname=kib-el8
firewall --disabled
# SELinux configuration
selinux --permissive
# Do not configure the X Window System
skipx
# System timezone
timezone UTC
# Add a user named builder
user --name=${var.ssh_username}
sshkey --username=${var.ssh_username} "${data.sshkey.install.public_key}"

# System bootloader configuration
bootloader --location=mbr --boot-drive=sda
# Clear the Master Boot Record
zerombr
clearpart --all --initlabel --drives=sda
part / --fstype="ext4" --grow --asprimary --label=slash --ondisk=sda

# Reboot after successful installation
reboot

%packages --ignoremissing --excludedocs
# dnf group info minimal-environment
@^minimal-environment
@core
openssh-server
sed
sudo
python3

# Exclude unnecessary firmwares
-iwl*firmware
%end

# Enable/disable the following services
services --enabled=sshd

%post --nochroot --logfile=/mnt/sysimage/root/ks-post.log
# Disable quiet boot and splash screen
sed --follow-symlinks -i "s/ rhgb quiet//" /mnt/sysimage/etc/default/grub
sed --follow-symlinks -i "s/ rhgb quiet//" /mnt/sysimage/boot/grub2/grubenv

# Passwordless sudo for the user '${var.ssh_username}'
echo "${var.ssh_username} ALL=(ALL) NOPASSWD: ALL" >> /mnt/sysimage/etc/sudoers.d/${var.ssh_username}
chmod 440 /etc/sudoers.d/${var.ssh_username}

# sshd
perl -npe 's/^#ServerKeyBits 768/ServerKeyBits 2048/g' -i /etc/ssh/sshd_config
perl -npe 's/^#MaxAuthTries 6/MaxAuthTries 20/g' -i /etc/ssh/sshd_config

# Remove the package cache
yum -y clean all

# Disable swap
swapoff -a
rm -f /swapfile
sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab

sed -i '/^\(HWADDR\|UUID\)=/d' /etc/sysconfig/network-scripts/ifcfg-*

%end
EOF
  cloudconfig_ubuntu = <<EOF
#cloud-config
autoinstall:
  version: 1
  apt:
    geoip: true
    preserve_sources_list: false
    primary:
      - arches: [amd64, i386]
        uri: http://us.archive.ubuntu.com/ubuntu
      - arches: [default]
        uri: http://ports.ubuntu.com/ubuntu-ports
  early-commands:
    - sudo systemctl stop ssh
  locale: en_US
  keyboard:
    layout: us
  identity:
    hostname: kib-ubuntu
    username: ${var.ssh_username}
    password: $6$${sha512(uuidv4())}
  ssh:
    install-server: true
    allow-pw: false
    authorized-keys:
      - "${data.sshkey.install.public_key}"
  storage:
    layout:
        name: lvm
  packages:
    - openssh-server
    - open-vm-tools
    - cloud-init
  user-data:
    disable_root: true
    timezone: Etc/UTC
  late-commands:
    - echo '${var.ssh_username} ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/${var.ssh_username}
    - curtin in-target --target=/target -- chmod 440 /etc/sudoers.d/${var.ssh_username}
EOF
  kickstart_el9 = << EOF
  # Use CDROM installation media
  repo --name="AppStream" --baseurl="http://download.rockylinux.org/pub/rocky/8/AppStream/x86_64/os/"
  cdrom

  # Use text install
  text

  # Don't run the Setup Agent on first boot
  firstboot --disabled
  eula --agreed

  # Keyboard layouts
  keyboard --vckeymap=us --xlayouts='us'

  # System language
  lang en_US.UTF-8

  # Network information
  network --bootproto=dhcp --onboot=on --ipv6=auto --activate --hostname=capv.vm

  # Lock Root account
  rootpw --lock

  # Create builder user
  user --name=builder --groups=wheel --password=builder --plaintext --shell=/bin/bash

  # System services
  selinux --permissive
  firewall --disabled
  services --enabled="NetworkManager,sshd,chronyd"

  # System timezone
  timezone UTC

  # System booloader configuration
  bootloader --location=mbr --boot-drive=sda
  zerombr
  clearpart --all --initlabel --drives=sda
  part / --fstype="ext4" --grow --asprimary --label=slash --ondisk=sda

  skipx

  %packages --ignoremissing --excludedocs
  openssh-server
  open-vm-tools
  sudo
  sed
  python3

  # unnecessary firmware
  -aic94xx-firmware
  -atmel-firmware
  -b43-openfwwf
  -bfa-firmware
  -ipw2100-firmware
  -ipw2200-firmware
  -ivtv-firmware
  -iwl*-firmware
  -libertas-usb8388-firmware
  -ql*-firmware
  -rt61pci-firmware
  -rt73usb-firmware
  -xorg-x11-drv-ati-firmware
  -zd1211-firmware
  -cockpit
  -quota
  -alsa-*
  -fprintd-pam
  -intltool
  -microcode_ctl
  %end

  %addon com_redhat_kdump --disable
  %end

  reboot

  %post

  echo 'builder ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/builder
  chmod 440 /etc/sudoers.d/builder

  # Remove the package cache
  yum -y clean all

  swapoff -a
  rm -f /swapfile
  sed -ri '/\sswap\s/s/^#?/#/' /etc/fstab

  systemctl enable vmtoolsd
  systemctl start vmtoolsd

  # Ensure on next boot that network devices get assigned unique IDs.
  sed -i '/^\(HWADDR\|UUID\)=/d' /etc/sysconfig/network-scripts/ifcfg-*
EOF
}
