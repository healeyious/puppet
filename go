rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
yum -y install puppet
curl -L https://raw.github.com/healeyious/puppet/master/httpd.payload > /root/httpd.payload
curl -L https://raw.github.com/healeyious/puppet/master/index.payload > /root/index.payload
curl -L https://raw.github.com/healeyious/puppet/master/iptables.payload > /root/iptables.payload
puppet apply < (curl -L https://raw.github.com/healeyious/puppet/master/Sample.pp)
