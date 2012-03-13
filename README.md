Description
===========
This cookbook makes it easy to install arbitrary system packages. This mayb be useful 
when you want to install some libraries, but don't necessarily want to do any configuration.

Attributes
==========
This cookbook defines one attribute:
    
    node[:system_packages] = []

This attribute should be a string listing the packages that you want installed, 
separated by a space. Set this in Role, with the following:

    default_attributes(
      "system_packages" => "git-core git-doc git-svn gitstats gitweb"
    )

Usage
=====
There's only one recipe in this cookbook (`default`). Create role, assign some values to
the `system_packages` attribute, and apply the role to a node.

Here's a sample role:
        
    name "sample_system_packages"
    description "Sample Role to install some system packages"
    run_list "recipe[system_packages]"

    default_attributes(
      "system_packages" => "git-core git-doc git-svn gitstats gitweb"
    )


License and Author
==================

Author:: Brad Montgomery (<bmontgomery@coroutine.com>)

Copyright 2012, Coroutine LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

