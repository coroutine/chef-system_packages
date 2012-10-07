#
# Cookbook Name:: system_packages
# Recipe:: default
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

packages = node[:system_packages][:packages]
packages = packages.split() if packages.is_a? String

# Allow "install" as an alias for packages
install_packages = node[:system_packages][:install]
install_packages = install_packages.split() if install_packages.is_a? String

install_packages += packages

# Remove packages first
remove_packages = node[:system_packages][:remove]
remove_packages = remove_packages.split() if remove_packages.is_a? String

remove_packages.each do |pkg|
  package pkg do
    action :remove
  end
end

install_packages.each do |pkg|
  package pkg do
    action :install
  end
end
