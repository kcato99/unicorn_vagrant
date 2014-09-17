default[:nginx][:worker_processes] = 1
default[:nginx][:worker_connections] = 1024
default[:nginx][:worker_rlimit_nofile] = node[:nginx][:worker_processes] * node[:nginx][:worker_connections]
default[:nginx][:pid] = "/var/run/nginx.pid"
default[:nginx][:log_dir] = "/var/log/nginx"
default[:nginx][:error_log_level] = "crit"
default[:nginx][:redirect_ssl] = false
default[:nginx][:keepalive_timeout] = 10

default[:nginx][:port] = 80
default[:nginx][:server_name] = "192.168.32.10"
default[:nginx][:root] = "/srv/web/current/public/"
