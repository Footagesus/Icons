# Icons


## Use Icons in your project!

### Version 1 & 2
```lua
-- Load icons
local IconsV1 = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/main/Main.lua"))()
local IconsV2 = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()

-- Set Icons Type (default is lucide)
IconsV2.SetIconsType("lucide") -- lucide, craft and more...

-- Use Icons
local HouseIcon = IconsV2.GetIcon("house")

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Image = HouseIcon
```


### Version 2 (Beta)

#### With `Image()` function
```lua
-- Load Icons
local Icons = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()

local PrimaryColor = Color3.fromHex("#ffffff")
local SecondaryColor = Color3.fromHex("#315dff")


-- Change default icon set
Icons.SetIconsType("geist")


-- Create simple icon
local houseIcon = Icons.Image({
    Icon = "accessibility-unread", -- Default Geist icon
    Colors = { PrimaryColor, SecondaryColor }
    Size = UDim2.new(0, 32, 0, 32)
})

```

#### With WindUI `Creator` module (Themes support)
```lua
-- Load Icons
local Icons = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"))()

-- WindUI 'Creator' module
local WindUI = loadstring(game:HttpGet(--[[Paste WindUI Library]]))()
local New = WindUI.Creator.New

Icons.Init(New, "Icon") -- Second arg is default 'theme tag' Color


-- Create simple icon
local houseIcon = Icons.Image({
    Icon = "house", -- Default is Lucide
    -- Using default 'theme tag' color.
    Size = UDim2.new(0, 32, 0, 32)
})

-- Create multi-color icon (folder with accent)
local folderIcon = Icons.Image({
    -- Icon with 2 Colors
    Icon = "geist:accessibility-unread", -- Using Geist Icon
    Colors = {
        "Icon", -- Primary 'theme tag' color
        Color3.fromHex("#315dff") -- Secondary 'Color3' color 
    }, -- Theme tags or Color3 values
    
    Size = UDim2.new(0, 28, 0, 28)
})

-- Add to UI
houseIcon.IconFrame.Parent = ScreenGui -- ... Parent to your UI
folderIcon.IconFrame.Parent = ScreenGui -- ... Parent to your UI
```



### Available Icons (Credits)
- [Lucide Icons](https://github.com/lucide-icons/lucide)
- [Craft Icons](https://www.figma.com/community/file/1415718327120418204)
- [Geist Icons](https://vercel.com/geist/icons)
- [Solar Icons](https://icones.js.org/collection/solar)
- [SF Symbols](https://sf-symbols-one.vercel.app/)