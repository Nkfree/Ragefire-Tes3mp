--disallow russian names when on english windows
russiannames = {}


russiannames = function(eventStatus)
 tableHelper.insertValues(config.disallowedNameStrings,{ "bitch", "blowjob", "blow job", "cocksuck", "cunt", "ejaculat", "faggot", "fellatio", "fuck", "gas the ", "Hitler", "jizz", "nigga", "nigger", "smegma", "vagina", "whore","к","т","И","щ","е","Д","н","Д","л","м"})
end


customEventHooks.registerHandler("OnServerPostInit", russiannames)