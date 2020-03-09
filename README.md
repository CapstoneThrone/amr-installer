#AMR installer

This repo is for preparing a new Raspberry PI 4 to become a AMR control module.


#### What this doesn't do:
+ (Install the 64 bit version of Ubuntu 18.04.4 LTS on the SD card)[https://ubuntu.com/download/raspberry-pi]
	+ *Note* If you've come to continue this project, it is very likely that the LTS version has changed. Just rolling with that should still work. Proceed with care!
+ Get the PI on some functional network where it can download the updates
	+ Getting stuff on the stout network is silly. After some packages are installed we can use WPA2 Enterprise.... but before that we need some way to download packages. 

#### Quick notes:
+ To update 

#### What this does do:
+ `1-setup-net`
  + Configures NetworkManager for `ros-net` and `StoutSecure`
    + Uses `templates/StoutSecure.nm-connection.j2` and `templates/ros-net.nm-connection.j2`
		+ Editing these on a running PI can be done with `nmtui` or `nmcli`
    + `ros-net` is the preferred connection between the two
    + A wired connection is also made (`templates/wired-ll.nm-connection.j2`) set to link local
  + Sets up UFW
    + Blocks all ports on `wlan0`
    + Leaves all ports open on `eth0`
  + Sets hostname to the value of `new-hostname`
  + Install MOTD
+ `2-setup-users`
  + Create `ros` and `ros-adm`
    + Generate ssh keys and passwords
  + Setup `ssh`
    + Key only access
    + Turn on security features
+ `3-configure`
  + Adds `http://packages.ros.org/ros/ubuntu` and `http://apt.jackhil.de` to apt
  + Installs `ip-pusher` and amr-utils` from `apt.jackhil.de`
	+ These could be skipped if revisiting and apt.jackhil.de is dead/
  + Installs everything in the `deps.json` file in the `apt` array
  + Checks out everything in the `deps.json` file in the `git` array
+ `4-setup-ros`
  + Init `rosdep`
  + Append environment setup to users

***PI will reboot!***

#### What does it need?

1. A hostname defined with `-e "new-hostname=<desired hostname>"` when running `1-setup-net.yml`
2. A file named `amr.yml` in `./group_vars/`.
  + This is encrypted with `ansible-vault`. Install will require a password to decrypt (get from Jack or Discord)
  + Has some passwords for wifi and other things
  + Is in this repo and preconfigured. Just wanted to mention you use it for the install!

#### How to use
Connect machine running <Debian/Ubuntu VM, Debian/Ubuntu system, Debian/Ubuntu container> to the ethernet port of the pi.
On a <Debian/Ubuntu VM, Debian/Ubuntu system, Debian/Ubuntu container> run:
```
sudo apt install anisble git
git clone https://github.com/CapstoneThrone/amr-installer.git
cd ./amr-installer
ansible -

```
