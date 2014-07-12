package "mysql-server"

service "mysql" do
  action [:enable, :start]
end

link "/tmp/mysql.sock" do
  to '/var/lib/mysql/mysql.sock'
end

link "/var/run/mysqld/mysqld.sock" do
  to '/var/lib/mysql/mysql.sock'
end

cookbook_file 'my.cnf' do
  owner 'root'
  group 'root'
  mode '0644'
  path '/etc/mysql/conf.d/my.cnf'
  notifies :restart, 'service[mysql]', :immediate
end

bash 'my privileges' do
  user 'root'
  code 'echo "GRANT ALL ON *.* to root@\'%\'; FLUSH PRIVILEGES;" | mysql -u root -h 127.0.0.1 mysql'
  action :run
end
