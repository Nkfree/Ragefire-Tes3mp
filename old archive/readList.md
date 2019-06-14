# Why?

In order to settle some of the questions around: "Does this mod work? Is there are an server module that does X?"

But also to make an complete as possible list which might be useful for [modding-openmw](https://modding-openmw.com/).

&#x200B;

# Sidenotes

1. I'll refer to "server side lua scripts" as "server modules" for ease (and personal preference).
2. I'll assume the module is fully functional if not stated otherwise
3. [How to install modules](https://github.com/tes3mp-scripts/Tutorials) \- [Urm/uramer](https://github.com/uramer)
4. Check out [modding-openmw](https://modding-openmw.com/) it's a really great website and ideally I would like that to be the hub for server modules but it's just one guy, and while he is fast keep in mind that it's not his day job and some of the mods/modules could not be completely up to date
   1. The tag: "tes3mp friendly" are Morrowind/openMW mods confirmed to work with tes3mp
   2. The tag: "tes3mp lua scripts" are the server modules
5. If you are an scripter/server owner or would like to be one of them it might be useful to join the Scripter Squad discord (reincarnation of teamFOSS if you remember that), we lurk in tes3mp's discord, you'll get invited if we deem you worthy, n'wah.
6. [A really basic guide on How to get into LUA for tes3mp's serverside Scripting](https://github.com/Schnibbsel/TES3MP-Pants/tree/master/LearnTes3mpScripting) \- [Schnibbsel](https://github.com/Schnibbsel)

&#x200B;

# Format

* \[tes3mp version\] \[status\] [Clickable link to code with the name of module](https://lmddgtfy.net/?q=Did%20I%20click%20on%20a%20dummy%20link%3F) \- ([Dep1](https://lmddgtfy.net/?q=Did%20I%20click%20on%20a%20dummy%20link%3F), [Dep2](https://lmddgtfy.net/?q=Did%20I%20click%20on%20a%20dummy%20link%3F)) - Creator
   * description of module

where \[status\] is the functional state and (dependencies) if there are needed dependencies on other modules for the module to function.

&#x200B;

# List
* \[0.7.0-alpha] [fully functional] [Graphic Herbalismn outdated](https://github.com/rnate/TES3MP-GraphicHerbalism-Outdated) - () - [rnate](https://github.com/rnate)
* Due to them relying on global player variables, none of the popular 'Graphic Herbalism' mods work in TES3MP. This transfers it to a server script, so it can run without issue.
* \[0.7.0-alpha] [fully functional] [Jers Server Market](https://github.com/Jerthebear/Tes3mp-Scripts/blob/master/Jer's%20Server%20Market%20Install.txt) - () - [JerTheBear](https://github.com/Jerthebear/)
* Server Market to trade goods between players relying on Containers
* \[0.7.0-alpha] [fully functional] [Jers Storage Void](https://github.com/Jerthebear/Tes3mp-Scripts/blob/master/Void%20Storage%20Install.txt) - () - [JerTheBear](https://github.com/Jerthebear/)
* Storage Solution. You can put items in a container callable via command
* \[0.7.0-alpha] [fully functional] [tes3mp-player-cells](https://github.com/NicholasAH/tes3mp-player-cells) - () - [NicholasAh](https://github.com/NicholasAH/)
* This gives mods the ability to give players their own cells, where they can whitelist and unwhitelist it, and add whitelisted people. It was made afterplayer-ran stores would get robbed when players were offline.
* \[0.7.0-alpha] [fully functional] [tes3mp_Scriptloader](https://github.com/SaintWish/tes3mp_scriptloader) - (wishbone loader) - [SaintWish](https://github.com/SaintWish/)
* The script loader makes it much easier and cleaner to install scripts and remove them
* \[0.7.0-alpha] [fully functional] [resurrectActors](https://github.com/perfectcolors/tes3mp-scripts/tree/master/resurrectActors) - () - [perfectcolors](https://github.com/perfectcolors/)
* This script issues a resurrect command on actors in a user-defined list when a player loads a cell after a specified period of time.
* \[0.7.0-alpha] [fully functional] [PartyHealth](https://github.com/Nkfree/Partyhealth)- () - [Nkfree](https://github.com/Nkfree)
* You can add another Player into your Friendlist. Then if Friend1 'Activates' Friend2 he gets continuous update of Friend2's health as GUI or CHAT message.
* \[0.7.0-alpha] [fully functional] [HelpHelper](https://github.com/Nkfree/helpHelper)- () - [Nkfree](https://github.com/Nkfree)
* Make single help menus using one function and few variables.
* \[0.7.0-alpha] [fully functional] [bookAssist](https://github.com/buntnessel/tes3mp_bookAssist) - () - [buntnessel](https://github.com/buntnessel/)
* A morrowind-multiplayer/TEs3mp script implementing some of Book Rotates functionality for placing books vertically serverside
* \[0.7.0-alpha] [fully functional] [BountyBoard](https://github.com/quickstraw/tes3mp-scripts/tree/master/Bounty%20Board) - () - [quickstraw](https://github.com/quickstraw/)
* Adds a bounty command which displays a sorted list of active players and their bounties.
* \[0.7.0-alpha] [fully functional] [Criminals](https://github.com/quickstraw/tes3mp-scripts/tree/master/Criminals/ScriptLoader) - ([saints script loader](https://github.com/SaintWish/tes3mp_scriptloader)) - [quickstraw](https://github.com/quickstraw/)
* This is a lua script for tes3mp based on Skvysh's Criminals script. I fixed the script to run correctly and hopefully without bugs. There is also a script loader compatible version which works with SaintWish's script loader which makes script installation a lot cleaner.
* \[0.6.x] [fully functional] [tes3mp-jail](https://github.com/Xenkhan/tes3mp-jail) - () - [xenkhan](https://github.com/Xenkhan/)
* 0.6.X solution to jailing players with actual time.
* \[0.7.0-alpha] [WIP] [DiscordRelay](https://github.com/MrFlutters/TES3MP_DiscordRelay) - () - [MrFlutters](https://github.com/MrFlutters)
* Discord Relay for TES3MP 0.7.0 (Webhook Branch)
* \[0.7.0-alpha] [WIP] [Deathmatch](https://github.com/testman42/tes3mp-deathmatch) - () - [testman42](https://github.com/testman42/)
* Deathmatch and Team Deathmatch for TES3MP 0.7.0-alpha.
* \[0.7.0-alpha] [WIP] [tabletop](https://github.com/testman42/tes3mp-tabletop-games) - () - [testman42](https://github.com/testman42/)
* Currently contains just Mono card game which still has some ugly bugs.
* \[0.7.0-alpha\] \[Fully functional\] [DataManager](https://github.com/tes3mp-scripts/DataManager) \- () - [Urm/uramer](https://github.com/uramer)
   * More of an API for managing data for other modules
* \[0.7.0-alpha\] \[Fully functional\] [VisualHarvesting](https://github.com/tes3mp-scripts/VisualHarvesting) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * This is a tes3mp version of graphic herbalism. Players can activate  plants, removing them from the world and gaining ingredients. Whenever a  cell is loaded, all the harvested plants respawn, if enough time has  passed.
* \[0.7.0-alpha\] \[Fully functional\] [BetterVanillaLeveling](https://github.com/tes3mp-scripts/BetterVanillaLeveling) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * A collection of popular improvements to vanilla leveling mechanics.  Fixed attribute modifiers, level cap, rescaled base health, "natural"  progression - gain attributes by increasing skills.
* \[0.7.0-alpha\] \[Fully functional\] [WeatherController](https://github.com/tes3mp-scripts/WeatherController) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * Gives full control over weather to the server, defined by configurable Markov chains per month (allowing seasons).
* \[0.7.0-alpha\] \[Fully functional\] [CellReset](https://github.com/tes3mp-scripts/CellReset) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * This script simply removes all but specified cells' files on server  startup, if enough time has passed since they were last visited. This  allows creatures to spawn in a way most similar to single player OpenMW.
* \[0.7.0-alpha\] \[Fully functional\] [FullLoot](https://github.com/tes3mp-scripts/FullLoot) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager), [ContainerFramework](https://github.com/tes3mp-scripts/ContainerFramework)) - [Urm/uramer](https://github.com/uramer)
   * Empties player's inventory on death and spawns a container with its contents, available for anyone to take.
* \[0.7.0-alpha\] \[Fully functional\] [DoorFramework](https://github.com/tes3mp-scripts/DoorFramework) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * A complete solution to create custom doors.
* \[0.7.0-alpha\] \[Fully functional\] [ShutdownServer](https://github.com/tes3mp-scripts/ShutdownServer) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * Allows you to exit the server in orderly fashion, while triggering the 'OnServerExit' event (important for most of my scripts). Also makes sure to save all the data in case 'OnServerExit' is triggered by a lua crash.
* \[0.7.0-alpha\] \[Fully functional\] [OriginalStart](https://github.com/tes3mp-scripts/OriginalStart) \- () - [Urm/uramer](https://github.com/uramer)
   * Fixes most of the issues related to vanilla game start. However, the  tes3mp chargen style is kept, so a lot of the voiced dialogue is skipped.
* \[0.7.0-alpha\] \[Fully functional\] [FootPrints](https://github.com/tes3mp-scripts/FootPrints) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * Spawns a trail of invisible objects behind every player. Other players can see them using the Detect Key spell effect.
* \[0.7.0-alpha\] \[Fully functional\] [DropFramework](https://github.com/tes3mp-scripts/DropFramework) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * A set of simple tools to spawn random loot.
* \[0.7.0-alpha\] \[Fully functional\] [PlayerLobby](https://github.com/tes3mp-scripts/PlayerLobby) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * Spawns all new characters in a designated lobby cell. Can be used to  present different starting location choices, staring equipment or other  server related activities.
* \[0.7.0-alpha\] \[Lightly untested\] [Artkwend](https://github.com/tes3mp-scripts/Artkwend) \- () - [Urm/uramer](https://github.com/uramer)
   * This script fixes some of the issues with Arktwend in TES3MP. Only lightly untested.
* \[0.7.0-alpha\] \[Fully functional\] [DoubleTrouble](https://github.com/tes3mp-scripts/DoubleTrouble) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * This script only handles cells on the first visit, resetting if the cell file was not present on server startup.That means, that only cell reset scripts that actually remove cell files will cause creatures to be re-duplicated.
* \[0.7.0-alpha\] \[Fully functional\] [ContainerFramework](https://github.com/tes3mp-scripts/ContainerFramework) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager)) - [Urm/uramer](https://github.com/uramer)
   * This module does nothing by itself, but provides an API to handle various types of custom containers.
* \[0.7.0-alpha\] \[Fully functional\] [CustomAlchemy](https://github.com/tes3mp-scripts/CustomAlchemy) \- ([DataManager](https://github.com/tes3mp-scripts/DataManager), [ContainerFramework](https://github.com/tes3mp-scripts/ContainerFramework)) - [Urm/uramer](https://github.com/uramer)
   * **customAlchemy** reimpliments vanilla alchemy mechanics to  allow batch potion brewing, server side customization and improvement  of server performance.
* \[0.7.0-alpha\] \[Fully functional\] [ActivatePlayer](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/ActivatePlayer) \- () - [rickoff](https://github.com/rickoff)
   * Raises a player by activating it for now, later: pickpocketing, direct haggling, invitation
* \[0.7.0-alpha\] \[Fully functional\] [Bank](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/Bank) \- () - [rickoff](https://github.com/rickoff)
   * Personal banking system, deposit, withdraw soon make the transfer but pay attention to taxes
* \[0.7.0-alpha\] \[Fully functional\] [Compagnon](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/Compagnon) \- () - [rickoff](https://github.com/rickoff)
   * call companions and give them orders to follow, activated, stop and other
* \[0.7.0-alpha\] \[Fully functional\] [DeathDrop](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/DeathDrop) \- () - [rickoff](https://github.com/rickoff)
   * This is the modified version of DeathDrop made for Rickoff so that only gold is left to death except 100
* \[0.7.0-alpha\] \[Fully functional\] [EcarlateSoul](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/EcarlateSoul) \- () - [rickoff](https://github.com/rickoff)
   * An experience gain system with skill chart, inspired by ragefire
* \[0.7.0-alpha\] \[Fully functional\] [Housing](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/Housing) \- () - [rickoff](https://github.com/rickoff)
   * The ultimate script for buying house, land and supply,shop system, also  allows placing objects in the space. Written by Atkana translated and  adapted for the Ecarlate server [https://github.com/Atkana/tes3mp-scripts](https://github.com/Atkana/tes3mp-scripts)
* \[0.7.0-alpha\] \[Fully functional\] [HunterWorld](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/HunterWorld) \- () - [rickoff](https://github.com/rickoff)
   * add 100 random spawn point for creature or npcwhen a boss creature appears the players receive a messagewhen a player kills a boss he receives a reward and a message displays that a rare creature was killed
* \[0.7.0-alpha\] \[Fully functional\] [MarketPlace](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/MarketPlace) \- () - [rickoff](https://github.com/rickoff)
   * A global marketplace to sell your items or buy items put up for sale by other players
   * Players can only sell items in the EcarlateItems.json list
   * The id of the objects are displayed by the names present in the json
   * The seller makes money even if he is disconnected
* \[0.7.0-alpha\] \[Fully functional\] [WorldMining](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/Mining) \- () - [rickoff](https://github.com/rickoff) and [discordpeter/nalal](https://github.com/nalal)
   * Mine rocks and trees with the specific axe
   * Create complete Dungeons
   * Place flora and rocks
   * spawn doors to other places
   * teleport to doors you spawned before
   * and many more possibilities
* \[0.7.0-alpha\] \[Fully functional\] [DeathChoice](https://github.com/rickoff/Tes3mp-Ecarlate-Script/blob/0.7.0/OnDeathChoice/DeathChoice) \- () - [rickoff](https://github.com/rickoff)
   * Gives player choice to revive or wait on timer
* \[0.7.0-alpha\] \[Fully functional\] [ResetSolution](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/ResetSolution) \- () - [rickoff](https://github.com/rickoff)
   * A way to reset guild data such as rank, eviction, reputation, and quest log entries
* \[0.7.0-alpha\] \[Fully functional\] [Tournament](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/Tournament) \- () - [rickoff](https://github.com/rickoff)
   * sign up! wait for the countdown! fight! win prizes!
* \[0.7.0-alpha\] \[Fully functional\] [TrueSurvive](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/TrueSurvive) \- () - [rickoff](https://github.com/rickoff)
   * A script that simulates the primary need for survival( sleep, drink, eat, attack max, weather)
* \[0.7.0-alpha\] \[Fully functional\] [VampWolfFix](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/VampWolfFix) \- () - [rickoff](https://github.com/rickoff)
   * Fix Werewolf/Vampire status for player
* \[0.7.0-alpha\] \[Fully functional\] [VoiceBot](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/VoiceBot) \- () - [rickoff](https://github.com/rickoff)
   * Bot vocal Discord with position player on server
* \[0.7.0-alpha\] \[Fully functional\] [Wanted](https://github.com/rickoff/Tes3mp-Ecarlate-Script/tree/0.7.0/Wanted) \- () - [rickoff](https://github.com/rickoff)
   * The Skvysh script translates and adapts for the Ecarlate server [Criminals](https://github.com/Skvysh/TES3MP-Scripts/tree/master/Criminals)
* \[0.7.0-alpha\] \[Fully functional\] [DirectTrade](https://github.com/Schnibbsel/TES3MP-Pants/tree/master/0.7.0/DirectTrade) \- () - [Schnibbsel](https://github.com/Schnibbsel)
   * Its a EasyMarket You can exchange Items with other Players against Gold
* \[0.7.0-alpha\] \[Fully functional\] [DirtyDisableFriendlyFire](https://github.com/Schnibbsel/TES3MP-Pants/tree/master/0.7.0/DirtyDisableFriendlyFire) \- () - [Schnibbsel](https://github.com/Schnibbsel)
   * If you accidentally hit your buddy and kill him. He will be instantly resurrected. This is a dirty Version to stop Friendly Fire.
* \[0.7.0-alpha\] \[Fully functional\] [PARTYsystem](https://github.com/Schnibbsel/TES3MP-Pants/tree/master/0.7.0/PARTYsystem) \- () - [Schnibbsel](https://github.com/Schnibbsel)
   * This is a Grouping Up / Party - System
* \[0.7.0-alpha\] \[Fully functional\] [PlaceBountyOnOthers](https://github.com/Schnibbsel/TES3MP-Pants/tree/master/0.7.0/PlaceBountyOnOthers) \- () - [Schnibbsel](https://github.com/Schnibbsel)
   * Place bounties on other players and hunt them down to gather the bounty.
* \[0.7.0-alpha\] \[Fully functional\] [Worldbuilding](https://github.com/Schnibbsel/TES3MP-Pants/tree/master/0.7.0/Worldbuilding) \- () - [Schnibbsel](https://github.com/Schnibbsel)
   * place Objects ingame
   * create complete Dungeons
   * works with cellreset through preObjects
   * craft materials to buy objects
   * possible with modification of [kanaFurniture](https://github.com/Atkana/tes3mp-scripts/blob/master/kanaFurniture.lua)
   * check out the better version: [RickOffs Rewrite](https://github.com/rickoff/Tes3mp-Ecarlate-Script/blob/0.7.0/Mining/WorldMining.lua)
* \[0.7.0-alpha\] \[Fully functional\] [Alternate Start](https://github.com/Boyos999/tes3mpScripts/tree/master/Alternate%20Start) \- () - [Boyos999](https://github.com/Boyos999)
   * Allows the player to select a location to spawn at when their character is first created
* \[0.7.0-alpha\] \[Fully functional\] [Dungeon Loot](https://github.com/Boyos999/tes3mpScripts/tree/master/Dungeon%20Loot) \- ([Player Packet Helper](https://github.com/Boyos999/tes3mpScripts/tree/master/Player%20Packet%20Helper)) - [Boyos999](https://github.com/Boyos999)
   * Script for a hopefully modular system of cooldown based looting.
* \[0.7.0-alpha\] \[Fully functional\] [Note Writing](https://github.com/Boyos999/tes3mpScripts/tree/master/Note%20Writing) \- ([Player Packet Helper](https://github.com/Boyos999/tes3mpScripts/tree/master/Player%20Packet%20Helper)) - [Boyos999](https://github.com/Boyos999)
   * Use /write <text> (without <>) to create a note with given text. Makes a check to see if the player has the required item(s) (only paper) by default.
* \[0.7.0-alpha\] \[Fully functional\] [Player Packet Helper](https://github.com/Boyos999/tes3mpScripts/tree/master/Player%20Packet%20Helper) \- () - [Boyos999](https://github.com/Boyos999)
   * Contains add/remove item/spell functions for use specifically on players. These functions will also send players relevant packet data (which are contained as separate functions). Required by Note Writing, Dungeon Loot, and Dungeon Tomes.
* \[0.7.0-alpha\] \[Fully functional\] [Potion Limiter](https://github.com/Boyos999/tes3mpScripts/tree/master/Potion%20Limiter) \- () - [Boyos999](https://github.com/Boyos999)
   * Limits the number of active potion effects a player can have on them,  by default this is 3 at alchemy less than 50, gaining one extra at 50, 75, and 100 alchemy. For use with non-vanilla potions, you need to add the required  information following the format in vanillapotions.json, any custom  records should work by defaultDisclaimer: I have no idea what the performance impact of this is
* \[0.7.0-alpha\] \[Fully functional\] [Random Helper](https://github.com/Boyos999/tes3mpScripts/tree/master/Random%20Helper) \- () - [Boyos999](https://github.com/Boyos999)
   * it's like 4 lines, basically sets random seed when server launches
* \[0.7.0-alpha\] \[Fully functional\] [Res Menu](https://github.com/Boyos999/tes3mpScripts/tree/master/Res%20Menu) \- () - [Boyos999](https://github.com/Boyos999)
   * Gives the player the choice of respawning at an imperial shrine or tribunal temple on death, as opposed to it being random
* \[0.7.0-alpha\] \[Fully functional\] [Starter Equipment](https://github.com/Boyos999/tes3mpScripts/tree/master/Starter%20Equipment) \- () - [Boyos999](https://github.com/Boyos999)
   * A simple script to add some basic starter equipment to players based on their skills
* \[0.7.0-alpha\] \[Fully functional\] [TES3MP-npcReset](https://github.com/rnate/TES3MP-npcReset) \- () - [rnate](https://github.com/rnate)
   * This script will log the time the player enters a cell, and then  depending on the resetTime (default 1 hour of real time), run the  console command 'RA'
* \[0.7.0-alpha\] \[Fully functional\] [tes3mp-roleplay-chat-essentials](https://github.com/David-AW/tes3mp-roleplay-chat-essentials) \- ([tes3mp-Script-Loader](https://github.com/David-AW/tes3mp-Script-Loader)) - [David-AW](https://github.com/David-AW)
   * local chat, OOC/Local OOC, Nicknames, /me
* \[0.7.0-alpha\] \[Fully functional\] [tes3mp-Script-Loader](https://github.com/David-AW/tes3mp-Script-Loader) \- () - [David-AW](https://github.com/David-AW)
   * This script makes it easier to develop and install custom scripts. Just drop the custom script into **mpstuff/scripts/** and add it to **mpstuff/data/scripts.json**.If your server is already online and you want to load up a script you just made/added; follow the steps above and then do /loadscript scriptname
* \[0.7.0-alpha\] \[Fully functional\] [tes3mp-safezone-dropitems](https://github.com/David-AW/tes3mp-safezone-dropitems) \- () - [David-AW](https://github.com/David-AW)
   * safezones and drop items on death, configurable.
* \[0.7.0-alpha\] \[Fully functional\] [tes3mp-disable-assassins](https://github.com/David-AW/tes3mp-disable-assassins) \- () - [David-AW](https://github.com/David-AW)
   * Disable Tribunal assassins
* \[0.7.0-alpha\] \[Fully functional\] [CellReset](https://github.com/Atkana/tes3mp-scripts/tree/master/0.7/CellReset) \- () - [Atkana](https://github.com/Atkana)
   * Cell Reset is a script for periodically resetting the game's cells to  their default states, in a manner that tries to avoid all the potential  problems other methods might cause (for example, manually deleting a cell's .json entry can lead to problems!). The server owner  can configure how often these happen, as well as provide a list of  cells that they don't want to be affected.
* \[0.7.0-alpha\] \[Fully functional\] [GeneralGUI](https://github.com/Atkana/tes3mp-scripts/tree/master/0.7/GeneralGUI) \- () - [Atkana](https://github.com/Atkana)
   * This is just some generalised way of using tes3mp's GUI stuff that I'll  most likely use for my scripts from now on. It doesn't make using them  any easier (in fact, it makes more work), however it offers a basic  structure to use. I'd initially intended to simply insert this into  every script I needed to use it in rather than making it into a fully-fledged module in order to cut down on installation steps, but  either way requires at least some installation, so I relented :P (Though  I may still use it the former way, anyways)
* \[0.7.0-alpha\] \[Fully functional\] [HotkeysExpanded](https://github.com/Atkana/tes3mp-scripts/tree/master/0.7/HotkeysExpanded) \- () - [Atkana](https://github.com/Atkana)
   * Hotkeys Expanded utilizes the custom item system to add some new, mostly  tes3mp-related functions for use for players via quick keys. These  include: equipping sets of items, sending messages (or commands) in  chat, playing specific sounds, switching quick key bars, and running  script functions with set parameters.
* \[0.7.0-alpha\] \[Fully functional\] [ServerWarp](https://github.com/Atkana/tes3mp-scripts/tree/master/0.7/ServerWarp) \- () - [Atkana](https://github.com/Atkana)
   * Adds a /warp series of commands for ... warping.
* \[0.7.0-alpha\] \[Fully functional\] [kanaBank](https://github.com/Atkana/tes3mp-scripts/tree/master/0.7/kanaBank) \- () - [Atkana](https://github.com/Atkana)
   * Provides access to personal storage for players to utilize via command, or by activating predesignated "bankers".
* \[0.7.0-alpha\] \[Fully functional\] [kanaMOTD](https://github.com/Atkana/tes3mp-scripts/tree/master/0.7/kanaMOTD) \- () - [Atkana](https://github.com/Atkana)
   * Displays a MOTD message to every player who joins the server.
* \[0.7.0-alpha\] \[Fully functional\] [kanaRevive](https://github.com/Atkana/tes3mp-scripts/tree/master/0.7/kanaRevive) \- () - [Atkana](https://github.com/Atkana)
   * Players enter a downed state instead of dying. Other players can activate them to revive them before they bleed out.
* \[0.7.0-alpha\] \[Fully functional\] [kanaStartingItems](https://github.com/Atkana/tes3mp-scripts/tree/master/0.7/kanaStartingItems) \- () - [Atkana](https://github.com/Atkana)
   * Grant newly created characters some configurable starting items based on  their race, class, skills, favored armor, and birth sign.
* \[0.7.0-alpha\] \[Fully functional\] [flatModifiers](https://github.com/Atkana/tes3mp-scripts/blob/master/0.7/flatModifiers.lua) \- ([classInfo](https://github.com/Atkana/tes3mp-scripts/blob/master/0.7/classInfo.lua)) - [Atkana](https://github.com/Atkana)
   * Change the way that the attribute advancement modifiers on level up  are calculated. It can be configured to give a flat bonus to all  players, or a tailored bonus based on their class. Requires *classInfo*. (Note: Depending on the hot fix level of your version of 0.7-prerelease, the lines tes3mp.SendSkills(pid) may not be necessary)
* \[0.7.0-alpha\] \[Fully functional\] [classInfo](https://github.com/Atkana/tes3mp-scripts/blob/master/0.7/classInfo.lua) \- () - [Atkana](https://github.com/Atkana)
   * A compilation of data on the game's base classes and some related  functions for use in server scripts. NPC classes not yet implemented.
* \[0.7.0-alpha\] \[Fully functional\] [ccConfig](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccConfig.lua) \- () - [Texafornian](https://github.com/Texafornian)
   * Use ccConfig.lua to enable or disable various modules
   * Every module can be customized from this file
   * Over 750 lines of customization
   * Make sure to follow the correct format for each entry and remember your commas
* \[0.7.0-alpha\] \[Fully functional\] [ccAdvanceQuests](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccAdvanceQuests.lua) \- ([ccConfig](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccConfig.lua)) - [Texafornian](https://github.com/Texafornian)
   * Choose when your world file will be wiped, if at all
   * Choose which dialogue topics will be added to the world file
* \[0.7.0-alpha\] \[Fully functional\] [ccBuild](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccBuild.lua) \- ([ccConfig](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccConfig.lua)) - [Texafornian](https://github.com/Texafornian)
   * /build - Teleports players to a special cell where objects can be spawned
   * No penalties upon dying in the cell, even for hardcore players
   * Module can be configured to enable or disable wiping of the build cell
* \[0.7.0-alpha\] \[Fully functional\] [ccCellReset](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccCellReset.lua) \- ([ccConfig](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccConfig.lua)) - [Texafornian](https://github.com/Texafornian)
   * Choose when your cells will be wiped upon server restart, if at all
* \[0.7.0-alpha\] \[Fully functional\] [ccDynamicDifficulty](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccDynamicDifficulty.lua) \- ([ccConfig](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccConfig.lua)) - [Texafornian](https://github.com/Texafornian)
   * Choose whether the number of players affects the difficulty
   * Choose the value by which the difficulty changes, if enabled
* \[0.7.0-alpha\] \[Fully functional\] [ccFactions](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccFactions.lua) \- ([ccConfig](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccConfig.lua)) - [Texafornian](https://github.com/Texafornian)
   * Players can create and manage factions/guilds
   * A faction can claim one cell and members will respawn there upon death
   * /f - Faction chat
   * /faction - Main faction control window
* \[0.7.0-alpha\] \[Fully functional\] [ccHardcore](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccHardcore.lua) \- ([ccConfig](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccConfig.lua)) - [Texafornian](https://github.com/Texafornian)
   * Players can opt into "permadeath" after chargen- /ladder - Displays the HC players from highest level to lowest- Configure whether HC players drop gold on death- Configure optional safe cells (ccConfig.lua) for HC players
* \[0.7.0-alpha\] \[W.I.P.\] [ccHolidays](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccHolidays.lua) \- ([ccConfig](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccConfig.lua)) - [Texafornian](https://github.com/Texafornian)
   * Choose which holidays/events your server will celebrate- /holiday - Gives the player a gift on a specific date(s)- Note: Holiday functionality is mostly hard-coded, but you can opt in/out of any holiday
* \[0.7.0-alpha\] \[Fully functional\] [ccPerks](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccPerks.lua) \- ([ccConfig](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccConfig.lua)) - [Texafornian](https://github.com/Texafornian)
   * Token system
   * Players earn tokens every day and every second level-up
   * Every perk, including its token cost, is customizable in ccPerksConfig.lua
   * Lottery
   * Appear as Creature
   * Birthsign changer
   * Head changer
   * Hair changer
   * Gender changer
   * Race changer
   * Weather changer
   * Spawn pet (buggy)
   * Warp
* \[0.7.0-alpha\] \[Fully functional\] [ccServerMessage](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccServerMessage.lua) \- ([ccConfig](https://github.com/Texafornian/ccSuite/blob/master/scripts/ccsuite/ccConfig.lua)) - [Texafornian](https://github.com/Texafornian)
   * Choose when and what messages will automatically appear every hour- If relying on a restart schedule, warn players in advance with a warning
* \[0.7.0-alpha\] \[Fully functional\] [ProvincialMusic](https://github.com/Texafornian/ProvincialMusic) \- () - [Texafornian](https://github.com/Texafornian)
   * MWSE-LUA mod that plays user-specified music for Project Tamriel  provinces (Province Cyrodiil & Skyrim: Home of the Nords) and  Tamriel Rebuilt's Mainland Morrowind in TES III: Morrowind.
* \[0.7.0-alpha\] \[Fully functional\] [jcMarketplace](https://github.com/JakobCh/tes3mp_scripts/blob/master/jcMarketplace/jcMarketplace.lua) \- () - [JakobCh](https://github.com/JakobCh)
   * Allows you to set a price on items and sell them, also blocks other people from picking stuff up.- Supposed to be used with kanaHousing.Usage: see the script file
* \[0.7.0-alpha\] \[Fully functional\] [jsonCellLoader](https://github.com/JakobCh/tes3mp_scripts/tree/master/jsonCellLoader) \- () - [JakobCh](https://github.com/JakobCh)
   * Load a json file into the current cell.- See the top of the script file for a readme
* \[0.7.0-alpha\] \[Fully functional\] [loadtxt2esp](https://github.com/JakobCh/tes3mp_scripts/tree/master/loadtxt2esp) \- () - [JakobCh](https://github.com/JakobCh)
   * Load TXT2ESP4 files into a cellUsage: type "/loadtxt2esp 'filename'" were filename is the file in mp-stuff/data/txt2esp without the .txtExample: I've included the default example file from TXT2ESP4 and you  should be able to spawn it with "/loadtxt2esp room\_source3"Problems: There are no admin checks so anyone can run the command. Doors dont work
* \[0.7.0-alpha\] \[Fully functional\] [brewAlcohol](https://gitlab.com/rendeko/tes3mp-scripts/tree/master/brewAlcohol) \- () - [rendeko](https://gitlab.com/rendeko)
   * Allows players to brew alcoholic drinks
* \[0.7.0-alpha\] \[Fully functional\] [jrpAnim](https://gitlab.com/rendeko/tes3mp-scripts/tree/master/jrpAnim) \- () - [rendeko](https://gitlab.com/rendeko)
   * GUI for playing animations, with planned sitting/laying and idle animation support.
* \[0.7.0-alpha\] \[Fully functional\] [jrpChat](https://gitlab.com/rendeko/tes3mp-scripts/tree/master/jrpChat) \- () - [rendeko](https://gitlab.com/rendeko)
   * A roleplay based chat overhaul- All chat is local by default except for OOC- Supports nicknames
* \[0.7.0-alpha\] \[Fully functional\] [jrpCompanions](https://gitlab.com/rendeko/tes3mp-scripts/tree/master/jrpCompanions) \- () - [rendeko](https://gitlab.com/rendeko)
   * A *.json* configurable companion/follower script- (Probably) no redundant functions!- Originally forked and heavily modified from [Ecarlate](https://github.com/rickoff/Tes3mp-Ecarlate-Script)'s compagnonScript
* \[0.7.0-alpha\] \[Fully functional\] [jrpRolls](https://gitlab.com/rendeko/tes3mp-scripts/tree/master/jrpRolls) \- () - [rendeko](https://gitlab.com/rendeko)
   * A rolling script that lets players set their own roll bonuses- Roll bonuses can be set by admins
* \[0.7.0-alpha\] \[Fully functional\] [jrpStatus](https://gitlab.com/rendeko/tes3mp-scripts/tree/master/jrpStatus) \- () - [rendeko](https://gitlab.com/rendeko)
   * A player-set dialogue other players can see when activating them- Made for roleplay purposes, inspired by WoW addons
* \[0.7.0-alpha\] \[Fully functional\] [jrpTravel](https://gitlab.com/rendeko/tes3mp-scripts/tree/master/jrpTravel) \- () - [rendeko](https://gitlab.com/rendeko)
   * Activatable object/NPCs to teleport between Mages Guilds/Telvanni cities without a map- Tamriel Rebuilt support
* \[0.7.0-alpha\] \[Fully functional\] [jrpTweaks](https://gitlab.com/rendeko/tes3mp-scripts/tree/master/jrpTweaks) \- () - [rendeko](https://gitlab.com/rendeko)
   * Currently, just some bonus spells to make life easier. More planned
* \[0.7.0-alpha\] \[Fully functional\] [setSex](https://gitlab.com/rendeko/tes3mp-scripts/tree/master/setSex) \- () - [rendeko](https://gitlab.com/rendeko)
   * Allows setting of character sex on the fly.
* \[0.7.0-alpha\] \[Fully functional\] [xCard](https://gitlab.com/rendeko/tes3mp-scripts/tree/master/xCard) \- () - [rendeko](https://gitlab.com/rendeko)
   * An implementation of the X-Card concept by John Stavropoulos.
* \[0.7.0-alpha\] \[Fully functional\] [trueDisableAssassins](https://github.com/Learwolf/tes3mp-Scripts/blob/master/tes3mp-server/server/scripts/custom/lear/trueDisableAssassins.lua) \- () - [Learwolf](https://github.com/Learwolf)[Readme](https://github.com/Learwolf/tes3mp-Scripts/blob/master/tes3mp-server/server/scripts/custom/lear/trueDisableAssassinsReadMe.md)
   * This is a tes3mp script that will allow server owners to configure the spawn of Dark Brotherhood Assassins.
* \[0.7.0-alpha\] \[Fully functional\] [prematureCorpusFix](https://github.com/Learwolf/tes3mp-Scripts/blob/master/tes3mp-server/server/scripts/custom/lear/prematureCorpusFix.lua) \- () - [Learwolf](https://github.com/Learwolf)
   * This script will prevent Dagoth Gares from giving players Corprus unless they are on the correct quest to do so.   And for the player to progress when they do have the correct quest, they must activate Dagoth Gares once's he's dead.   This will prevent accidental and pre-mature Corprus acquisition.
* \[0.7.0-alpha\] \[Fully functional\] [lucanFixAldruhn](https://github.com/Learwolf/tes3mp-Scripts/blob/master/tes3mp-server/server/scripts/custom/lear/lucanFixAldruhn.lua) \- () - [Learwolf](https://github.com/Learwolf)
   * This script will prevent Lucan from continuosly spawning in Ald-ruhn during his quest line (mv\_thieftrader). If left uncheck, he can cause massive lag and spawn spamming in Ald-ruhn.
* \[0.7.0-alpha\] \[Fully functional\] [basicNeeds](https://github.com/nalal/DawnOfResdaynScriptRepo/blob/master/scripts/basicNeeds.lua) \- ([basicNeedsConfig](https://github.com/nalal/DawnOfResdaynScriptRepo/blob/master/scripts/basicNeedsConfig.lua)) - [nalal](https://github.com/nalal)
   * Adds hunger, thirst and fatigue
* \[0.7.0-alpha\] \[Fully functional\] [adminUtils](https://github.com/nalal/DawnOfResdaynScriptRepo/blob/master/scripts/addons/adminUtils.lua) \- () - [nalal](https://github.com/nalal) or Wishbone?
   * Utilities for admins
* \[0.7.0-alpha\] \[Fully functional\] [voteKick](https://github.com/nalal/DawnOfResdaynScriptRepo/blob/master/scripts/addons/voteKick.lua) \- () - [nalal](https://github.com/nalal)
   * Adds vote to kick
* \[0.7.0-alpha\] \[Fully functional\] [Guar Banker](https://github.com/Boyos999/Boyos-Tes3mp-Scripts/tree/master/Guar%20Banker) \- () - [Boyos999](https://github.com/Boyos999)
   * Doesn't actually include any banking scripts
   * Allows players to use /banker to spawn a refId (configurable) on a  cooldown, and despawn after a set interval (I tested with kanaBank)
* \[0.7.0-alpha\] \[Basic functionality\] [MotD](https://github.com/TES3MP-TeamFOSS/Scripts/tree/0.7.0-alpha-wip/MotD) \- () - [1338](https://github.com/1338) / [TES3MP-TeamFOSS](https://github.com/TES3MP-TeamFOSS)
   * Display MotD upon login
   * change with /motd change "new MotD"
* \[0.7.0-alpha\] \[Fully functional\] [FossMail](https://github.com/TES3MP-TeamFOSS/Scripts/tree/0.7.0-alpha-wip/FossMail) \- () - [hristoast](https://github.com/hristoast) / [TES3MP-TeamFOSS](https://github.com/TES3MP-TeamFOSS)
   * A script for sending messages and items between players, regardless of whether they are on/offline, via an ingame GUI.
* \[0.7.0-alpha\] \[Fully functional\] [GeoLocation](https://github.com/TES3MP-TeamFOSS/Scripts/tree/0.7.0-alpha-wip/GeoLocation) \- ([libs](https://github.com/TES3MP-TeamFOSS/Scripts/tree/0.7.0-alpha-wip/GeoLocation/lib)) - [hristoast](https://github.com/hristoast) / [TES3MP-TeamFOSS](https://github.com/TES3MP-TeamFOSS)
   * Store geographical information about players that log in
   * Requires a CoreScripts version that supports event hooks.
* \[0.7.0-alpha\] \[Fully functional\] [IrcBridge](https://github.com/TES3MP-TeamFOSS/Scripts/tree/0.7.0-alpha-wip/IrcBridge) \- ([libs](https://github.com/TES3MP-TeamFOSS/Scripts/tree/0.7.0-alpha-wip/IrcBridge/lib)) - [hristoast](https://github.com/hristoast) / [TES3MP-TeamFOSS](https://github.com/TES3MP-TeamFOSS)
   * A module to bridge IRC and the in-game chat. It can be easily enhanced to work with Discord using [matterbridge](https://github.com/42wim/matterbridge).
   * Requires a CoreScripts version that supports event hooks.
* \[0.7.0-alpha\] \[Fully functional\] [RealEstate](https://github.com/TES3MP-TeamFOSS/Scripts/tree/0.7.0-alpha-wip/RealEstate) \- ([libs](https://github.com/TES3MP-TeamFOSS/Scripts/tree/0.7.0-alpha-wip/IrcBridge/lib)) - [hristoast](https://github.com/hristoast) / [TES3MP-TeamFOSS](https://github.com/TES3MP-TeamFOSS)
   * A module to provide houses buyable by players.

&#x200B;

It's a start. I'll keep at it adding them is a slow process, one day we will have an tes3mp-modules-nexus but it isn't that day yet..EDIT: Freaking formatting on reddit deserves a special place in hell.
