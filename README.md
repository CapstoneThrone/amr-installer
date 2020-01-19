# AMR installer

This repo is for preparing a new Raspberry PI 4 to become a AMR control module.


#### What this doesn't do:
+ Install packages from this group (our ros packages) TODO?
+ Install dependencies of this group (ie ros-serial)
+ Change the MOTD. [The killdozer one was made with this site](http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20)

#### What this does do:
+ `1-setup-net`
  + Configures NetworkManager for `ros-net` and `StoutSecure`
    + Uses `templates/StoutSecure.nm-connection.j2` and `templates/ros-net.nm-connection.j2`
    + `ros-net` is the preferred connection between the two
    + A wired connection is also made (`templates/wired-ll.nm-connection.j2`) set to link local
  + Installs FirewallD.
    + Blocks all ports on `wlan0` except for `22 (ssh), 546 (dhcpv6-client), 1454 (????), and 23140 (robot dispatching?)` (zone `Public`)
    + Leaves all ports open on `eth0` (zone `Private`)
+ `2-configure`
  + Adds `http://packages.ros.org/ros/ubuntu` and `http://apt.jackhil.de` to apt
  + Installs `ip-pusher`, `dns-updater`, and `amr-utils` from `apt.jackhil.de`
  + Configures the above
  + Installs `vim, nvim, git, zsh, build-essentials`
+ `3-setup-users`
  + Create `ros` and `ros-adm`
    + Generate ssh keys and passwords
  + Setup `ssh`
    + Key only access
    + Turn on security features
+ `4-setup-ros`
  + Installs `ros-melodic-desktop-full, python-rosinstall, python-rosinstall-generator, and python-wstool`
  + Init `rosdep` and update
  + Append environment setup to users

***Reboot after running these and run the `wrapup.sh` script!***

#### What does it need?

1. A hostname defined with `-e "new-hostname=<desired hostname>"` when running `1-setup-net.yml`
2. A file named `amr.yml` in `./group_vars/`.
  + This is encrypted with `ansible-vault`. Install will require a password to decrypt (get from Jack or Discord)
  + Has some passwords for wifi and other things
  + Is in this repo and preconfigured. Just wanted to mention you use it for the install!

#### Usage (in ros VM)
```
sudo apt install anisble git
git clone <this repo>
cd ./avg-installer
ansible -

<reboot pi>
cd ./avg-installer/scripts
./wrapup.sh
```
