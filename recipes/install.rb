#
# Cookbook:: hopshosts
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#

# Some fixes
# 1. fatal error: gssapi/gssapi.h: No such file or directory
# 2. mail, later
case node["platform_family"]
when "debian"
  bash "apt_update_install_build_tools" do
    user "root"
    code <<-EOF
   apt-get update -y

   # Postfix
   debconf-set-selections <<< "postfix postfix/mailname string hops.foglight.seld.rnd.ericsson.se"
   debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
   
   apt-get install libkrb5-dev postfix mailutils -y

   # Postfix
   postconf -e "inet_interfaces = localhost" 
   systemctl restart postfix

   echo "Mail from hops works!!" | mail -s "Hopsworks can send mail!" robert.marklund@ericsson.com

 EOF
  end

when "rhel"
  package "libkrb5-devel" do 
    action :install
  end
end

domain = node[:domain]
hostname = node[:hostname]

puts domain
puts hostname

#hostsfile_entry "127.0.0.1" do
#    hostname hostname
#    action :append
#end

#hostsfile_entry "::1" do
#    hostname hostname
#    action :append
#end

if !domain.nil? && !domain.empty?
    fullname = hostname + "." + domain
    puts fullname
    hostsfile_entry "127.0.0.1" do
        hostname fullname
        action :append
    end

    hostsfile_entry "::1" do
        hostname fullname
        action :append
    end
end

if node.key?("hopshosts") && node["hopshosts"].key?("default") && node["hopshosts"][:default].key?("hosts")
  hosts = node["hopshosts"][:default][:hosts]
  hosts.each do |key, value|
    hostsfile_entry key do
      hostname value
      action :create
    end
  end
end

if node.key?("hopshosts") && node["hopshosts"].key?("hosts")
  hosts = node["hopshosts"][:hosts]
  hosts.each do |key, value|
    hostsfile_entry key do
      hostname value
      action :create
    end
  end
end
