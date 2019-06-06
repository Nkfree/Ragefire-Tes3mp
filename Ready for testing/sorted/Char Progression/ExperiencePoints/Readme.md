## Exerpience Point Progression
 by Ragefire
 
### Used as Example

```
Menus["ragepoint main"] = {
    text = {color.Gold .. "Rage Level: " .. color.Coral, menuHelper.variables.currentPlayerDataVariable("customVariables.rageLevel"), "\n\n" ..
			color.Gray .. "Level Progress: " .. color.Coral,	
				menuHelper.variables.currentPlayerDataVariable("customVariables.rageExpProgress"), "/", 
				menuHelper.variables.currentPlayerDataVariable("customVariables.rageExpRequired"), color.Gray .. " Percentage: " .. color.Coral,
				menuHelper.variables.currentPlayerDataVariable("customVariables.rageExpPercentage"), "%" .. color.Coral,"\n\n" ..
			color.Gray .. "Rage Points Spent: " .. color.Coral,
				menuHelper.variables.currentPlayerDataVariable("customVariables.ragePointsSpent"), "\n\n" ..
			color.Gray .."Rage Points Available: " .. color.Coral,
				menuHelper.variables.currentPlayerDataVariable("customVariables.ragePoints"), "\n\n" ..
			color.White .. "Select a " .. color.Gold .. "Tree " .. color.White .. "to spend " .. color.Coral .. "Rage Points " ..
			 color.White .. "on."
    },
	buttons = {
        { caption = color.Gold .. "Magic Tree",
            destinations = { menuHelper.destinations.setDefault("magic tree") } 
		},
		{ caption = color.Gold .. "Healer Tree",
            destinations = { menuHelper.destinations.setDefault("healer tree") } 
		},
		{ caption = color.Gold .. "War Tree",
            destinations = { menuHelper.destinations.setDefault("war tree") }	
		},
		{ caption = color.Gold .. "Defense Tree",
            destinations = { menuHelper.destinations.setDefault("defense tree") }	
		},
		{ caption = color.Gold .. "Stealth Tree",
            destinations = { menuHelper.destinations.setDefault("stealth tree") }	
		},
		--{ caption = color.Gold .. "Artisan Tree",
        --    destinations = { menuHelper.destinations.setDefault("artisan tree") }	
		--},
		{ caption = color.Gold .. "Main Menu",
            destinations = { menuHelper.destinations.setDefault("ragefire help") }	
		},
		{ caption = color.Gold .. "Exit", destinations = nil },
    }
}
Menus["lack of points"] = {
    text = color.Gold .. "You do not have enough " .. color.Coral .. "Rage " .. color.Gold .. "points for that ability.",

	buttons = {
        { caption = color.Gold .. "Go Back", destinations = { menuHelper.destinations.setFromCustomVariable("previousCustomMenu") } },
		{ caption = color.Gold .. "Exit", destinations = nil },
    }
}
Menus["trait maxed"] = {
    text = color.Gold .. "That " .. color.Coral .. "trait " .. color.Gold .. "has already been maxed.",

	buttons = {
        { caption = color.Gold .. "Go Back", destinations = { menuHelper.destinations.setFromCustomVariable("previousCustomMenu") } },
		{ caption = color.Gold .. "Exit", destinations = nil },
    }
}
Menus["mastery unavailable"] = {
    text = color.Gold .. "You must spend more points into this " .. color.Coral .. "tree " .. color.Gold .. "before you can access this.",

	buttons = {
        { caption = color.Gold .. "Go Back", destinations = { menuHelper.destinations.setFromCustomVariable("previousCustomMenu") } },
		{ caption = color.Gold .. "Exit", destinations = nil },
    }
}
Menus["coming soon"] = {
    text = color.Gold .. "This will be available soon.",

	buttons = {
        { caption = color.Gold .. "Go Back", destinations = { menuHelper.destinations.setFromCustomVariable("previousCustomMenu") } },
		{ caption = color.Gold .. "Exit", destinations = nil },
    }
}

-- Artisan Tree
Menus["artisan tree"] = {
    text = {color.Gold .. "Artisan Tree\n\n" ..
			color.Gray .. "Current Rage Level: " .. color.Coral,
				menuHelper.variables.currentPlayerDataVariable("customVariables.rageLevel"), "\n\n" ..
			color.Gray .. "Points Available: " .. color.Coral, 
			color.Gray .. "Total Points put into Artisan Tree: " .. color.Coral,
				menuHelper.variables.currentPlayerDataVariable("customVariables.artisanPointsSpent"), "\n\n" ..
			color.Gray .. "Points Available: " .. color.Coral, 
				menuHelper.variables.currentPlayerDataVariable("customVariables.ragePoints"),"\n\n" ..
			color.White .. "Artisan points increase your current " .. color.Gold .. "skills " .. color.White .. "value",
	},
	buttons = {
		{ caption = {color.Gold .. "Fletching: " .. color.Coral .. "Makes Basic Marksman items " .. color.Gold .. "- Cost: " .. color.Coral .. "5 " ..
					  color.Gold .. "- Max: " ..
				     color.Coral, menuHelper.variables.currentPlayerDataVariable("customVariables.artisanFletching"),
					 "/1"}, 
			destinations = { 
				menuHelper.destinations.setDefault("lack of points"),
				menuHelper.destinations.setConditional("trait maxed",
				{
                    menuHelper.conditions.requirePlayerFunction("HasCustomVariableMaxValue", {"artisanFletching", 1})
                }),
				menuHelper.destinations.setConditional("artisan tree",
				{
					menuHelper.conditions.requirePlayerFunction("HasCustomVariableMinValue", {"ragePoints", 5})
				},
				{
                    menuHelper.effects.runPlayerFunction("SubtractFromCustomVariable", {"ragePoints", 2}),
					menuHelper.effects.runPlayerFunction("AddToCustomVariable", {"ragePointsSpent", 2}),
					menuHelper.effects.runPlayerFunction("AddToCustomVariable", {"artisanPointsSpent", 2}),
					menuHelper.effects.runPlayerFunction("AddToCustomVariable", {"artisanFletching", 1})
                })
			}
		},
		{ caption = {color.Gold .. "Leather Crafting: " .. color.Coral .. "Makes common leather " .. color.Gold .. "- Cost: " .. color.Coral .. "5 " .. color.Gold .. "- Max: " ..
				     color.Coral, menuHelper.variables.currentPlayerDataVariable("customVariables.artisanLeather"),
					 "/1"}, 
			destinations = { 
				menuHelper.destinations.setDefault("lack of points"),
				menuHelper.destinations.setConditional("trait maxed",
				{
                    menuHelper.conditions.requirePlayerFunction("HasCustomVariableMaxValue", {"artisanLeather", 1})
                }),
				menuHelper.destinations.setConditional("artisan tree",
				{
					menuHelper.conditions.requirePlayerFunction("HasCustomVariableMinValue", {"ragePoints", 5})
				},
				{
                    menuHelper.effects.runPlayerFunction("SubtractFromCustomVariable", {"ragePoints", 5}),
					menuHelper.effects.runPlayerFunction("AddToCustomVariable", {"ragePointsSpent", 5}),
					menuHelper.effects.runPlayerFunction("AddToCustomVariable", {"artisanPointsSpent", 2}),
					menuHelper.effects.runPlayerFunction("AddToCustomVariable", {"artisanLeather", 1}),
                })
			}
		},
		{ caption = {color.Gold .. "Tier II Artisan Tree " .. color.Gold .. "- Requires Rage Level " .. color.Coral .. "5 " .. color.Gold .. "Current: " .. color.Coral,
						menuHelper.variables.currentPlayerDataVariable("customVariables.rageLevel"), 
					"/5"},
            displayConditions = {
                menuHelper.conditions.requirePlayerFunction("HasLessThanCustomVariableValue", {"rageLevel", 5})
            },
            destinations = {
                menuHelper.destinations.setDefault("mastery unavailable")
            }
        },
		{ caption = {color.Gold .. "Tier II Artisan Tree =>"
					},
            displayConditions = {
                menuHelper.conditions.requirePlayerFunction("HasCustomVariableMinValue", {"rageLevel", 5})
            },
            destinations = {
                menuHelper.destinations.setDefault("coming soon")
            }
        },
		{ caption = color.Gold .."Back", destinations = { menuHelper.destinations.setDefault("ragepoint main") } },
        { caption = color.Gold .. "Exit", destinations = nil }
    }
}
```