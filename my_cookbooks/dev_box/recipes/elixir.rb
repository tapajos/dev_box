apt_repository 'erlang' do
  uri          'http://packages.erlang-solutions.com/ubuntu'
  distribution node['lsb']['codename']
  components   ['contrib']
  key          'http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc'
end

package 'elixir'
