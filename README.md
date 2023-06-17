# pw-vol
Lua script to set the volume of Pipewire on the command line<br>
<br>
install:<br>
cp pw-vol.lua /usr/bin<br>
chmod +x /usr/bin/pw-vol.lua<br>
ln -s /usr/bin/pw-vol /usr/bin/pw-vol.lua<br>
<br>
Usage: <br>
```
pw-vol 100%    sets volume to 100%<br>
pw-vol 0%      sets volume to 0%<br>
pw-vol reverse reverses volume level: 0%-100% 100%-0% 50%-50% 25%-75% 75%-25% etc<br>
pw-vol toggle  toggles volume level<br>
pw-vol +       increases volume 5%<br>
pw-vol -       decreases volume 5%<br>
``` 
