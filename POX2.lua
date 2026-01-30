local Env = getfenv()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalizationService = game:GetService("LocalizationService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

local TextChatService = game.TextChatService
local ChatWindowConfiguration = TextChatService.ChatWindowConfiguration
ChatWindowConfiguration.Enabled = true

local success1, error1 = pcall(function()
    local Devv = ReplicatedStorage:WaitForChild("devv", 10)
    local DevvModule = require(Devv)
    local Signal = DevvModule.load("Signal")
    local V3Item = DevvModule.load("v3item")
    local Inventory = V3Item.inventory
    local ClientReplicator = DevvModule.load("ClientReplicator")
end)

local success2, error2 = pcall(function()
end)

local DevvModule = ReplicatedStorage:FindFirstChild("devv")
if not DevvModule then return end

local WindUIUrl = "https://pastefy.app/mD195Bsx/raw"
local WindUICode = game:HttpGet(WindUIUrl)
local WindUI = loadstring(WindUICode)()

local IconsUrl = "https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.lua"
local IconsCode = game:HttpGet(IconsUrl)
local IconsModule = loadstring(IconsCode)()

IconsModule.Init(WindUI.New, nil)

local Color3 = Color3.new
local Color3FromHex = Color3.fromHex
local UDim2 = UDim2.new
local UDim2FromOffset = UDim2.fromOffset

local function CreateGradientText(text, startColor, endColor)
    local result = ""
    local length = string.len(text)
    
    for i = 1, length do
        local char = string.sub(text, i, i)
        local t = (i - 1) / (length - 1)
        
        local r = startColor.R + (endColor.R - startColor.R) * t
        local g = startColor.G + (endColor.G - startColor.G) * t
        local b = startColor.B + (endColor.B - startColor.B) * t
        
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
            math.floor(r * 255), math.floor(g * 255), math.floor(b * 255), char)
    end
    
    return result
end

local function CreateGradientColorSequence(startColor, endColor)
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, startColor),
        ColorSequenceKeypoint.new(0.5, Color3FromHex("118AB2")),
        ColorSequenceKeypoint.new(1, endColor)
    })
end

local Window = WindUI:CreateWindow({
    Name = CreateGradientText("POX HUB", Color3FromHex("#00DBDE"), Color3FromHex("#FC00FF")),
    Size = UDim2FromOffset(460, 395),
    Transparency = true,
    Theme = "Dark",
    Icon = "sparkles",
    Author = CreateGradientText("Ohio", Color3FromHex("#00FF87"), Color3FromHex("#60EFFF")),
    SideBarWidth = 170,
    IconThemed = true,
    Folder = "POX HUB",
    
    User = {
        Enabled = true,
        Callback = function() end,
        Anonymous = false
    }
})

Window:SetBackgroundImageTransparency(0.4)

Window:EditOpenButton({
    Title = CreateGradientText(" Express ", Color3FromHex("#00DBDE"), Color3FromHex("#FC00FF")),
    Icon = "monitor",
    Color = CreateGradientColorSequence(Color3FromHex("#1E3A8A"), Color3FromHex("#06D6A0")),
    Draggable = true,
    CornerRadius = UDim.new(5, 20),
    StrokeThickness = 1.9
})

local PlayerTab = Window:Tab({Title = "玩家", Icon = "user"})
local CombatTab = Window:Tab({Title = "暴力", Icon = "sword"})
local FarmTab = Window:Tab({Title = "自动", Icon = "coins"})
local ItemsTab = Window:Tab({Title = "拾取", Icon = "package"})
local SkinsTab = Window:Tab({Title = "美化", Icon = "crosshair"})
local OtherTab = Window:Tab({Title = "其它", Icon = "settings"})

local GlobalSettings = {
    TP_Speed = 1,
    TP_Enabled = false,
    InfiniteJump = false,
    AntiVoid = false,
    AntiAdmin = false,
    AttackMode = "普通拳",
    OnePunch = false,
    AutoStomp = false,
    AutoGrab = false,
    NoKnock = false,
    AutoArmor = false,
    ArmorType = "Light Vest",
    AutoHeal = false,
    AutoFarmATM = false,
    AutoChristmas = false,
    AutoCandy = false,
    AutoCash = false,
    AutoBank = false,
    AutoRing = false,
    AutoRareItems = false,
    AutoGems = false,
    AutoSafe = false,
    AutoLockpick = false,
    AutoApplySkin = false,
    ForceVoid = false,
    AimAssist = false,
    AimSensitivity = 1,
    ESP_Main = false,
    ESP_Box = false,
    ESP_Name = false,
    ESP_Health = false,
    ESP_Money = false,
    ESP_ATM = false,
    FollowEnabled = false,
    FollowIgnoreFriends = false,
    GunFollowEnabled = false,
    GunFollowIgnoreFriends = false
}

