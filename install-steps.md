# Steps to Install

### 1.) Pre-setup 
	todo: flash iso, set password, maybe use default netplan (or figure it out yourself)

### 2.) Setup and test ansible
	***NOTE*** The PI will get firewalled off so no connections will be allowed in from the WIFI. Because of this, you want to connect your PI to your laptop with an ethernet cable. This can be done by setting the interface to linked local. Once the pi has been configured up to stage 3 the address will always be `169.254.13.13` when connecting with the ethernet cable

	First we need to setup and install ansible. Ansible ssh-es onto machines to do a bunch of tasks. Because of this, *all commands past this point should be run on a device external to the pi*. What that device is is up to your discretion, with the only requirement being that it is a ***Unix or BSD system*** and is ***connected to the pi physically with a ethernet cable***. Windows will not work, and you must use a VM or WSL. I recommend using an Ubuntu VM, and all steps following will assume this is what you are using. Augment to match your system.

	On the system, install ansible:
	``` 
	$ sudo apt update
	$ sudo apt install software-properties-common
	$ sudo apt-add-repository --yes --update ppa:ansible/ansible
	$ sudo apt install ansible
	```

	Once installed we should test to make sure we can ssh to the PI. *On the PI* get the ip with `ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'`, then from the system connected to the PI run `ssh ubuntu@<ip address of pi>`. If everything it good, you should be able to log into the pi. Once you do, quit out with `exit`.

	Now, in this repo edit the `hosts` file. There is a `<replace with pi's ip>`. Replace it with the pi's ip that you got earlier. You're ready to start running the scripts. Start by testing your environment. Run the following command on your machine. It will prompt you for your ssh password.

```ansible-playbook -i hosts -k 0-update-system.yml```

That will update your machine to have the latest versions of software. It's setup to run for two kinds of machines. The "unprepared" one you just set up and "amr" ones (after running these scripts). It will complain that the "amr" machine is unreachable. ***This is fine*** we don't have it! Use this command to debug your setup if it's not working before moving on. 

### 3.) Initial network and user configuration

Run the following commands in order. You will now notice it asks you for ***2*** passwords. The ssh password *and* a "vault password". There is a file in this repo named `ros-secrets.yml`. It contains passwords and tokens, and as such is encrypted. Use the `ros-adm` user's password for the vault key.

ansible-playbook -i hosts -k --ask-vault-pass -e hostname=<pi's hostname> 1-setup-net.yml
ansible-playbook -i hosts -k --ask-vault-pass 2-setup-users.yml
ansible-playbook -i hosts -k --ask-vault-pass 3-configure.yml


ansible-playbook -i hosts --ask-vault-pass 4-cleanup-default-user.yml
ansible-playbook -i hosts --ask-vault-pass 5-install-deps.yml
