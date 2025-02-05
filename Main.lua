
-- https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua

local Icons = {
    ["lucide"] = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua",
    ["craft"] = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/craft/dist/Icons.lua",
    
    
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
    local iconType = loadstring(game:HttpGetAsync( Icons[Type or IconModule.IconsType] ))()
    
    if iconType.Icons[Icon] then
        return { iconType.Spritesheets[tostring(iconType.Icons[Icon].Image)], iconType.Icons[Icon] }
    end
    return nil
end

return IconModule
