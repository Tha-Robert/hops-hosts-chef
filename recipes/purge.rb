

if node.key?("hops-hosts-chef") && node["hops-hosts-chef"].key?("default") && node["hops-hosts-chef"][:default].key?("hosts")

hosts = node["hops-hosts-chef"][:default][:hosts]

hosts.each do |key, value|
  hostsfile_entry key do
    hostname value
    action :remove
  end
end
end 