local AnimationPacks = {
    ["僵尸FE"] = {
        idle = {3489171152, 3489171152},
        jump = 616161997,
        climb = 616156119,
        fall = 616157476,
        run = 3489173414,
        walk = 3489174223
    },
    ["幽灵"] = {
        idle = {616006778, 616008087},
        jump = 616008936,
        climb = 616003713,
        fall = 616005863,
        run = 616013216,
        walk = 616010382
    },
    ["长者"] = {
        idle = {845397899, 845400520},
        jump = 845398858,
        climb = 845392038,
        fall = 845396048,
        run = 845386501,
        walk = 845403856
    },
    ["英雄"] = {
        idle = {616111295, 616113536},
        jump = 616115533,
        climb = 616104706,
        fall = 616108001,
        run = 616117076,
        walk = 616122287
    },
    ["法师"] = {
        idle = {707742142, 707855907},
        jump = 707853694,
        climb = 707826056,
        fall = 707829716,
        run = 707861613,
        walk = 707897309
    },
    ["经典僵尸"] = {
        idle = {616158929, 616160636},
        jump = 616161997,
        climb = 616156119,
        fall = 616157476,
        run = 616163682,
        walk = 616168032
    },
    ["吸血鬼"] = {
        idle = {1083445855, 1083450166},
        jump = 1083455352,
        climb = 1083439238,
        fall = 1083443587,
        run = 1083462077,
        walk = 1083473930
    }
}

local RareItems = {
    "Green Lucky Block",
    "Orange Lucky Block",
    "Purple Lucky Block",
    "Blue Candy Cane",
    "Suitcase Nuke",
    "Easter Basket",
    "Gold Cup",
    "Gold Crown",
    "Pearl Necklace",
    "Treasure Map",
    "Spectral Scythe",
    "Bunny Balloon",
    "Ghost Balloon",
    "Clover Balloon",
    "Bat Balloon",
    "Gold Clover Balloon",
    "Golden Rose",
    "Black Rose",
    "Heart Balloon",
    "Skull Balloon",
    "Money Printer"
}

local Gems = {
    "Amethyst",
    "Sapphire",
    "Emerald",
    "Topaz",
    "Ruby",
    "Diamond Ring",
    "Diamond",
    "Void Gem",
    "Dark Matter Gem",
    "Rollie",
    "Gold Bar"
}

local Skins = {
    "Sparkler", "Solid Gold", "Dark Matter", "Anti Matter", "Void Mystic",
    "Tactical", "Solid Gold Tactical", "Future White", "Future Black",
    "Christmas Future", "Gift Wrapped", "Crimson Blood", "Reaper",
    "Void Reaper", "Christmas Toy", "Invisible", "Diamond Pixel",
    "Frozen-Gold", "Atomic Nature", "Sakura", "Elite", "Death Blossom-Gold",
    "Atomic Water", "Atomic Amethyst", "Atomic Flame", "Sub-Zero",
    "Void-Ray", "Frozen Diamond", "Void Nightmare", "Golden Snow",
    "Patriot", "MM2 Barrett", "Prestige Barnett", "Skin Walter",
    "Pirate", "Rose", "Black Rose", "Firework", "Cursed Pumpkin",
    "Cannon", "Firework", "Gold Cannon", "Lucky Clover", "Freedom",
    "Obsidian"
}

local Weapons = {
    "Revolver", "Shotgun", "Rifle", "SMG", "LMG", "Sniper",
    "Pistol", "Machine Gun", "Assault Rifle", "Bazooka"
}

local Armors = {
    "Light Vest", "Heavy Vest", "Military Vest", "EOD Vest"
}

local HealItems = {
    "Bandage", "Cookie", "Medkit", "First Aid"
}

local Masks = {
    "Surgeon Mask", "Clown Mask", "Gas Mask", "Hockey Mask"
}

