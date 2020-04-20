# AMR installer

This repo is for preparing a new Raspberry PI 4 to become a AMR control module.


## What this doesn't do:
+ [Install the 64 bit version of Ubuntu 18.04.4 LTS on the SD card](https://ubuntu.com/download/raspberry-pi)
	+ *Note* If you've come to continue this project, it is very likely that the LTS version has changed. Just rolling with that should still work. Proceed with care!
	+ There's a separate guide for this. A link to it is in the "How to use" section
+ Get the PI on some functional network where it can download the updates
	+ Getting stuff on the Stout network is silly. After some packages are installed we can connect to WPA2 Enterprise networks with no problem, but to install packages we need an internet connection...
	+ Bringing the Pi to a non-Stout lodging area would be advised. Otherwise a hotspot works well!
	+ This is also covered in the "How to use" section

## Docs and other helpful info

All the ansible playbooks (`#-<words>.yml`) in this repo have explanations for each task and what they do. They also list command equivalents if the playbook is tripping up.

General information about ansible can be found [here.](https://docs.ansible.com/ansible/latest/index.html) The specific modules/resources used for reference are:
+ [apt](https://docs.ansible.com/ansible/latest/modules/apt_module.html)
+ [apt_key](https://docs.ansible.com/ansible/latest/modules/apt_key_module.html)
+ [command](https://docs.ansible.com/ansible/latest/modules/command_module.html#command-module)
+ [copy](https://docs.ansible.com/ansible/latest/modules/copy_module.html)
+ [file](https://docs.ansible.com/ansible/latest/modules/file_module.html)
+ [git](https://docs.ansible.com/ansible/latest/modules/git_module.html)
+ [loop](https://docs.ansible.com/ansible/latest/user_guide/playbooks_loops.html)
+ [service](https://docs.ansible.com/ansible/latest/modules/service_module.html)
+ [template](https://docs.ansible.com/ansible/latest/modules/template_module.html)
+ [ufw](https://docs.ansible.com/ansible/latest/modules/ufw_module.html)
+ [user](https://docs.ansible.com/ansible/latest/modules/user_module.html)
+ [vault](https://docs.ansible.com/ansible/latest/user_guide/playbooks_vault.html)

It's recommended to quick read through files 1-5 to see what they do before running anything, just for an idea of what they will be doing to the system.

## How to use

###### Step 1
 [Follow initial set-up to get pi running]./initial-pi-setup.md)

###### Step 2
 On the pi, we need to install ansible and check out this repo. Run the following commands.
```
$ sudo apt update
$ sudo apt install software-properties-common git
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
$ git clone https://github.com/CapstoneThrone/amr-installer.git
$ cd ./amr-installer
```
###### Step 3
We need to quick prepare and verify some settings. Please do the two following things:
1. Add Stout credentials to `ros-secrets.yml`. To use StoutSecure, you need to use your Stout credentials. What credentials go there is up to you. To add them, run
```
# ansible-vault edit ./ros-secrets.yml
```
In this file you could optionally change the passwords for `ros` and `ros-adm`

2. **(optional)** Create a script in the `files` folder named `<robot name>-motd.sh` that outputs a fun pretty name on login. An example can be seen in `./files/example-motd.sh`. This is not required, and can be skipped.
###### Step 4
Each ansible playbook should be run in order. There are a total of 5 required ones, and represent logical groupings of tasks required to set the Pi up. While running the playbooks, it will ask for a vault password. This password is the same as what you were told to change the password to in step 1 and matches `ros-adm`'s password from the user guide.

For convenience, you may run the following commands to handle everything with a single script.
```
$ ./install.sh <robot> <ros-adm password>  # Runs playbooks 1-3
$ sudo reboot                              # After reboot, log in as ros-adm
$ ./cleanup.sh <ros-adm password>          # Runs playbooks 1-3
```

You may alternatively run each playbook yourself.
```
$ ansible-playbook -v --ask-vault-pass -e hostname=<robot name> 1-setup-net.yml
$ ansible-playbook -v --ask-vault-pass 2-setup-users.yml
$ ansible-playbook -v --ask-vault-pass 3-configure.yml
$ sudo reboot # After reboot, log in as ros-adm
$ ansible-playbook -v --ask-vault-pass 4-cleanup-default-user.yml
$ ansible-playbook -v --ask-vault-pass 5-install-deps.yml
```
