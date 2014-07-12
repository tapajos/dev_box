# -*- mode: ruby -*-
# vi: set ft=ruby :

module DevBox
  module VMResources
    extend self

    def system_memory_kbytes
      `sysctl hw.memsize`.sub(/^hw.memsize: /,'').to_i
    end

    def system_memory_mb
      system_memory_kbytes / 1024 / 1024
    end

    def percent_of_memory_for_vm
      0.75
    end

    def min_host_memory_mb
      4 * 1024
    end

    def max_vm_memory_mb
      system_memory_mb - min_host_memory_mb
    end

    def ideal_vm_memory_mb
      (system_memory_mb * percent_of_memory_for_vm).floor
    end

    def vm_memory
      @vm_memory ||= [ideal_vm_memory_mb, max_vm_memory_mb].min
    end

    def system_cpu_count
      `sysctl hw.ncpu`.sub(/^hw.ncpu: /,'').to_i
    end

    def percent_of_cpus_for_vm
      0.8
    end

    def ideal_vm_cpus
      (system_cpu_count * percent_of_cpus_for_vm).floor
    end

    def min_vm_cpus
      1
    end

    def vm_cpu_count
      @vm_cpu_count ||= [ideal_vm_cpus, min_vm_cpus].max
    end

    def ssh_private_key_files
      @ssh_private_key_files ||= begin
        home_dir = ENV['HOME']
        ssh_dir = File.join(home_dir, '.ssh')
        rsa_path = File.join(ssh_dir, 'id_rsa')
        dsa_path = File.join(ssh_dir, 'id_dsa')
        vagrant_path = File.join(home_dir, '.vagrant.d',
                                 'insecure_private_key')
        [ENV['VAGRANT_SSH_PRIVATE_KEY_PATH'].to_s,
                rsa_path,
                dsa_path,
                vagrant_path].select { |f| File.exist?(f) }
      end
    end
  end
end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.network "forwarded_port", guest: 22, host: 2223
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.vm.network "forwarded_port", guest: 80, host: 8080
  # For https projects
  # config.vm.network "forwarded_port", guest: 443, host: 8443

  config.ssh.forward_agent = true

  config.vm.synced_folder "projects", "/home/vagrant/projects"

  config.vm.provider 'vmware_fusion' do |v|
    v.vmx['memsize'] = DevBox::VMResources.vm_memory
    v.vmx['numvcpus'] = DevBox::VMResources.vm_cpu_count
  end

  config.vm.provider 'virtualbox' do |v|
    v.memory = DevBox::VMResources.vm_memory
    v.cpus = DevBox::VMResources.vm_cpu_count
  end

  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.formatter = 'doc'
    chef.roles_path = %w(roles)
    chef.cookbooks_path = %w(cookbooks my_cookbooks)
    chef.add_role("dev_box")
  end
end
