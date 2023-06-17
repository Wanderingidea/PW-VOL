# PW-VOL
Lua script to set the volume of Pipewire on the command line<br>
<br>
To install, execute as root:<br>
```
cp pw-vol.lua /usr/bin
chmod +x /usr/bin/pw-vol.lua
ln -s /usr/bin/pw-vol.lua /usr/bin/pw-vol
``` 
<br>
Usage: <br>

``` 
pw-vol 100%    sets volume to 100%
pw-vol 0%      sets volume to 0%
pw-vol reverse reverses volume level: 0%-100% 100%-0% 50%-50% 25%-75% 75%-25% etc
pw-vol toggle  toggles volume level
pw-vol +       increases volume 5%
pw-vol -       decreases volume 5%
``` 