PlayerTab:Dropdown({
    Title = "选择动作包 (R15)",
    Default = "吸血鬼",
    Values = {"吸血鬼", "英雄", "经典僵尸", "法师", "幽灵", "长者", "僵尸FE"},
    Callback = function(selected)
        local animData = AnimationPacks[selected]
        if not animData then return end
        
        if LocalPlayer.Character then
            local animate = LocalPlayer.Character:FindFirstChild("Animate")
            if animate then
                animate.Disabled = true
                
                if animData.idle and animData.idle[1] then
                    animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=" .. animData.idle[1]
                end
                if animData.idle and animData.idle[2] then
                    animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=" .. animData.idle[2]
                end
                if animData.walk then
                    animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. animData.walk
                end
                if animData.run then
                    animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. animData.run
                end
                if animData.jump then
                    animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. animData.jump
                end
                if animData.climb then
                    animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. animData.climb
                end
                if animData.fall then
                    animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. animData.fall
                end
                
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                
                animate.Disabled = false
            end
        end
    end
})

PlayerTab:Slider({
    Title = "TP 移动速度",
    Default = 1,
    Min = 1,
    Max = 15,
    Callback = function(value)
        GlobalSettings.TP_Speed = value
    end
})

PlayerTab:Toggle({
    Title = "启用 TP 移动",
    Default = false,
    Callback = function(state)
        GlobalSettings.TP_Enabled = state
        
        if state then
            task.spawn(function()
                local connection
                connection = RunService.Heartbeat:Connect(function(delta)
                    if not GlobalSettings.TP_Enabled then
                        connection:Disconnect()
                        return
                    end
                    
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = LocalPlayer.Character.HumanoidRootPart
                        local camera = Workspace.CurrentCamera
                        
                        local forward = camera.CFrame.LookVector
                        local right = camera.CFrame.RightVector
                        local up = Vector3.new(0, 1, 0)
                        
                        local direction = Vector3.new(0, 0, 0)
                        
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                            direction = direction + forward
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                            direction = direction - forward
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                            direction = direction - right
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                            direction = direction + right
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            direction = direction + up
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or 
                           UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                            direction = direction - up
                        end
                        
                        if direction.Magnitude > 0 then
                            direction = direction.Unit * GlobalSettings.TP_Speed * delta * 100
                            hrp.CFrame = hrp.CFrame + direction
                        end
                    end
                end)
            end)
        end
    end
})

PlayerTab:Toggle({
    Title = "无限跳跃",
    Default = false,
    Callback = function(state)
        GlobalSettings.InfiniteJump = state
        
        if state then
            local connection
            connection = UserInputService.JumpRequest:Connect(function()
                if GlobalSettings.InfiniteJump and LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end
    end
})

PlayerTab:Toggle({
    Title = "防虚空",
    Default = false,
    Callback = function(state)
        GlobalSettings.AntiVoid = state
        
        if state then
            local connection
            connection = RunService.Stepped:Connect(function(time, delta)
                if not GlobalSettings.AntiVoid then
                    connection:Disconnect()
                    return
                end
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    if hrp.Position.Y < Workspace.FallenPartsDestroyHeight + 10 then
                        hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
                    end
                end
            end)
        end
    end
})

PlayerTab:Button({
    Title = "启动飞行",
    Callback = function()
        local flyScript = game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt")
        loadstring(flyScript)()
    end
})

CombatTab:Toggle({
    Title = "反管理员",
    Default = false,
    Callback = function(state)
        GlobalSettings.AntiAdmin = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AntiAdmin do
                    task.wait(1)
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                        end
                    end
                end
            end)
        end
    end
})

CombatTab:Dropdown({
    Title = "攻击方式",
    Default = "普通拳",
    Values = {"普通拳", "超级拳", "踢", "飞踢"},
    Callback = function(selected)
        GlobalSettings.AttackMode = selected
    end
})

CombatTab:Toggle({
    Title = "杀戮光环",
    Default = false,
    Callback = function(state)
        GlobalSettings.OnePunch = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.OnePunch do
                    task.wait(0.1)
                    
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - 
                                                 player.Character.HumanoidRootPart.Position).Magnitude
                                
                                if distance < 20 then
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})

