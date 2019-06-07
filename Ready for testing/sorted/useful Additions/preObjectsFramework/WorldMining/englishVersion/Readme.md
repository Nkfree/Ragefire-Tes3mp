# WorldMining
*by RickOff and discordpeter*

**This Script enables you to craft Materials and place Objects**

* mine rocks and trees with the specific axe
* Create complete Dungeons
* place flora and rocks
* spawn doors to other places
* teleport to doors you spawned before
* and many more possibilites

## Installation

follow the instruction provided below to install this script to your server.


* add WorldMining.lua and decorateHelpVariation.lua into your server/scripts/custom folder
* add miscellaneous.json into your serverdata/data/recordstore/ folder (and replace with existing one)
* add rocks.json and flora.json in your server/data folder	
* add the following files to your server/data folder: cave.json, createdDoors.json, creature.json, exampleInteriors.json, exterior.json, furn.json, npc.json, static.json


### Changes to customScripts.lua
add the two lines 

```
require("custom/decorateHelpVariation")
require("custom/WorldMining")
```

### Changes to server/scripts/menu/help.lua

Open up the file, make a new line at the bottom and add the following code:

```
Menus["menu prison house"] = {
    text = {
		color.Red .. "WARNING !!!",
		color.White .. "\n\nYou just committed a crime against the server.",
		color.Red .. "\n\ n\nTENTATIVE OF GLITCH !!!",
		color.Yellow .. "\n\nA message to was recorded in the server logs to warn the moderation",
		color.White .. "\n\nFeel attention next time",
		color.Yellow .. "\n\nThe object to was disabled only for you during this game session",
		color.White .. "\n\nTo make it reappear you can disconnect and reconnect",
		color.Cyan .. "\n\nGood play, fairplay and role play.",
		color.Red .. "\n\n\nBy continuing you agree not to duplicate this action?"
	},
    buttons = {                        
        { caption = "yes",
            destinations = {
                menuHelper.destinations.setDefault(nil,
                { 
                    menuHelper.effects.runGlobalFunction("WorldMining", "PunishPrison", 
                    {
                        menuHelper.variables.currentPid(), menuHelper.variables.currentPid()
                    })					
                })
            }
        },             
        { caption = "no",
            destinations = {
                menuHelper.destinations.setDefault(nil,
                { 
                    menuHelper.effects.runGlobalFunction("WorldMining", "PunishKick", 
                    {
                        menuHelper.variables.currentPid(),
                    })					
                })
            }
        }		
    }
}

```


And you are done. Start up the Game and use the command /furn /build or /material in chat
Feel free to translate the texts in WorldMining.lua
