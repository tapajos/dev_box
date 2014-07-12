directory node[:apps][:base_path] do
  owner 'vagrant'
  group 'vagrant'
  action :create
end

include_recipe 'apt_mirror_location'

package 'htop'
package 'build-essential'
package 'bash-completion'
package 'vim'

include_recipe 'git'
include_recipe 'dev_box::mysql'
include_recipe 'dev_box::ruby'
include_recipe 'dev_box::redis'
include_recipe 'dev_box::memcached'
include_recipe 'dev_box::dotfiles'
# include_recipe 'dev_box::nginx'