Vagrant.configure('2') do |config|
  config.vm.provider :libvirt do |lv, config|
    lv.memory = 8*1024
    lv.cpus = 4
    lv.cpu_mode = 'host-passthrough'
    # lv.nested = true
    lv.keymap = 'pt'
  end

  config.vm.define 'builder' do |config|
    config.vm.box = 'windows-2022-amd64'
    config.vm.provision :shell, path: 'provision-isos.ps1'
    config.vm.synced_folder '.', '/vagrant',
      type: 'smb',
      smb_username: ENV['VAGRANT_SMB_USERNAME'] || ENV['USER'],
      smb_password: ENV['VAGRANT_SMB_PASSWORD']
  end
end
