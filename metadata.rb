name 'q2a'
maintainer 'Leonard TAVAE'
maintainer_email 'leonard.tavae@informatique.gov.pf'
license 'Apache 2.0'
description 'Installs/Configures q2a'
long_description 'Installs/Configures q2a'
version '0.1.0'

%w(apache2 mysql database ark).each do |cookbook|
  depends cookbook
end
