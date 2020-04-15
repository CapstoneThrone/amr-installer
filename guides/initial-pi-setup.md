# Guide to initial Raspberry Pi 4 setup 

###### H6 Step 0:

Before starting this process, ensure you have all the necessary components, which are: 

a) A raspberry pi 4 with a power adapter 

b) A micro sd card with at least 32gb of storage 

c) A micro sd card reader that you can plug into a computer to image the sd card 

d) A micro hdmi to hdmi cable (for displaying the raspberry pi 4 terminal) 

e) A monitor that accepts hdmi 

f) A standard usb plug-in keyboard 

g) Access to an ethernet cable on someone’s network (Stout’s wifi network does NOT work for this at the time of writing, so someone’s home network is probably your best bet, or any NON WPA-Enterprise network). 

h) A laptop or internet-enabled computer with a usb port (for the micro sd card reader). 

 

 

###### H6 Step 1: 

Go to [https://ubuntu.com/download/raspberry-pi](https://ubuntu.com/download/raspberry-pi) and download the 64bit version of the Ubuntu headless server (for the raspberry pi 4). 


###### H6 Step 2: 

Go to https://www.balena.io/etcher/ and download Etcher for windows or Linux. 


###### H6 Step 3: 

Plug in your microsd card reader (with the sd card in it), Run Balana Etcher, select your image that you downloaded earlier, and click on the “flash” button. Wait for the flash to finish. 

![Balena Etcher](https://github.com/CapstoneThrone/amr-installer/blob/jh-add-docs/guides/etcher_picture.png "Balena Etcher should look like this! Click on the leftmost button and go find your image. Click on the middle button and select the sd card reader. Then click the flash button!")


###### H6 Step 4: 

Once the flash is finished, unplug the sd card from the reader, put the sd card into the raspberry pi. Plug in power, Hdmi cable (that goes to the monitor), and a usb keyboard. The pi should show an initial setup and boot on the monitor as it boots up. 


###### H6 Step 5: 

Change the default password to the `ros-adm` password from the user guide.

 
###### H6 Step 6: 

Plug an ethernet cord into the raspberry pi, and the other end into a functional switch or router. To confirm the connection is functioning properly, run the command: 

ping google.com

Output should look like this (press ctrl-c to stop the ping command after a few iterations):

PING google.com (172.217.6.110) 56(84) bytes of data.

64 bytes from ord37s03-in-f14.1e100.net (172.217.6.110): icmp_seq=1 ttl=52 time=26.3 ms

64 bytes from ord37s03-in-f14.1e100.net (172.217.6.110): icmp_seq=2 ttl=52 time=26.7 ms 

64 bytes from ord37s03-in-f14.1e100.net (172.217.6.110): icmp_seq=3 ttl=52 time=25.1 ms 

^C 

--- google.com ping statistics --- 

3 packets transmitted, 3 received, 0% packet loss, time 2003ms 

rtt min/avg/max/mdev = 25.145/26.031/26.679/0.648 ms

A **failed** command will look like this 

*ping google.com                                                        2 ↵ 

ping: google.com: Name or service not known*


###### H6 Step 7:

Once the pi is successfully connected to the internet, move onto the next guide (Ansible setup). 
