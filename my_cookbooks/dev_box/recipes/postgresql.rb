include_recipe 'postgresql'
include_recipe 'postgresql::server'
package 'postgresql-client'

service "postgresql" do
  action [:enable, :start]
end

postgresql_user "vagrant" do
  superuser false
  createdb false
  login true
  replication false
end

postgresql_database "vagrant" do
  owner "vagrant"
  encoding "UTF-8"
  template "template0"
  locale "en_US.UTF-8"
end
