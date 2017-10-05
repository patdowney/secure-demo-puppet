# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#  config.vm.box = "puppetlabs/debian-8.2-64-puppet"
   #config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
#   config.vm.box = "puppetlabs/ubuntu-16.04-64-puppet"
#   config.vm.box = "centos/7"
   config.vm.box = "centos/7"
   config.vm.guest = "redhat"

  base_box    = 'centos/7'
  default_box = 'secure-demo-base-20171005'

  servers = {
    'base' => { 'role' => 'base', 'ip' => '172.10.10.252', 'box' => base_box },
    'ca' => { 'role' => 'ca', 'ip' => '172.10.10.10', 'box' => default_box },
    'consul00'   => { 'role' => 'consul', 'ip' => '172.10.10.16', 'box' => default_box  },
    'consul01'   => { 'role' => 'consul', 'ip' => '172.10.10.17', 'box' => default_box  },
    'consul02'   => { 'role' => 'consul', 'ip' => '172.10.10.18', 'box' => default_box  },
    'consului00' => { 'role' => 'configui',     'ip' => '172.10.10.20', 'box' => default_box  },
    'vault00'    => { 'role' => 'vault',  'ip' => '172.10.10.32', 'box' => default_box  },
#    'vault02'    => { 'role' => 'vault_server',  'ip' => '172.10.10.33' },
  }

  servers.each_with_index do |server_properties, i|
    name = server_properties.first
    props = server_properties.last
    role = props['role']
    private_ip = props['ip']

   # config.vm.provider "virtualbox" do |vb|
   #   vb.customize ["modifyvm", :id, "--macaddress1", "5CA1AB1E0001" ]
   # end

    config.vm.define "#{name}" do |server|
      server.vm.box = props['box']
      server.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--macaddress1", "5CA1AB1E000#{i}" ]
      end
      server.vm.hostname = "#{name}"
      server.vm.network "private_network", ip: private_ip

      if role == 'base'
        server.vm.provision "shell", inline: "yum -y upgrade"
        server.vm.provision "file", source: "../secure-demo-packer/files/patdowney-secure-demo.repo", destination: "/tmp/patdowney-secure-demo.repo"
        server.vm.provision "file", source: "../secure-demo-packer/files/patdowney-rpm.repo", destination: "/tmp/patdowney-rpm.repo"


        bootstrap_sh = <<SCRIPT
mv /tmp/patdowney-secure-demo.repo /etc/yum.repos.d/patdowney-secure-demo.repo
mv /tmp/patdowney-rpm.repo /etc/yum.repos.d/patdowney-rpm.repo
yum install -y epel-release
yum install -y https://yum.puppetlabs.com/puppet/puppet5-release-el-7.noarch.rpm
yum install -y puppet-agent
#yum install -y secure-demo-hiera
#yum install -y secure-demo-puppet
SCRIPT

        server.vm.provision "shell", inline: bootstrap_sh

        server.vm.provision "shell", inline: "mkdir -p /etc/facter/facts.d"
        server.vm.provision "shell", inline: "echo 'provider=vagrant' > /etc/facter/facts.d/provider.txt"
      end

      server.vm.provision "shell", inline: "echo 'role=#{role}' > /etc/facter/facts.d/role.txt"


# comment out the following to test debian package bit
# START BLOCK
      server.vm.synced_folder "../secure-demo-hiera/", "/etc/hiera"

      server.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "manifests" 
        puppet.manifest_file = "site.pp"
        puppet.module_path = ["vendor/modules", "modules"]
        puppet.environment = "production"
        puppet.environment_path = "../.."
        puppet.hiera_config_path = "../secure-demo-hiera/hiera.yaml"
        puppet.options = "--verbose --debug"
        puppet.facter = {
          "cfssl_auth_key_primary"     => "0123456789ABCDEF0123456789ABCDEF",
          "consul_encrypt_key"         => "71NuxGFXa727cmXKV/XD1Q==",
          "consul_acl_master_token"    => "95623A43-F22E-48D6-8693-31AA177A56B3",
          "consul_acl_token_vault"     => "DF1737B6-2267-48CD-A57F-1B56A0244369",
          "consul_acl_token_consul_ui" => "8C684DC2-EB74-4254-BE62-4D8D063A6591",
        }
#puppet.options = "--debug"
      end
# END BLOCK
    end
  end
end
