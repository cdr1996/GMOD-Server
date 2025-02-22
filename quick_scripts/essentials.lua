local tag = "essentials"

-- Disable high pitched ringing sound effect when damaged by an explosion
hook.Add("OnDamagedByExplosion", tag, function(ply, dmginfo)
    return true
end)