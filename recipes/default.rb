#
# Cookbook:: hops-hosts-chef
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#


domain = node[:domain]
hostname = node[:hostname]

puts domain
puts hostname

hostsfile_entry "127.0.0.1" do
    hostname hostname
    action :append
end

hostsfile_entry "::1" do
    hostname hostname
    action :append
end

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

if node.key?("hops-hosts-chef") && node["hops-hosts-chef"].key?("default") && node["hops-hosts-chef"][:default].key?("hosts")

hosts = node["hops-hosts-chef"][:default][:hosts]

hosts.each do |key, value|
  hostsfile_entry key do
    hostname value
    action :create
  end
end
end
