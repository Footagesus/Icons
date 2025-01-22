
-- https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/Main.lua

local Icons = {
    ["lucide"] = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/Main.lua"))()
    
    
    -- More soon 
    -- :)
}


local IconModule = {
    IconsType = "lucide" --
}

function IconModule.SetIconsType(iconType)
    IconModule.IconsType = iconType
end

function IconModule.Icon(Icon, Type) -- Type: optional
    local iconType = Icons[Type or IconsType]
    
    if iconType.Icons[Icon] then
        return { iconType.Spritesheets[tostring(iconType.Icons[Icon].Image)], iconType.Icons[Icon] }
    end
    return nil
end

return IconModule
