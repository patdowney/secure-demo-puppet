# Standalone Puppet Demo

For more information on roles and profiles please see http://www.craigdunn.org/2012/05/239/

## Bootstrapping
If not using `vagrant` you will need to bootstrap your target machines with the following:
  * `puppet-agent` package installed - for ease of use use Puppetlabs yum/apt repositories.
    * If using AWS think of consider base AMI using packer with this dependency installed.
  * create `/etc/facters/facts.d/role.txt` with content like `role=standalone` - where `myrole` corresponds to a role available in `modules/role/manifests`.
    * If using AWS use userdata and cloud-config's `write_files` module. 
     For example:
     
````
#cloud-config
write_files:
  - path: /etc/facter/facts.d/role.txt
    owner: root
    permissions: 0644
    content: |
         role=standalone
````


## Usage
* Install the operating system package contained in `.output`.
  * Either from a hosted repository using `apt-get` or directly using `dpkg -i`
* Execute the puppet run
  * `sudo /usr/share/${PACKAGE_NAME}/bin/apply`
