## AntiCurses
### VERSION 1.0

This script automatically removes any Dremora Lords, Ancestral Ghosts or Dwemer Ghosts created by the cursed items when a player picks one up. Server owners can choose to not remove entities spawned by certain items.

## INSTALLING INSTRUCTIONS

1) Copy `antiCurses.lua` to `.../tes3mp/mp-stuff/scripts/custom`.

2) open customScripts.lua and add this line: require("custom/antiCurses")

## SETTINGS

The script contains a minor list of settings:
```
local disableDremoras = true
local disableDremorasSpecial = true
local disableGhosts = true
local disableDwemerGhosts = true
```

Each variable defines whether or not to remove a specific type of enemy from a cursed item list. Since cursed gold does not naturally appear in the game, one may wish to use it as a special currency on their server. Thus, it will be possible to "disarm" those coins, while keeping other cursed items working as intended, if you wish.

## CHANGELOG:
### 1.0:
Script updated for 0.7.x.