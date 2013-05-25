name              "snap"
maintainer        "Jordan Ambra"
maintainer_email  "jordan.ambra@gmail.com"
license           "WTFPL"
description       "Various recipes for Snap to install requirements"
version           "1.0.1"
depends           "python"

recipe "web", "Installs several python packages via pip"

%w{ debian ubuntu }.each do |os|
  supports os
end
