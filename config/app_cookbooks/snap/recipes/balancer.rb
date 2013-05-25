include_recipe "nginx"

template "#{node[:nginx][:dir]}/sites-available/default" do
    source "nginx-balancer.conf.erb"
    owner "root"
    group "root"
    mode 0644

    if File.exists?("#{node[:nginx][:dir]}/sites-enabled/default")
        notifies :reload, resources(:service => "nginx"), :delayed
    end
end

nginx_site "default" do
    action :enable
end
