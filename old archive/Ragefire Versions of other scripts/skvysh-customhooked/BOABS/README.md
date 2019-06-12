## Boots of Actually Blinding Speed (BOABS)
### VERSION 1.0

*For when you reeeeally hate people who use those boots*

This script simply calls a console command `FadeOut` when a player has Boots of Blinding Speed (BOBS) equipped. If the player has BOBS unequipped, the console instead calls `FadeIn` to bring the screen back. Those that have access to console might be able to "bypass" this script by calling `FadeIn` themselves, but BOABS script is called every time a player changes their equipment, so they would have to re-do it after every equipment change.
Note that the game itself uses `FadeIn` and `FadeOut` in a number of cases, so if the equipment changes while that is happening, unexpected and weird (although not particularly harmful) events may occur.

## INSTALLING INSTRUCTIONS

1) Copy `BOABS.lua` to `.../tes3mp/mp-stuff/scripts/custom`.



2) open customScripts.lua and add this line: require("custom/BOABS")

## CHANGELOG:
### 1.0:
Script updated for 0.7.x.