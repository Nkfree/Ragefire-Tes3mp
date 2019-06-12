## Recursive Cliff Racers
### VERSION 1.0.1

Initially written for Morrowind May Modathon Month 2018, the script partially mimics the functionality of the Recursive Cliff Racers TES3 mod using a mod-less Lua script that players do not need to install or even know about while playing TES3MP.

Warning! The amount of cliff racers spawned by the script can and will eventually crash clients and possibly servers. Use at your own risk

## INSTALLING INSTRUCTIONS

1) Put `recursiveCliffRacers.lua` file in `...\tes3mp\mp-stuff\scripts\custom` folder.
2) open customScripts.lua and add this line: require("custom/recursiveCliffRacers")

## SETTINGS

### Changes you can make in the script
|Variable|Description|
|:----|:-----|
|cliffRacerIDs|Modify this variable if you have more IDs of cliff racers (for example, added by a mod). If you do this, a change must be made for the end number of the loop found below (see comments in the script for further instructions).|
|cliffRacerCount|How many cliff racers should spawn on each kill.|

## KNOWN ISSUES

The script will trigger when ANYONE in the world kills a cliff racer in a cell loaded by any player. Leading a cliff racer to guards can result in massive amounts of cliff racers being spawned, as guards kill them.

The cliff racer is spawned on top of the player with authority in the cell. While not a particularly big issue on small servers, it can cause some panic when a cliff racer spawns on top of an unsuspecting player who just happens to have authority in the cell.

## CHANGELOG:
### 1.0.1:
Consistent naming pattern.

### 1.0:
Initial release of the script.

