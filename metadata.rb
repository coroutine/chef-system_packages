maintainer       "Coroutine LLC"
maintainer_email "bmontgomery@coroutine.com"
license          "Apache 2.0"
description      "Easily install arbitrary system packages"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ ubuntu debian redhad centos}.each do |os|
  supports os
end
