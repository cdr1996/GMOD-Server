local tag = "damage_modes"
local modes = {
    GOD_MODE = "god",
    PVP_MODE = "pvp",
}

local PLAYER = FindMetaTable("Player")

function PLAYER:SetDamageMode(mode)
    if not mode then return end
    if not modes[mode] then return end

    self:SetNWString("damage_mode", mode)
end

function PLAYER:GetDamageMode()
    return self:GetNWString("damage_mode")
end

-- Players in god cannot attack those without and vice versa
hook.Add("PlayerShouldTakeDamage", tag, function(ply, attacker)
    if ply:GetDamageMode() == "god" then
        return false
    end

    if attacker:GetDamageMode() == "god" and ply:GetDamageMode() == "pvp" then
        return false
    end
end)

-- Don't allow noclip for players in pvp mode
hook.Add("PlayerNoClip", tag, function(ply, state)
    if ply:GetDamageMode() == "pvp" then
        return false
    end
end)

local default = {
    [1] = "weapon_physgun",
    [2] = "gmod_camera",
    [3] = "none", -- Hands
}

hook.Add("PlayerLoadout", tag, function(ply)
    if ply.GetDamageMode then
        if ply:GetDamageMode() == "god" then
            for key, wep in pairs(default) do
                ply:Give(wep)
                
                return true
            end
        end
    end
end)