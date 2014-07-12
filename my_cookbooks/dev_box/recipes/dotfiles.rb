ssh_known_hosts_entry 'github.com'

git node[:dotfiles][:path] do
  destination node[:dotfiles][:path]
  repository node[:dotfiles][:git_repository]
  revision node[:dotfiles][:git_branch]
  enable_submodules true
  group 'vagrant'
  user 'vagrant'
  action :sync
end

bash 'dotfiles' do
  user 'vagrant'
  cwd node[:dotfiles][:path]
  command node[:dotfiles][:script]
  action :run
end