CombatTab:Toggle({
    Title = "子追开关",
    Default = false,
    Callback = function(state)
        GlobalSettings.FollowEnabled = state
        
        if state then
            task.spawn(function()
                local camera = Workspace.CurrentCamera
                local targetText = Drawing.new("Text")
                targetText.Visible = false
                targetText.Size = 20
                targetText.Center = false
                targetText.Outline = true
                targetText.OutlineColor = Color3.new(0, 0, 0)
                targetText.Color = Color3.new(1, 1, 1)
                targetText.Text = "目标: None"
                targetText.Position = Vector2.new(1720, 50)
                targetText.Font = 2
                
                local distanceText = Drawing.new("Text")
                distanceText.Visible = false
                distanceText.Size = 18
                distanceText.Center = true
                distanceText.Outline = true
                distanceText.OutlineColor = Color3.new(0, 0, 0)
                distanceText.Color = Color3.new(0, 1, 0)
                distanceText.Font = 2
                
                local healthText = Drawing.new("Text")
                healthText.Visible = false
                healthText.Size = 18
                healthText.Center = true
                healthText.Outline = true
                healthText.OutlineColor = Color3.new(0, 0, 0)
                healthText.Color = Color3.new(1, 1, 1)
                healthText.Font = 2
                
                local connection
                connection = RunService.Heartbeat:Connect(function()
                    if not GlobalSettings.FollowEnabled then
                        targetText.Visible = false
                        distanceText.Visible = false
                        healthText.Visible = false
                        connection:Disconnect()
                        return
                    end
                    
                    local closestPlayer = nil
                    local closestDistance = math.huge
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and 
                           player.Character:FindFirstChild("HumanoidRootPart") then
                           
                            if GlobalSettings.FollowIgnoreFriends and 
                               LocalPlayer:IsFriendsWith(player.UserId) then
                                continue
                            end
                            
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - 
                                             player.Character.HumanoidRootPart.Position).Magnitude
                            
                            if distance < closestDistance then
                                closestDistance = distance
                                closestPlayer = player
                            end
                        end
                    end
                    
                    if closestPlayer then
                        targetText.Text = "目标: " .. closestPlayer.Name
                        targetText.Visible = true
                        
                        local screenPos, onScreen = camera:WorldToViewportPoint(
                            closestPlayer.Character.HumanoidRootPart.Position
                        )
                        
                        if onScreen then
                            distanceText.Text = string.format("%.1f studs", closestDistance)
                            distanceText.Position = Vector2.new(screenPos.X, screenPos.Y + 20)
                            distanceText.Visible = true
                            
                            local humanoid = closestPlayer.Character:FindFirstChild("Humanoid")
                            if humanoid then
                                healthText.Text = string.format("%d/%d", humanoid.Health, humanoid.MaxHealth)
                                healthText.Position = Vector2.new(screenPos.X, screenPos.Y + 40)
                                healthText.Visible = true
                            end
                        end
                    else
                        targetText.Visible = false
                        distanceText.Visible = false
                        healthText.Visible = false
                    end
                end)
                
                local focusConnection
                focusConnection = UserInputService.WindowFocusReleased:Connect(function()
                    targetText.Visible = false
                    distanceText.Visible = false
                    healthText.Visible = false
                end)
            end)
        end
    end
})

CombatTab:Toggle({
    Title = "忽略好友",
    Default = false,
    Callback = function(state)
        GlobalSettings.FollowIgnoreFriends = state
    end
})

CombatTab:Toggle({
    Title = "射线枪子追开关",
    Default = false,
    Callback = function(state)
        GlobalSettings.GunFollowEnabled = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.GunFollowEnabled do
                    task.wait(0.05)
                end
            end)
        end
    end
})

CombatTab:Toggle({
    Title = "自动踩人",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoStomp = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoStomp do
                    task.wait(0.5)
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local humanoid = player.Character:FindFirstChild("Humanoid")
                            if humanoid and humanoid.Health < 10 then
                            end
                        end
                    end
                end
            end)
        end
    end
})

CombatTab:Toggle({
    Title = "自动抓人",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoGrab = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoGrab do
                    task.wait(0.3)
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and 
                           player.Character:FindFirstChild("HumanoidRootPart") then
                           
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - 
                                             player.Character.HumanoidRootPart.Position).Magnitude
                            
                            if distance < 10 then
                            end
                        end
                    end
                end
            end)
        end
    end
})

CombatTab:Toggle({
    Title = "防倒地",
    Default = false,
    Callback = function(state)
        GlobalSettings.NoKnock = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.NoKnock do
                    task.wait(0.1)
                    
                    if LocalPlayer.Character then
                        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid and humanoid:GetState() == Enum.HumanoidStateType.FallingDown then
                            humanoid:ChangeState(Enum.HumanoidStateType.Running)
                        end
                    end
                end
            end)
        end
    end
})

