# Guide to initial Raspberry Pi 4 setup 

*Step 0:*

Before starting this process, ensure you have all the necessary components, which are: 

a) A raspberry pi 4 with a power adapter 

b) A micro sd card with at least 32gb of storage 

c) A micro sd card reader that you can plug into a computer to image the sd card 

d) A micro hdmi to hdmi cable (for displaying the raspberry pi 4 terminal) 

e) A monitor that accepts hdmi 

f) A standard usb plug-in keyboard 

g) Access to a wifi network (Stout’s wifi network does NOT work for this at the time of writing, so someone’s home network is probably your best bet). 

h) A laptop or internet-enabled computer with a usb port (for the micro sd card reader). 

 

 

*Step 1:* 

Go to [https://ubuntu.com/download/raspberry-pi](https://ubuntu.com/download/raspberry-pi) and download the 64bit version of the Ubuntu headless server (for the raspberry pi 4). 

 

*Step 2:*

Go to https://www.balena.io/etcher/ and download Etcher for windows or Linux. 

 

*Step 3:* Plug in your microsd card reader (with the sd card in it), Run Balana Etcher, select your image that you downloaded earlier, and click on the “flash” button. Wait for the flash to finish. 

 

*Step 4:* Once the flash is finished, unplug the sd card from the reader, put the sd card into the raspberry pi. Plug in power, Hdmi cable (that goes to the monitor), and a usb keyboard. The pi should show an initial setup and boot on the monitor as it boots up. 

 

*Step 5:* Change the default password to the `ros-adm` password from the user guide. Then run “raspi-config” in the terminal. Select your home wifi, connect to it. 

 

*Step 6:* Once the pi is successfully connected to the internet, move onto the next guide (Ansible setup). 
