#
# Cookbook Name:: varnish-expose
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'varnish' do
  action :install
end

template "/etc/varnish/default.vcl" do
  source "default.vcl.erb"
  action :create
  mode 0644
  owner "varnish"
  group "varnish"
end

cookbook_file '/etc/default/varnish' do
  source 'etc-sysconfig-varnish'
  manage_symlink_source true
  mode '0777'
end

service 'varnish' do
  action [:enable, :restart]
end