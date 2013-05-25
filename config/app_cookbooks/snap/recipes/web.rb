include_recipe "apt"
include_recipe "python"
include_recipe "python::pip"
include_recipe "nginx"
include_recipe "supervisor"

package "libpq-dev" do
    action :install
end

package "python-dev" do
    action :install
end

venv_directory = "/srv/app/.env"

python_pip "virtualenv" do
    version "1.9.1"
    action :install
end

python_virtualenv venv_directory do
    interpreter "python2.7"
    action :create
end

python_pip "Flask" do
    virtualenv venv_directory
    version "0.9"
    action :install
end

python_pip "uwsgi" do
    virtualenv venv_directory
    version "1.9.10"
    action :install
end

python_pip "psycopg2" do
    virtualenv venv_directory
    version "2.5"
    action :install
end

python_pip "boto" do
    virtualenv venv_directory
    version "2.9.3"
    action :install
end

template "#{node[:nginx][:dir]}/sites-available/default" do
    source "nginx-site.conf.erb"
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

supervisor_service "uwsgi" do
    action :enable
    command "/srv/app/.env/bin/uwsgi -s /tmp/uwsgi.sock --chmod-socket=666 --file /srv/app/application.py --callable=app --processes 1 --py-autoreload=1"
    autostart true
    autorestart true
end
