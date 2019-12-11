## RPRolls
## VERSION: 1.2.1

This scripts adds a `/roll <skill/attirbute>` command (by default available to everyone) which chooses a random value between player's specified skill/attribute and 100. The result is displayed in local chat for everyone to see the outcome. The script was made with RP server in mind, hence the name.

## Setup instructions
1) Place this file in `\mp-stuff\scripts\custom`

2) open customScripts.lua and add this line: require("custom/RPRolls")

## CHANGELOG:
### 1.2.1:
Small edit for capitalization to be more consistent.

### 1.2:
Rewrote the script partially, so it uses loops instead of dozens of `if` checks.

### 1.1:
Added rolls for skills as well.

### 1.0:
Initial release of the script.