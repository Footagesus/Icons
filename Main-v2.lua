-- This is a new version 

-- Test. do not use this.

local Icons = {
    ["lucide"] = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"))(),
    ["craft"] = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/craft/dist/Icons.lua"))(),
    ["geist"] = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/geist/dist/Icons.lua"))(),
}


local IconModule = {
    IconsType = "lucide",
    
    New = nil,
    IconThemeTag = nil,
}

function IconModule.SetIconsType(iconType)
    IconModule.IconsType = iconType
end

function IconModule.Init(New, IconThemeTag)
    IconModule.New = New
    IconModule.IconThemeTag = IconThemeTag
    
    return IconModule
end

function IconModule.Icon(Icon, Type) -- Type: optional
    local iconType = Icons[Type or IconModule.IconsType]
    
    if iconType.Icons[Icon] then
        return { 
            iconType.Spritesheets[tostring(iconType.Icons[Icon].Image)], 
            iconType.Icons[Icon], -- ImageRectSize, ImageRectPosition, ?Parts
        }
    end
    return nil
end

function IconModule.Image(IconConfig) -- Type: optional
    local Icon = {
        Icon = IconConfig.Icon or nil,
        Type = IconConfig.Type,
        Colors = IconConfig.Colors or { ( IconModule.IconThemeTag or Color3.new(1,1,1) ), Color3.new(1,1,1) },
        Size = IconConfig.Size or UDim2.new(0,24,0,24),
        
        IconFrame = nil,
    }
    
    local Colors = {}
    
    for _, color in next, Icon.Colors do
        Colors[_] = {
            ThemeTag = typeof(color) == "string" and color,
            Color = typeof(color) == "Color3" and color,
        }
    end
    
    local IconLabel = IconModule.Icon(Icon.Icon, Icon.Type)
    
    if IconModule.New then
        local New = IconModule.New
        
        
        
        local IconFrame = New("ImageLabel", {
            Size = Icon.Size,
            BackgroundTransparency = 1,
            ImageColor3 = Colors[1].Color or nil,
            ThemeTag = Colors[1].ThemeTag and {
                ImageColor3 = Colors[1].ThemeTag
            },
            Image = IconLabel[1],
            ImageRectSize = IconLabel[2].ImageRectSize,
            ImageRectOffset = IconLabel[2].ImageRectPosition,
        })
    
    
        if IconLabel[2].Parts then
            for _, part in next, IconLabel[2].Parts do
                local IconPartLabel = IconModule.Icon(part, Icon.Type)
                
                local IconPart = New("ImageLabel", {
                    Size = UDim2.new(1,0,1,0),
                    BackgroundTransparency = 1,
                    ImageColor3 = Colors[1 + _].Color or nil,
                    ThemeTag = Colors[1 + _].ThemeTag and {
                        ImageColor3 = Colors[1 + _].ThemeTag
                    },
                    Image = IconPartLabel[1],
                    ImageRectSize = IconPartLabel[2].ImageRectSize,
                    ImageRectOffset = IconPartLabel[2].ImageRectPosition,
                    Parent = IconFrame,
                })
            end
        end
        
        Icon.IconFrame = IconFrame
    else
        local IconFrame = Instance.new("ImageLabel")
        IconFrame.Size = Icon.Size
        IconFrame.BackgroundTransparency = 1
        IconFrame.ImageColor3 = Colors[1].Color
        IconFrame.Image = IconLabel[1]
        IconFrame.ImageRectSize = IconLabel[2].ImageRectSize
        IconFrame.ImageRectOffset = IconLabel[2].ImageRectPosition
        
        
        if IconLabel[2].Parts then
            for _, part in next, IconLabel[2].Parts do
                local IconPartLabel = IconModule.Icon(part, Icon.Type)
                
                local IconPart = Instance.New("ImageLabel")
                IconPart.Size = UDim2.new(1,0,1,0)
                IconPart.BackgroundTransparency = 1
                IconPart.ImageColor3 = Colors[1 + _].Color
                IconPart.Image = IconPartLabel[1]
                IconPart.ImageRectSize = IconPartLabel[2].ImageRectSize
                IconPart.ImageRectOffset = IconPartLabel[2].ImageRectPosition
                IconPart.Parent = IconFrame
            end
        end
        
        Icon.IconFrame = IconFrame
    end
    
    
    return Icon
end

return IconModule
