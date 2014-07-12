include_recipe 'apt'

template '/etc/apt/sources.list' do
  source "sources.list.erb"
  owner 'root'
  group 'root'
  notifies :run, 'execute[apt-get update]', :immediately
  variables({:dist => node['lsb']['codename']})
end
