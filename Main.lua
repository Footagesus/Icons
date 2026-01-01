-- This is an outdated version
-- Use new Main-v2.lua

local Icons = {
    ["lucide"] = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"))(),
    ["craft"] = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/craft/dist/Icons.lua"))(),
}


local IconModule = {
    IconsType = "lucide" --
}

function IconModule.SetIconsType(iconType)
    IconModule.IconsType = iconType
end

function IconModule.Icon(Icon, Type, DefaultFormat)
    DefaultFormat = DefaultFormat ~= false
    local iconType, iconName = parseIconString(Icon)  
    
    local targetType = iconType or Type or IconModule.IconsType  
    local targetName = iconName  
      
    local iconSet = IconModule.Icons[targetType]  
      
    if iconSet and iconSet.Icons and iconSet.Icons[targetName] then  
        return {   
            iconSet.Spritesheets[tostring(iconSet.Icons[targetName].Image)],   
            iconSet.Icons[targetName],  
        }  
    elseif iconSet and iconSet[targetName] and string.find(iconSet[targetName], "rbxassetid://") then
        return DefaultFormat and { 
            iconSet[targetName], 
            { ImageRectSize = Vector2.new(0,0), ImageRectPosition = Vector2.new(0,0) }
        } or iconSet[targetName]
    end  
    return nil  
end  

function IconModule.GetIcon(Icon, Type)  
    return IconModule.Icon(Icon, Type, false) 
end  

return IconModule
