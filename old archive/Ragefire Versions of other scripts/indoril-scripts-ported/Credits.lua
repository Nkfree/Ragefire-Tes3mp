-- MotD.lua -*-lua-*-
-- "THE BEER-WARE LICENCE" (Revision 42):
-- <mail@michael-fitzmayer.de> wrote this file.  As long as you retain
-- this notice you can do whatever you want with this stuff. If we meet
-- some day, and you think this stuff is worth it, you can buy me a beer
-- in return.  Michael Fitzmayer


require("color")


Credits = {}

-- This is a FORK of MotD.lua .... its Credits.lua
-- now customhooked
-- just require in customScripts.lua
-- create a credits.txt in server/data/


Credits.Show = function(pid)
    local motd = tes3mp.GetModDir() .. "/credits.txt"
    local message

    local f = io.open(motd, "r")
    if f == nil then return -1 end

    message = f:read("*a")
    f:close()

    message = color.Orange .. message
    message = message .. color.OrangeRed .. os.date("Current time: %A %I:%M %p") .. color.Default .. "\n"
    tes3mp.CustomMessageBox(pid, -1, message, "OK")
    return 0
end


customCommandHooks.registerCommand("credits", Credits.Show)