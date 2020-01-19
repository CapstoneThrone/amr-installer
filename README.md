# AVG installer

What this does:
+ 1-setup-net
  + Configures NetworkManager for `ros-net` and `StoutSecure`
    + Uses `templates/StoutSecure.nm-connection.j2` and `templates/ros-net.nm-connection.j2`
    + `ros-net` is the preferred connection between the two
    + A wired connection is also made (`templates/wired-ll.nm-connection.j2`) set to link local
  + Installs FirewallD.
    + Blocks all ports on `wlan0` except for `22, ` (zone `Public`)
    + Leaves all ports open on `lan` (zone `Private`)
  + Changes hostname to ``
+

*** Reboots should happen after running `1-setup-net` and `3-setup-users` ***

#### Usage (On pi)
```
sudo apt install anisble git
git clone <this repo>
cd ./avg-installer
ansible -
reboot
```
