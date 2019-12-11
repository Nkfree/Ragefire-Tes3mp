## PlayTime
### VERSION 1.0

Script tracks players' play time on the server and stores it in their data files in seconds. Two new chat commands - /playtime and /playtime all - displays either individual play time or every player's that is currently online. The play time is converted into days/hours/minutes/seconds format when it is being displayed.

![Play time](https://imgur.com/sZY5pWw.png)

## INSTALLING INSTRUCTIONS

1) Copy `playTime.lua` to `.../tes3mp/mp-stuff/scripts/custom`.


2) open customScripts.lua and add this line: require("custom/playTime")

## COMMANDS:

### Commands added by this script
|Command|Description|
|:----|:-----|
|/playtime|Displays player's total play time on the server. The variable is stored in player's data file in seconds. The function converts it into days/hours/minutes/seconds format and then modifies the string to account for plural, singular or non-existant values. The result is displayed in a TES3 message box.|
|/playtime all|Displays a TES3 list box with the names, PIDs and their play time of all connected players. The time, stored in their data files, is converted from seconds to d/h/m/s format.|

## CHANGELOG:
### 1.0:
Instructions updated for 0.7.x.