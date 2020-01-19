# AMR installer

What this doesn't do:
+ Install packages from this group (our ros packages)
+ Install dependencies of this group (ie ros-serial)

What this does do:
+ 1-setup-net
  + Configures NetworkManager for `ros-net` and `StoutSecure`
    + Uses `templates/StoutSecure.nm-connection.j2` and `templates/ros-net.nm-connection.j2`
    + `ros-net` is the preferred connection between the two
    + A wired connection is also made (`templates/wired-ll.nm-connection.j2`) set to link local
  + Installs FirewallD.
    + Blocks all ports on `wlan0` except for `22 (ssh), 1454 (????), and 23140 (robot dispatching?)` (zone `Public`)
    + Leaves all ports open on `lan` (zone `Private`)
  + Changes hostname to ``
+ 2-configure
  + Adds `http://packages.ros.org/ros/ubuntu` and `http://apt.jackhil.de` to apt
  + Installs `ip-pusher`, `dns-updater`, and `avg-utils` from `apt.jackhil.de`
  + Configures the above
  + Installs `vim, nvim, git, zsh, build-essentials`
+ 3-setup-users
  + Create `ros` and `ros-adm`
    + Generate ssh keys and passwords
  + Setup `ssh`
    + Key only access
    + Turn on security features
+ 4-setup-ros
  + Installs `ros-melodic-desktop-full, python-rosinstall, python-rosinstall-generator, and python-wstool`
  + Init `rosdep` and update
  + Append environment setup to users

*** Reboot after running these and run the `wrapup.sh` script! ***

#### Usage (On pi)
```
sudo apt install anisble git
git clone <this repo>
cd ./avg-installer
ansible -

<reboot pi>
cd ./avg-installer/scripts
./wrapup.sh
```
