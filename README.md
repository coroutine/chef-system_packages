Description
===========
This cookbook makes it easy to install arbitrary system packages. This mayb be useful 
when you want to install some libraries, but don't necessarily want to do any configuration.

Attributes
==========
This cookbook defines the following attributes:
    
* `default[:system_packages][:packages]` - A string listing the packages that you want installed, separated by a space. Unless you're trying to install from source packages, this is probably the only attribute you need to set.

The following attributes are used when installing from source archives. This is experimental and subject to change.

* `default[:system_packages][:package_name]` - The name of a package that's typically provided by the OS. We use this to disable installation, so our source-installed version doesn't get clobbered (we only do this for Debian/Ubuntu right now).
* `default[:system_packages][:command]` - this should be a command provided by the package. We'll check for the existance of this to see if the installation worked. 
* `default[:system_packages][:checksum]` - An SHA checksum to make sure our downloaded file is OK.
* `default[:system_packages][:url]` - A URL to a source tarball; e.g. `http://example.com/foo.tar.gz`
* `default[:system_packages][:archive_type]` - This is a kludge to remove the extension so we can know what directory the package gets extracted into. Defaults to `.tar.gz` 
* `default[:system_packages][:configure_options]` - Addition options passed to `./configure`

Usage
=====
The `default` recipe allows you to install arbitrary system packages. To use it, create 
a role, and list the packages that you want to install in the 
`default[:system_packages][:packages]` attribute.

Here's a sample role:
        
    name "sample_system_packages"
    description "Sample Role to install some system packages"
    run_list "recipe[system_packages]"

    default_attributes(
      "system_packages" => {
        "packages" => "git-core git-doc git-svn gitstats gitweb"
      }
    )

The `source` recipe allows you to download and install a package from a source tarball. This
recipe is currently experimental, and may change in the future. Here's an example role that
uses this recip to install ImageMagick from source, with RSVG support:

    name "imagemagick_with_rsvg"
    description "Installs ImageMagick from source with RSVG support"
    run_list(
      "recipe[system_packages]",
      "recipe[system_packages::source]"
    )

    default_attributes(
      "system_packages" => {
        "packages" => "librsvg2-2 librsvg2-bin librsvg2-dev libfontconfig libfontconfig-dev libxml2-dev libmagickcore-dev libmagickcore2 libmagickcore2-extra libmagickwand-dev libmagick++-dev libmagick++2",
        "package_name" => "imagemagick",  
        "command" => "convert", # command that should be made available by installing the package.
        "checksum" => "9ee0684fb05dae545a0877cbb3d3dc9ec654c3836f886007c85e65305f14fb08",
        "url" => "http://www.imagemagick.org/download/ImageMagick-6.7.6-0.tar.gz",
        "configure_options" => ""
      }
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

