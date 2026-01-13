-- This is a new version   

local cloneref = (cloneref or clonereference or function(instance) return instance end)

local RunService = cloneref(game:GetService("RunService"))
local HttpService = cloneref(game:GetService("HttpService"))

local function Get(url)
    if writefile and game.HttpGet then
        return game:HttpGet(url)
    else
        return HttpService:GetAsync(url)
    end
end


local IconModule = {  
    IconsType = "lucide",  
      
    New = nil,  
    IconThemeTag = nil,  
      
    Icons = {  
        lucide = loadstring(Get("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"))(),
        solar = loadstring(Get("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/solar/dist/Icons.lua"))(),
        craft = loadstring(Get("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/craft/dist/Icons.lua"))(),
        geist = loadstring(Get("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/geist/dist/Icons.lua"))(),
        sfsymbols = loadstring(Get("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/sfsymbols/dist/Icons.lua"))(),
    }
}  
  
local function parseIconString(iconString)  
    if type(iconString) == "string" then  
        local splitIndex = iconString:find(":")  
        if splitIndex then  
            local iconType = iconString:sub(1, splitIndex - 1)  
            local iconName = iconString:sub(splitIndex + 1)  
            return iconType, iconName  
        end  
    end  
    return nil, iconString  
end  

function IconModule.AddIcons(packName, iconsData)
    if type(packName) ~= "string" or type(iconsData) ~= "table" then
        error("AddIcons: packName must be string, iconsData must be table")
        return
    end
    
    if not IconModule.Icons[packName] then
        IconModule.Icons[packName] = {
            Icons = {},
            Spritesheets = {}
        }
    end
    
    for iconName, iconValue in pairs(iconsData) do
        if type(iconValue) == "number" or (type(iconValue) == "string" and iconValue:match("^rbxassetid://")) then
            local imageId = iconValue
            if type(iconValue) == "number" then
                imageId = "rbxassetid://" .. tostring(iconValue)
            end
            
            IconModule.Icons[packName].Icons[iconName] = {
                Image = imageId,
                ImageRectSize = Vector2.new(0, 0),
                ImageRectPosition = Vector2.new(0, 0),
                Parts = nil
            }
            IconModule.Icons[packName].Spritesheets[imageId] = imageId
            
        elseif type(iconValue) == "table" then
            if iconValue.Image and iconValue.ImageRectSize and iconValue.ImageRectPosition then
                local imageId = iconValue.Image
                if type(imageId) == "number" then
                    imageId = "rbxassetid://" .. tostring(imageId)
                end
                
                IconModule.Icons[packName].Icons[iconName] = {
                    Image = imageId,
                    ImageRectSize = iconValue.ImageRectSize,
                    ImageRectPosition = iconValue.ImageRectPosition,
                    Parts = iconValue.Parts
                }
                
                if not IconModule.Icons[packName].Spritesheets[imageId] then
                    IconModule.Icons[packName].Spritesheets[imageId] = imageId
                end
            else
                warn("AddIcons: Invalid spritesheet data format for icon '" .. iconName .. "'")
            end
        else
            warn("AddIcons: Unsupported data type for icon '" .. iconName .. "': " .. type(iconValue))
        end
    end
end
  
function IconModule.SetIconsType(iconType)  
    IconModule.IconsType = iconType  
end  
  
function IconModule.Init(New, IconThemeTag)  
    IconModule.New = New  
    IconModule.IconThemeTag = IconThemeTag  
      
    return IconModule  
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
  

function IconModule.Icon2(Icon, Type, DefaultFormat)  
    return IconModule.Icon(Icon, Type, true)  
end  
  
function IconModule.Image(IconConfig)  
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
      
    local IconLabel = IconModule.Icon2(Icon.Icon, Icon.Type)  
    local isrbxassetid = typeof(IconLabel) == "string" and string.find(IconLabel, 'rbxassetid://')
    
    if IconModule.New then  
        local New = IconModule.New  
          
          
          
        local IconFrame = New("ImageLabel", {  
            Size = Icon.Size,  
            BackgroundTransparency = 1,  
            ImageColor3 = Colors[1].Color or nil,  
            ThemeTag = Colors[1].ThemeTag and {  
                ImageColor3 = Colors[1].ThemeTag  
            },  
            Image = isrbxassetid and IconLabel or IconLabel[1],  
            ImageRectSize = isrbxassetid and nil or IconLabel[2].ImageRectSize,  
            ImageRectOffset = isrbxassetid and nil or IconLabel[2].ImageRectPosition,  
        })  
      
      
        if not isrbxassetid and IconLabel[2].Parts then  
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
        IconFrame.Image = isrbxassetid and IconLabel or IconLabel[1]  
        IconFrame.ImageRectSize = isrbxassetid and nil or IconLabel[2].ImageRectSize  
        IconFrame.ImageRectOffset = isrbxassetid and nil or IconLabel[2].ImageRectPosition  
          
          
        if not isrbxassetid and IconLabel[2].Parts then  
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