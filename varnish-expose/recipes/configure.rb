service "varnish" do
  supports :restart => true, :status => true, :reload => true
  action :nothing # only define so that it can be restarted if the config changed
end

template "/etc/varnish/default.vcl" do
  cookbook "varnish-expose"
  source "default.vcl.erb"
  owner "varnish"
  group "varnish"
  mode 0644
  notifies :reload, "service[varnish]"
end

execute "echo 'checking if Varnish is not running - if so start it'" do
  not_if "pgrep varnish"
  notifies :start, "service[varnish]"
end

