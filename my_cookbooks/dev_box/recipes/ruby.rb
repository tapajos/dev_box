apt_repository 'ruby-nando' do
  uri          'http://apt.hellobits.com'
  distribution node['lsb']['codename']
  components   ['main']
  key          'http://apt.hellobits.com/hellobits.key'
end

package "ruby" do
  action :remove
end

package 'ruby-2.3'
package 'libxslt-dev'
package 'libxml2-dev'
package 'imagemagick'
package 'qt5-default'
package 'libqt5webkit5-dev'
package 'libssl-dev'
package 'libpq-dev'

# cookbook_file 'ruby.sh' do
#   owner 'root'
#   group 'root'
#   mode '0644'
#   path '/etc/profile.d/ruby.sh'
# end

bash 'install bundler' do
  user 'root'
  code 'gem install bundler'
  action :run
end
