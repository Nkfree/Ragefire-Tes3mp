partySystem = {}
partySystem.data = {}

function partySystem.LoadData()
    partySystem.data = jsonInterface.load("parties.json")
end

function partySystem.SaveData()
    jsonInterface.save("parties.json", partySystem.data)
end

return partySystem