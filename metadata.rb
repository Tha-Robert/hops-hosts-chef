name 'hopshosts'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures hopshosts'
long_description 'Installs/Configures hopshosts'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

%w{ ubuntu debian centos }.each do |os|
  supports os
end

depends 'sudo'
depends 'hostsfile'

recipe "hopshosts::install", "Installs the nodes in the host file"
recipe "hopshosts::default", "Does nothing"
recipe "hopshosts::purge", "Deletes the nodes from the hosts file"

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
issues_url 'https://github.com/Tha-Robert/hops-hosts-chef/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/Tha-Robert/hops-hosts-chef'