CombatTab:Dropdown({
    Title = "自动护甲",
    Default = "Light Vest",
    Values = Armors,
    Callback = function(selected)
        GlobalSettings.ArmorType = selected
    end
})

CombatTab:Toggle({
    Title = "启用自动护甲",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoArmor = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoArmor do
                    task.wait(2)
                    
                    if LocalPlayer.Character then
                    end
                end
            end)
        end
    end
})

CombatTab:Toggle({
    Title = "自动回血",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoHeal = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoHeal do
                    task.wait(1)
                    
                    if LocalPlayer.Character then
                        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid and humanoid.Health < humanoid.MaxHealth * 0.5 then
                        end
                    end
                end
            end)
        end
    end
})

CombatTab:Button({
    Title = "变身警察",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local originalPos = hrp.CFrame
            
            hrp.CFrame = CFrame.new(580.19, 26.67, -873.15)
            task.wait(0.2)
            
            for _, descendant in pairs(Workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    local distance = (hrp.Position - descendant.Parent.Position).Magnitude
                    if distance < 10 then
                        descendant:InputHoldBegin()
                        task.wait(0.1)
                        descendant:InputHoldEnd()
                    end
                end
            end
            
            hrp.CFrame = originalPos
            
            hrp.CFrame = CFrame.new(587.3, 26.66, -871.14)
            task.wait(0.2)
            
            for _, descendant in pairs(Workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    local distance = (hrp.Position - descendant.Parent.Position).Magnitude
                    if distance < 10 then
                        descendant:InputHoldBegin()
                        task.wait(0.1)
                        descendant:InputHoldEnd()
                    end
                end
            end
            
            hrp.CFrame = originalPos
        end
    end
})

CombatTab:Button({
    Title = "变身小丑",
    Callback = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local originalPos = hrp.CFrame
            
            hrp.CFrame = CFrame.new(1124.44, 16.84, 113.32)
            task.wait(0.3)
            
            for _, descendant in pairs(Workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    local distance = (hrp.Position - descendant.Parent.Position).Magnitude
                    if distance < 10 then
                        descendant:InputHoldBegin()
                        task.wait(0.1)
                        descendant:InputHoldEnd()
                    end
                end
            end
            
            hrp.CFrame = originalPos
        end
    end
})

FarmTab:Toggle({
    Title = "自动全图ATM",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoFarmATM = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoFarmATM do
                    task.wait(0.5)
                    
                    for _, descendant in pairs(Workspace:GetDescendants()) do
                        if descendant.Name == "ATM" or string.find(descendant.Name:lower(), "atm") then
                        end
                    end
                end
            end)
        end
    end
})

FarmTab:Toggle({
    Title = "自动圣诞节",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoChristmas = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoChristmas do
                    task.wait(1)
                    
                    for _, descendant in pairs(Workspace:GetDescendants()) do
                        if descendant.Name == "ChristmasMonster" or 
                           string.find(descendant.Name:lower(), "christmas") then
                        end
                    end
                end
            end)
        end
    end
})

FarmTab:Toggle({
    Title = "自动拾取糖果",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoCandy = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoCandy do
                    task.wait(0.3)
                    
                    for _, descendant in pairs(Workspace:GetDescendants()) do
                        if descendant.Name == "Candy" or string.find(descendant.Name:lower(), "candy") then
                        end
                    end
                end
            end)
        end
    end
})

FarmTab:Toggle({
    Title = "自动现金",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoCash = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoCash do
                    task.wait(0.2)
                    
                    for _, descendant in pairs(Workspace:GetDescendants()) do
                        if descendant.Name == "Cash" or descendant.Name == "Money" then
                        end
                    end
                end
            end)
        end
    end
})

FarmTab:Toggle({
    Title = "自动抢银行",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoBank = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoBank do
                    task.wait(2)
                    
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    end
                end
            end)
        end
    end
})

FarmTab:Toggle({
    Title = "自动珠宝店戒指",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoRing = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoRing do
                    task.wait(1)
                    {}
                    for _, descendant in pairs(Workspace:GetDescendants()) do
                        if descendant.Name == "JewelryStore" or 
                           string.find(descendant.Name:lower(), "jewel") then
                        end
                    end
                end
            end)
        end
    end
})

