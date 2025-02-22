local tag = "player_limits"

local valid_names = {
    ["props"] = true,
    ["ragdolls"] = true,
    ["vehicles"] = true,
    ["effects"] = true,
    ["balloons"] = true,
    ["cameras"] = true,
    ["npcs"] = true,
    ["sents"] = true,
    ["dynamite"] = true,
    ["lamps"] = true,
    ["lights"] = true,
    ["wheels"] = true,
    ["thrusters"] = true,
    ["hoverballs"] = true,
    ["buttons"] = true,
    ["emitters"] = true,
}

local default_limits = {
    ["props"] = 200,
    ["ragdolls"] = 10,
    ["vehicles"] = 10,
    ["effects"] = 10,
    ["balloons"] = 20,
    ["cameras"] = 10,
    ["npcs"] = 10,
    ["sents"] = 10,
    ["dynamite"] = 10,
    ["lamps"] = 10,
    ["lights"] = 10,
    ["wheels"] = 10,
    ["thrusters"] = 10,
    ["hoverballs"] = 20,
    ["buttons"] = 10,
    ["emitters"] = 10,
}

local PLAYER = FindMetaTable("Player")

-- Allow individual limits
function PLAYER:SetLimit(name, amount)
    if not valid_names[name] then return end
    if not amount then return end

    self.player_limits[name] = amount
end

function PLAYER:GetLimit(name)
    if not name then return end
    if not valid_names[name] then return end

    return self.player_limits[name] or "unknown"
end

hook.Add("PlayerCheckLimit", tag, function(ply, name, cur, max)
    if cur == ply:GetLimit(name) then
        return false
    end
end)

hook.Add("PlayerInitialSpawn", tag, function(ply)
    ply.player_limits = default_limits
end)