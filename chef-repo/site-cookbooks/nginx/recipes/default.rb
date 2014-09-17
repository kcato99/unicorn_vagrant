#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "nginx" do
	action :install
end

directory "#{node[:nginx][:log_dir]}" do
  not_if "test -d #{name}"
  owner 'nginx'
  group 'nginx'
  mode 0755
  action :create
  recursive true
end

# アプリケーション個別の設定ファイル格納ディレクトリを作成
directory "/etc/nginx/conf.d" do
  owner "root"
  group "root"
end

template "nginx.conf" do
	path "/etc/nginx/nginx.conf"
	source "nginx.conf.erb"
	owner "root"
	group "root"
	mode 0644
	notifies :reload,'service[nginx]'
end

template "192.168.32.10.conf.erb" do
	path "/etc/nginx/conf.d/192.168.32.10.conf"
	source "192.168.32.10.conf.erb"
	owner "root"
	group "root"
	mode 0644
	notifies :reload,'service[nginx]'
end

# 不要なnginxがデフォルトで置くファイルを消しておく
file "/etc/nginx/conf.d/default.conf" do
  action :delete
end

file "/etc/nginx/conf.d/ssl.conf" do
  action :delete
end

file "/etc/nginx/conf.d/virtual.conf" do
  action :delete
end


# 起動スクリプトを設置
cookbook_file "/etc/init.d/nginx" do
  source "nginx"
  mode 0755
  not_if "ls /etc/init.d/nginx"
  notifies :run, "execute[chkconfig add nginx]"
end

# 自動起動設定
execute 'chkconfig add nginx' do
  action :nothing
  command "chkconfig --add nginx"
  notifies :run, "execute[chkconfig nginx on]"
  notifies :start, "service[nginx]"
end

execute 'chkconfig nginx on' do
  action :nothing
  command "chkconfig nginx on"
end

service "nginx" do
  action :nothing
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
