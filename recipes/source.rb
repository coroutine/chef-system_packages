#
# Cookbook Name:: system_packages
# Recipe:: source
#
# Copyright 2012, Coroutine LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require 'pathname' 

# This recipe is loosely based on jtimberman's solution here:
# http://stackoverflow.com/questions/8530593/chef-install-and-update-programs-from-source

# NOTE: use the default recipe to install any necessary prereqs

package_name = node['system_packages']['package_name']
package_directory = "#{Chef::Config[:file_cache_path]}/#{package_name}"
configure_options = node['system_packages']['configure_options']
url = node['system_packages']['url']
filename = Pathname.new(url).basename

# Create a directory to hold the contents of the source
directory package_directory do
  owner     "root"
  group     "root"
  mode      "0755"
  action    :create
  recursive true
end

# Download the file IF it's not yet installed
remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
  source    url
  checksum  node['system_packages']['checksum']
  mode      "0644"
  not_if "which #{node['system_packages']['command']}"
end


if "#{filename}".end_with?(node['system_packages']['archive_type'])
  
  # Extract the archive into the directory
  bash "extract #{filename}" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOF
      tar -zxf #{filename} -C #{package_directory}
    EOF
    not_if "which #{node['system_packages']['command']}" 
  end
  
  # Configure, Make, and Install
  Chef::Log.info("Spliting #{filename} by #{node['system_packages']['archive_type']}")
  extracted_dir = filename.to_s.split(node['system_packages']['archive_type']).first
  bash "build #{package_name}" do
    cwd "#{package_directory}/#{extracted_dir}"
    code <<-EOF
      (./configure #{configure_options})
      (make && make install)
      ldconfig
    EOF
    not_if "which #{node['system_packages']['command']}" 
  end

else
  Chef::Log.Error("I don't know how to extract #{filename}! Sorry.")
end

# Make sure the OS-provided package doesn't get installed
# TODO: how would you do this on "centos", "redhat", "fedora"?
case node['platform']
when "debian", "ubuntu"
  bash "disable installation of #{package_name}" do
    code <<-EOF
      echo #{package_name} hold | dpkg --set-selections
    EOF
    # only disable OS-provided packages if the installation 
    # of the source version actually succeeded.
    only_if "which #{node['system_packages']['command']}" 
  end
end
