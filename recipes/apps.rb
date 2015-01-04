#
# Cookbook Name:: q2a
# Recipe:: apps
#
# Copyright (C) 2014 Leonard TAVAE
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.set['postfix']['main']['inet_protocols'] = 'ipv4'
node.set['postfix']['main']['smtp_use_tls'] = 'no'

%w(php-apc php5-mysql php5-gd unzip).each do |package|
  package package do
    action :install
  end
end

include_recipe 'apache2::default'
include_recipe 'apache2::mod_php5'
include_recipe 'postfix::default'

directory '/var/www/' + node['q2a']['apps'] do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

git '/var/www/' + node['q2a']['apps'] do
  repository 'https://github.com/q2a/question2answer.git'
  revision 'master'
  action :sync
  user 'www-data'
  group 'www-data'
  notifies :restart, 'service[apache2]', :immediately
end

template '/var/www/' + node['q2a']['apps'] + '/qa-config.php' do
  source 'qa-config.php.erb'
  owner 'www-data'
  group 'www-data'
  mode '0640'
end

web_app node['q2a']['apps'] do
  server_name node['q2a']['domain']
  docroot '/var/www/' + node['q2a']['apps']
  cookbook 'apache2'
end

ark 'language' do
  url node['q2a']['plugins']['language']
  path '/var/www/' + node['q2a']['apps'] + '/qa-lang/fr/'
  owner 'www-data'
  action :dump
end
