My development box.

## Details

* VirtualBox and VMWare support
* Ubuntu precise 64
* Ruby (last stable version)
* MySQL
* Memcached
* Redis
* My dot files repo
* Nginx (with some port redirects (vagrant + local firewall) to access my development project using http://dev.tapajos.me).

## Dependencies

* omnibus.

		vagrant plugin install vagrant-omnibus
		
## Usage

		vagrant up
		
## Customizations

You can make some changes in the [attributes file](https://github.com/tapajos/dev_box/blob/master/my_cookbooks/dev_box/attributes/default.rb).