ItemsTab:Toggle({
    Title = "自动拾取稀有物品",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoRareItems = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoRareItems do
                    task.wait(0.5)
                    
                    for _, itemName in pairs(RareItems) do
                        for _, descendant in pairs(Workspace:GetDescendants()) do
                            if descendant.Name == itemName then
                            end
                        end
                    end
                end
            end)
        end
    end
})

ItemsTab:Toggle({
    Title = "自动拾取宝石",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoGems = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoGems do
                    task.wait(0.4)
                    
                    for _, gemName in pairs(Gems) do
                        for _, descendant in pairs(Workspace:GetDescendants()) do
                            if descendant.Name == gemName then
                            end
                        end
                    end
                end
            end)
        end
    end
})

ItemsTab:Toggle({
    Title = "自动开启保险箱",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoSafe = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoSafe do
                    task.wait(1)
                    
                    for _, descendant in pairs(Workspace:GetDescendants()) do
                        if descendant.Name == "Safe" or string.find(descendant.Name:lower(), "safe") then
                        end
                    end
                end
            end)
        end
    end
})

ItemsTab:Toggle({
    Title = "自动购买撬锁",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoLockpick = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.AutoLockpick do
                    task.wait(3)
                    
                end
            end)
        end
    end
})

SkinsTab:Button({
    Title = "普通气球美化美金气球",
    Callback = function()
        local gcs = getgc()
        
        for _, obj in pairs(gcs) do
            if type(obj) == "table" and rawget(obj, "name") == "Balloon" then
            end
        end
    end
})

SkinsTab:Button({
    Title = "普通气球美化黑玫瑰气球",
    Callback = function()
    end
})

SkinsTab:Button({
    Title = "获取美金气球",
    Callback = function()
    end
})

SkinsTab:Button({
    Title = "获取所有气球",
    Callback = function()
    end
})

SkinsTab:Button({
    Title = "修改所有枪支无限子弹",
    Callback = function()
        local gcs = getgc()
        
        for _, obj in pairs(gcs) do
            if type(obj) == "table" then
                if rawget(obj, "Ammo") or rawget(obj, "ammo") then
                    if obj.Ammo then obj.Ammo = math.huge end
                    if obj.ammo then obj.ammo = math.huge end
                    if obj.MaxAmmo then obj.MaxAmmo = math.huge end
                end
            end
        end
    end
})

SkinsTab:Button({
    Title = "修改所有枪支无后座极速",
    Callback = function()
        local gcs = getgc()
        
        for _, obj in pairs(gcs) do
            if type(obj) == "table" then
                if rawget(obj, "Recoil") then obj.Recoil = 0 end
                if rawget(obj, "recoil") then obj.recoil = 0 end
                if rawget(obj, "Spread") then obj.Spread = 0 end
                if rawget(obj, "spread") then obj.spread = 0 end
                if rawget(obj, "FireRate") then obj.FireRate = 1000 end
                if rawget(obj, "fireRate") then obj.fireRate = 1000 end
            end
        end
    end
})

local SkinChineseNames = {
    ["虚空"] = "Void",
    ["像素"] = "Pixel",
    ["冰冻钻石"] = "Frozen Diamond",
    ["反物质"] = "Anti Matter",
    ["四叶草"] = "Lucky Clover",
    ["圣诞未来"] = "Christmas Future",
    ["圣诞玩具"] = "Christmas Toy",
    ["声望"] = "Prestige",
    ["大炮"] = "Cannon",
    ["彩虹激光"] = "Rainbow Laser",
    ["战术"] = "Tactical",
    ["收割者"] = "Reaper",
    ["暗物质"] = "Dark Matter",
    ["樱花"] = "Sakura",
    ["海盗"] = "Pirate",
    ["激光"] = "Laser",
    ["烟火"] = "Firework",
    ["烟花"] = "Fireworks",
    ["爱国者"] = "Patriot",
    ["猩红"] = "Crimson",
    ["玫瑰"] = "Rose",
    ["生物"] = "Bio",
    ["白未来"] = "Future White",
    ["礼物包装"] = "Gift Wrapped",
    ["神秘"] = "Mystic",
    ["精英"] = "Elite",
    ["紫水晶"] = "Amethyst",
    ["红水晶"] = "Ruby",
    ["纯金"] = "Solid Gold",
    ["纯金战术"] = "Solid Gold Tactical",
    ["绿水晶"] = "Emerald",
    ["自由"] = "Freedom",
    ["荒地"] = "Wasteland",
    ["蒸汽"] = "Steam",
    ["蓝水晶"] = "Sapphire",
    ["虚空射线"] = "Void-Ray",
    ["虚空收割者"] = "Void Reaper",
    ["虚空梦魇"] = "Void Nightmare",
    ["虚空神秘"] = "Void Mystic",
    ["诅咒南瓜"] = "Cursed Pumpkin",
    ["财富"] = "Wealth",
    ["赛博朋克"] = "Cyberpunk",
    ["氧化"] = "Oxidized",
    ["金雪"] = "Golden Snow",
    ["钻石像素"] = "Diamond Pixel",
    ["隐形"] = "Invisible",
    ["零下"] = "Sub-Zero",
    ["黄金大炮"] = "Gold Cannon",
    ["黄金零下"] = "Gold Sub-Zero",
    ["黑曜石"] = "Obsidian",
    ["黑未来"] = "Future Black",
    ["黑樱花"] = "Black Sakura",
    ["黑玫瑰"] = "Black Rose"
}

