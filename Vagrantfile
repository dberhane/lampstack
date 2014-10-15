# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
   config.vm.network "private_network", ip: "192.168.33.10"
   config.vm.hostname = "www.myvbox.local"

if defined? VagrantPlugins::HostsUpdater
    config.hostsupdater.aliases = [
      "phpmyadmin.vbox.local",
      "drupal.vbox.local",
      "local.www.bmj.com",
      "drupaltest.vbox.local",
    ]
end

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false

  config.ssh.private_key_path = [ '~/.ssh/insecure_private_key', '~/.ssh/id_rsa' ]
  config.ssh.forward_agent = true

# ssh forwarding for vagrant does not work on windows and temporary fix, please enter you Github deploy key

if Vagrant::Util::Platform.windows?
    # You MUST have a ~/.ssh/id_rsa (GitHub specific) SSH key to copy to VM
    if File.exists?(File.join(Dir.home, ".ssh", "id_rsa"))
       # Read local machine's GitHub SSH Key (~/.ssh/id_rsa)
        github_ssh_key = File.read(File.join(Dir.home, ".ssh", "bmj_rsa"))
        # Copy it to VM as the /root/.ssh/id_rsa key
        config.vm.provision :shell, :inline => "echo 'Windows-specific: Copying local GitHub SSH Key to VM for provisioning...' && mkdir -p /root/.ssh && echo '#{github_ssh_key}' > /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa"
    else
        # Else, throw a Vagrant Error. Cannot successfully startup on Windows without a GitHub SSH Key!
        raise Vagrant::Errors::VagrantError, "\n\nERROR: GitHub SSH Key not found at ~/.ssh/id_rsa (required on Windows).\nYou can generate this key manually OR by #installing GitHub for Windows (http://windows.github.com/)\n\n"
    end
end

   config.vm.provision "puppet" do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "default.pp"
     puppet.module_path = "modules"
     puppet.options = "--verbose --debug"
   end

end
