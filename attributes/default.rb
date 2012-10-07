#
# Cookbook Name:: system_packages
# Attributes:: default
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

# A string containing the packages that you want installed.
default[:system_packages][:packages] = ""
default[:system_packages][:install] = []
default[:system_packages][:remove] = []

# To install from a source tarball
default[:system_packages][:package_name]      = "" 
default[:system_packages][:command]           = "" 
default[:system_packages][:checksum]          = "" 
default[:system_packages][:url]               = "" 
default[:system_packages][:configure_options] = ""
default[:system_packages][:archive_type]      = ".tar.gz" 