local SkinOptions = {}
for chineseName, _ in pairs(SkinChineseNames) do
    table.insert(SkinOptions, chineseName)
end
table.sort(SkinOptions)

SkinsTab:Dropdown({
    Title = "选择目标皮肤",
    Default = "虚空",
    Values = SkinOptions,
    Callback = function(selected)
        GlobalSettings.SelectedSkin = SkinChineseNames[selected]
    end
})

SkinsTab:Toggle({
    Title = "自动应用选中皮肤",
    Default = false,
    Callback = function(state)
        GlobalSettings.AutoApplySkin = state
        
        if state and GlobalSettings.SelectedSkin then
            task.spawn(function()
                while GlobalSettings.AutoApplySkin do
                    task.wait(2)
                    
                    local gcs = getgc()
                    
                    for _, obj in pairs(gcs) do
                        if type(obj) == "table" and rawget(obj, "Skin") then
                            obj.Skin = GlobalSettings.SelectedSkin
                        end
                    end
                end
            end)
        end
    end
})

SkinsTab:Toggle({
    Title = "全枪虚空",
    Default = false,
    Callback = function(state)
        GlobalSettings.ForceVoid = state
        
        if state then
            task.spawn(function()
                while GlobalSettings.ForceVoid do
                    task.wait(1)
                    
                    local gcs = getgc()
                    
                    for _, obj in pairs(gcs) do
                        if type(obj) == "table" and rawget(obj, "Skin") then
                            obj.Skin = "Void"
                        end
                    end
                end
            end)
        end
    end
})

OtherTab:Button({
    Title = "破解表情",
    Callback = function()
        local gcs = getgc()
        
        for _, obj in pairs(gcs) do
            if type(obj) == "table" then
                if rawget(obj, "Emotes") then
                    for emoteName, _ in pairs(obj.Emotes) do
                        obj.Emotes[emoteName] = true
                    end
                end
            end
        end
    end
})

OtherTab:Button({
    Title = "破解移动经销商",
    Callback = function()
    end
})

OtherTab:Button({
    Title = "破解战斗状态",
    Callback = function()
        local gcs = getgc()
        
        for _, obj in pairs(gcs) do
            if type(obj) == "table" then
                if rawget(obj, "Combat") then obj.Combat = false end
                if rawget(obj, "InCombat") then obj.InCombat = false end
                if rawget(obj, "combat") then obj.combat = false end
                if rawget(obj, "inCombat") then obj.inCombat = false end
            end
        end
    end
})

OtherTab:Button({
    Title = "秒互动",
    Callback = function()
        local originalMeta
        originalMeta = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            
            if method == "FireServer" and tostring(self) == "Interact" then
                return true
            end
            
            return originalMeta(self, ...)
        end)
    end
})

OtherTab:Slider({
    Title = "辅助瞄准灵敏度",
    Default = 1,
    Min = 1,
    Max = 20,
    Callback = function(value)
        GlobalSettings.AimSensitivity = value
    end
})

