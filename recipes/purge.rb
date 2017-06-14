
if node.key?("hopshosts") && node["hopshosts"].key?("default") && node["hopshosts"][:default].key?("hosts")
  hosts = node["hopshosts"][:default][:hosts]
  hosts.each do |key, value|
    hostsfile_entry key do
      hostname value
      action :remove
    end
  end
end

if node.key?("hopshosts") && node["hopshosts"].key?("hosts")
  hosts = node["hopshosts"][:hosts]
  hosts.each do |key, value|
    hostsfile_entry key do
      hostname value
      action :remove
    end
  end
end
