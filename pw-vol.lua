#!/usr/bin/lua

--[[
    Cor van Wandelen 6-2023

    Purpose: Lua script to set the volume of Pipewire on the command line

    parameters:
    100%    sets volume to 100%
    0%      sets volume to 0%
    reverse reverses volume level: 0%-100% 100%-0% 50%-50% 25%-75% 75%-25% etc
    toggle  toggles volume level
    +       increases volume 5%
    -       decreases volume 5%

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]--

function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end

if #arg == 0 then
    print "Cor van Wandelen 6-2023 - pw-vol adjust Pipewire volume"
    print "Usage: "
    print "pw-vol 100%    sets volume to 100%"
    print "pw-vol 0%      sets volume to 0%"
    print "pw-vol reverse reverses volume level: 0%-100% 100%-0% 50%-50% 25%-75% 75%-25% etc"
    print "pw-vol toggle  toggles volume level"
    print "pw-vol +       increases volume 5%"
    print "pw-vol -       decreases volume 5%"
    os.exit ()
end

vol = tonumber(os.capture("wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2 | xargs", true))

if (arg[1] == "100%") then
    os.execute("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1")
end

if (arg[1] == "0%") then
    os.execute("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0")
end

if (arg[1] == "reverse") then
    vol = 1 - vol
    os.execute("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. vol)
end

if (arg[1] == "toggle") then
    if (vol > 0) then
        os.execute("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0")
    else
        os.execute("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1")
    end
end

if (arg[1] == "+") then
    vol = vol + 0.05

    if (vol <= 1) then
        os.execute("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. vol)
    end
end

if (arg[1] == "-") then
    vol = vol - 0.05

    if (vol >= 0) then
        os.execute("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. vol)
    end
end

vol = tonumber(os.capture("wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f2 | xargs", true))
os.execute("notify-send 'Volume ' -h int:value:" .. vol * 100 .. " -h string:synchronous:volume")