OtherTab:Toggle({
    Title = "[ESP] 开启主开关",
    Default = false,
    Callback = function(state)
        GlobalSettings.ESP_Main = state
        
        if state then
            task.spawn(function()
                local drawings = {}
                
                while GlobalSettings.ESP_Main do
                    task.wait(0.1)
                    
                    for _, drawing in pairs(drawings) do
                        drawing:Remove()
                    end
                    drawings = {}
                    
                    if not GlobalSettings.ESP_Main then break end
                    
                    if GlobalSettings.ESP_Box or GlobalSettings.ESP_Name or GlobalSettings.ESP_Health then
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character and 
                               player.Character:FindFirstChild("HumanoidRootPart") then
                               
                                local hrp = player.Character.HumanoidRootPart
                                local camera = Workspace.CurrentCamera
                                local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
                                
                                if onScreen then
                                    if GlobalSettings.ESP_Box then
                                        local box = Drawing.new("Square")
                                        box.Visible = true
                                        box.Color = Color3.new(1, 0, 0)
                                        box.Thickness = 2
                                        box.Size = Vector2.new(50, 100)
                                        box.Position = Vector2.new(screenPos.X - 25, screenPos.Y - 50)
                                        table.insert(drawings, box)
                                    end
                                    
                                    if GlobalSettings.ESP_Name then
                                        local name = Drawing.new("Text")
                                        name.Visible = true
                                        name.Text = player.Name
                                        name.Color = Color3.new(1, 1, 1)
                                        name.Size = 14
                                        name.Position = Vector2.new(screenPos.X, screenPos.Y - 60)
                                        table.insert(drawings, name)
                                    end
                                    
                                    if GlobalSettings.ESP_Health then
                                        local humanoid = player.Character:FindFirstChild("Humanoid")
                                        if humanoid then
                                            local health = Drawing.new("Text")
                                            health.Visible = true
                                            health.Text = string.format("%d/%d", humanoid.Health, humanoid.MaxHealth)
                                            health.Color = Color3.new(0, 1, 0)
                                            health.Size = 12
                                            health.Position = Vector2.new(screenPos.X, screenPos.Y - 45)
                                            table.insert(drawings, health)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    if GlobalSettings.ESP_Money then
                        for _, descendant in pairs(Workspace:GetDescendants()) do
                            if descendant.Name == "Cash" or descendant.Name == "Money" then
                                local screenPos, onScreen = camera:WorldToViewportPoint(descendant.Position)
                                
                                if onScreen then
                                    local moneyText = Drawing.new("Text")
                                    moneyText.Visible = true
                                    moneyText.Text = "$"
                                    moneyText.Color = Color3.new(0, 1, 0)
                                    moneyText.Size = 16
                                    moneyText.Position = Vector2.new(screenPos.X, screenPos.Y)
                                    table.insert(drawings, moneyText)
                                end
                            end
                        end
                    end
                    
                    if GlobalSettings.ESP_ATM then
                        for _, descendant in pairs(Workspace:GetDescendants()) do
                            if descendant.Name == "ATM" or string.find(descendant.Name:lower(), "atm") then
                                local screenPos, onScreen = camera:WorldToViewportPoint(descendant.Position)
                                
                                if onScreen then
                                    local atmText = Drawing.new("Text")
                                    atmText.Visible = true
                                    atmText.Text = "ATM"
                                    atmText.Color = Color3.new(0, 0, 1)
                                    atmText.Size = 16
                                    atmText.Position = Vector2.new(screenPos.X, screenPos.Y)
                                    table.insert(drawings, atmText)
                                end
                            end
                        end
                    end
                end
                
                for _, drawing in pairs(drawings) do
                    drawing:Remove()
                end
            end)
        end
    end
})

OtherTab:Toggle({
    Title = "[ESP] 显示方框",
    Default = false,
    Callback = function(state)
        GlobalSettings.ESP_Box = state
    end
})

OtherTab:Toggle({
    Title = "[ESP] 显示名字",
    Default = false,
    Callback = function(state)
        GlobalSettings.ESP_Name = state
    end
})

OtherTab:Toggle({
    Title = "[ESP] 显示血量",
    Default = false,
    Callback = function(state)
        GlobalSettings.ESP_Health = state
    end
})

OtherTab:Toggle({
    Title = "[ESP] 显示现金堆",
    Default = false,
    Callback = function(state)
        GlobalSettings.ESP_Money = state
    end
})

OtherTab:Toggle({
    Title = "[ESP] 显示 ATM",
    Default = false,
    Callback = function(state)
        GlobalSettings.ESP_ATM = state
    end
})

local MainConnection
MainConnection = RunService.Heartbeat:Connect(function(delta)
end)

Window:SelectTab(1)

WindUI:Notify({
    Title = "加载成功",
    Content = "封号概不负责",
    Icon = "check",
    Duration = 3
})