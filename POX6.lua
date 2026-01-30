local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local camera = workspace.CurrentCamera
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local function getDeviceType()
    local UserInputService = game:GetService("UserInputService")
    if UserInputService.TouchEnabled then
        if UserInputService.KeyboardEnabled then
            return "平板"
        else
            return "手机"
        end
    else
        return "电脑"
    end
end

local deviceType = getDeviceType()
local uiSize, uiPosition

if deviceType == "手机" then
    uiSize = UDim2.fromOffset(500, 400)
elseif deviceType == "平板" then
    uiSize = UDim2.fromOffset(550, 450)
else
    uiSize = UDim2.fromOffset(600, 500)
end
uiPosition = UDim2.new(0.5, 0, 0.5, 0)

WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

local playerName = LocalPlayer.Name
local displayName = LocalPlayer.DisplayName

WindUI:Notify({
    Title = "POX HUB",
    Content = "加载完成",
    Duration = 2
})

local Window = WindUI:CreateWindow({
    Title = "POX HUB",
    Icon = "rbxassetid://118449824705443",
    Author = "lost",
    Folder = "OrangeCHub",
    Size = uiSize,
    Position = uiPosition,
    Theme = "Dark",
    Transparent = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Username = playerName,
        DisplayName = displayName,
        UserId = LocalPlayer.UserId,
        ThumbnailType = "AvatarBust",
        Callback = function()
            WindUI:Notify({
                Title = "用户信息",
                Content = "玩家:" .. LocalPlayer.Name,
                Duration = 3
            })
        end
    },
    SideBarWidth = deviceType == "手机" and 150 or 180,
    ScrollBarEnabled = true
})

Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
    WindUI:Notify({
        Title = "提示",
        Content = "当前主题: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

Window:EditOpenButton({
    Title = "POX HUB",
    Icon = "rbxassetid://118449824705443",
})

Window:SetToggleKey(Enum.KeyCode.N)

local Tabs = {
    Pl = Window:Section({ Title = "玩家", Opened = false, Icon = "user"}),
    Block = Window:Section({ Title = "功能", Opened = false, Icon = "hand-fist"}),
}

local TabHandles = {
    Announcement = Tabs.Pl:Tab({ Title = "公告", Icon = "folder"}),
    Player = Tabs.Pl:Tab({ Title = "玩家", Icon = "folder"}),
    Block1 = Tabs.Block:Tab({ Title = "绘制", Icon = "folder"}),
    Block2 = Tabs.Block:Tab({ Title = "其它", Icon = "folder"}),
}

TabHandles.Announcement:Paragraph({
    Title = "欢迎尊贵的用户",
    Desc = "此脚本会一直更新感谢你们",
    Image = "info",
    ImageSize = 15
})

TabHandles.Announcement:Paragraph({
    Title = "玩家",
    Desc = "尊敬的用户: " .. LocalPlayer.Name .. "欢迎使用",
    Image = "user",
    ImageSize = 12
})

TabHandles.Announcement:Paragraph({
    Title = "设备",
    Desc = "你的使用设备: " .. deviceType,
    Image = "gamepad",
    ImageSize = 12
})

TabHandles.Announcement:Paragraph({
    Title = "设备",
    Desc = "你的注入器: " .. identifyexecutor(),
    Image = "syringe",
    ImageSize = 12
})

local ClientModule
local success, result = pcall(function()
    return require(LP:WaitForChild("PlayerScripts"):WaitForChild("Client"))
end)
if success then
    ClientModule = result
end

local EatRemote = ClientModule and ClientModule.Events and ClientModule.Events.RequestConsumeItem
getgenv().WS = LP.Character and LP.Character.Humanoid and LP.Character.Humanoid.WalkSpeed or 16

local AlienX = {
    ["杀戮光环"] = false,
    ["自动砍树"] = false,
    ["自动进食"] = false,
    ["透视孩子"] = false,
    ["透视宝箱"] = false
}

local BL = {}
local connection = nil

local function AddESP(part, txt1, txt2, enabled)
    local BG = part:FindFirstChild("BillboardGui")
    if not BG then
        local bg = Instance.new("BillboardGui")
        bg.Adornee = part
        bg.Parent = part
        bg.Size = UDim2.new(0, 100, 0, 100)
        bg.StudsOffset = Vector3.new(0, 3, 0)
        bg.AlwaysOnTop = true
        local TL = Instance.new("TextLabel", bg)
        TL.Text = txt1 .. "\n" .. txt2 .. "m"
        TL.Size = UDim2.new(1, 0, 0, 40)
        TL.Position = UDim2.new(0, 0, 0, 0)
        TL.BackgroundTransparency = 1
        TL.TextColor3 = Color3.new(1, 1, 1)
        TL.TextStrokeTransparency = 0.3
        TL.Font = Enum.Font.GothamBold
        TL.TextSize = 14
        local Img = Instance.new("ImageLabel", bg)
        Img.Position = UDim2.new(0, 20, 0, 40)
        Img.Size = UDim2.new(0, 60, 0, 60)
        Img.Image = part.Name:match("Chest") and "rbxassetid://18660563116" or ""
        Img.BackgroundTransparency = 1
    else
        local bg = BG
        bg.TextLabel.Text = txt1 .. "\n" .. txt2 .. "m"
        bg.Enabled = enabled
    end
end

local function Collect(thing)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == thing then
            local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if part and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                part.CFrame = LP.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
            end
        end
    end
end

local function tryEatFood(food)
    if not EatRemote then warn("🚫 No EatRemote") return end
    if not ReplicatedStorage:FindFirstChild("TempStorage") then warn("🚫 No TempStorage") return end
    print("➡️ 正在尝试吃下" .. food.Name)
    food.Parent = ReplicatedStorage.TempStorage
    local success, result = pcall(function()
        return EatRemote:InvokeServer(food)
    end)
    if success and result and result.Success then
        print("✅成功吃下 " .. food.Name)
        return
    else
        print("❌️进食失败")
        return
    end
end

local PlayerList = {}
for _, b in pairs(Plr:GetPlayers()) do
    table.insert(PlayerList, b.Name)
end

TabHandles.PlayerTab:Slider({
    Title = "移动速度",
    Description = "调整你的移动速度",
    Image = "running",
    ImageSize = 13,
    Min = 0,
    Max = 200,
    Default = LP.Character and LP.Character.Humanoid and LP.Character.Humanoid.WalkSpeed or 16,
    Callback = function(value)
        getgenv().WS = value
        if LP.Character and LP.Character.Humanoid then
            LP.Character.Humanoid.WalkSpeed = value
        end
    end
})

TabHandles.PlayerTab:Slider({
    Title = "悬浮高度",
    Description = "调整你的悬浮高度",
    Image = "arrow-up",
    ImageSize = 13,
    Min = 0,
    Max = 200,
    Default = LP.Character and LP.Character.Humanoid and LP.Character.Humanoid.HipHeight or 0.1,
    Callback = function(value)
        if LP.Character and LP.Character.Humanoid then
            LP.Character.Humanoid.HipHeight = value
        end
    end
})

TabHandles.PlayerTab:Toggle({
    Title = "玩家发光",
    Description = "让你的玩家发光",
    Enabled = false,
    Image = "lightbulb",
    ImageSize = 13,
    Callback = function(value)
        if value then
            if LP.Character and LP.Character:FindFirstChild("Head") then
                local light = Instance.new("PointLight", LP.Character.Head)
                light.Name = "PlayerLight"
                light.Range = 9999999
                light.Brightness = 15
                WindUI:Notify({
                    Title = "玩家发光",
                    Content = "已开启发光效果",
                    Duration = 1
                })
            end
        else
            if LP.Character and LP.Character:FindFirstChild("Head") and LP.Character.Head:FindFirstChild("PlayerLight") then
                LP.Character.Head.PlayerLight:Destroy()
                WindUI:Notify({
                    Title = "玩家发光",
                    Content = "已关闭发光效果",
                    Duration = 1
                })
            end
        end
    end
})

TabHandles.PlayerTab:Divider()

TabHandles.PlayerTab:Button({
    Title = "重置属性",
    Description = "重置所有玩家属性到默认值",
    Image = "rotate-left",
    ImageSize = 13,
    Callback = function()
        getgenv().WS = 16
        if LP.Character and LP.Character.Humanoid then
            LP.Character.Humanoid.WalkSpeed = 16
            LP.Character.Humanoid.HipHeight = 0.1
        end
        if LP.Character and LP.Character:FindFirstChild("Head") and LP.Character.Head:FindFirstChild("PlayerLight") then
            LP.Character.Head.PlayerLight:Destroy()
        end
        WindUI:Notify({
            Title = "重置属性",
            Content = "玩家属性已重置",
            Duration = 2
        })
    end
})

TabHandles.Player:Toggle({
    Title = "杀戮光环",
    Description = "自动攻击附近的敌人",
    Enabled = false,
    Image = "hand-fist",
    ImageSize = 13,
    Callback = function(value)
        AlienX["杀戮光环"] = value
        WindUI:Notify({
            Title = "杀戮光环",
            Content = value and "已开启" or "已关闭",
            Duration = 1
        })
    end
})

TabHandles.Player:Toggle({
    Title = "自动砍树",
    Description = "自动砍伐附近的树木",
    Enabled = false,
    Image = "tree",
    ImageSize = 13,
    Callback = function(value)
        AlienX["自动砍树"] = value
        WindUI:Notify({
            Title = "自动砍树",
            Content = value and "已开启" or "已关闭",
            Duration = 1
        })
    end
})

TabHandles.Player:Toggle({
    Title = "自动进食",
    Description = "自动吃掉附近的食物",
    Enabled = false,
    Image = "apple-whole",
    ImageSize = 13,
    Callback = function(value)
        AlienX["自动进食"] = value
        WindUI:Notify({
            Title = "自动进食",
            Content = value and "已开启" or "已关闭",
            Duration = 1
        })
    end
})

TabHandles.Player:Toggle({
    Title = "瞬间互动",
    Description = "立刻完成互动操作",
    Enabled = false,
    Image = "bolt-lightning",
    ImageSize = 13,
    Callback = function(value)
        if value then
            if not connection then
                connection = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
                    prompt.HoldDuration = 0
                end)
                WindUI:Notify({
                    Title = "瞬间互动",
                    Content = "已开启",
                    Duration = 1
                })
            end
        else
            if connection then
                connection:Disconnect()
                connection = nil
                WindUI:Notify({
                    Title = "瞬间互动",
                    Content = "已关闭",
                    Duration = 1
                })
            end
        end
    end
})

TabHandles.Player:Divider()

TabHandles.Player:Button({
    Title = "保存设置",
    Description = "保存当前所有设置",
    Image = "floppy-disk",
    ImageSize = 13,
    Callback = function()
        WindUI:Notify({
            Title = "保存设置",
            Content = "设置已保存",
            Duration = 2
        })
    end
})

local collectItems = {
    {"左轮", "Revolver"},
    {"步枪", "Rifle"},
    {"左轮子弹", "Revolver Ammo"},
    {"步枪子弹", "Rifle Ammo"},
    {"皮革", "Leather Body"},
    {"铁甲", "Iron Body"},
    {"荆棘铠甲", "Thorn Body"},
    {"螺栓", "Bolt"},
    {"金属薄板", "Sheet Metal"},
    {"旧收音机", "Old Radio"},
    {"损坏的电扇", "Broken Fan"},
    {"损坏的微波炉", "Broken Microwave"},
    {"木头", "Log"},
    {"椅子", "Chair"},
    {"燃料罐", "Fuel Canister"},
    {"油桶", "Oil Barrel"},
    {"生物燃料", "Biofuel"},
    {"煤", "Coal"},
    {"萝卜", "Carrot"},
    {"浆果", "Berry"},
    {"生食", "Morsel"},
    {"生牛肉", "Steak"},
    {"熟食", "Cooked Morsel"},
    {"熟牛肉", "Cooked Steak"},
    {"急救包", "MedKit"},
    {"绷带", "Bandage"}
}

for _, item in ipairs(collectItems) do
    TabHandles.CollectTab:Button({
        Title = item[1],
        Description = "传送到你的位置",
        Image = "box-archive",
        ImageSize = 13,
        Callback = function()
            Collect(item[2])
            WindUI:Notify({
                Title = "收集物品",
                Content = item[1] .. " 已传送到你的位置",
                Duration = 1
            })
        end
    })
end

TabHandles.Block1:Toggle({
    Title = "透视孩子",
    Description = "显示走失孩子的透视",
    Enabled = false,
    Image = "child",
    ImageSize = 13,
    Callback = function(value)
        AlienX["透视孩子"] = value
        WindUI:Notify({
            Title = "透视孩子",
            Content = value and "已开启" or "已关闭",
            Duration = 1
        })
    end
})

TabHandles.Block1:Toggle({
    Title = "透视宝箱",
    Description = "显示宝箱的透视",
    Enabled = false,
    Image = "chest",
    ImageSize = 13,
    Callback = function(value)
        AlienX["透视宝箱"] = value
        WindUI:Notify({
            Title = "透视宝箱",
            Content = value and "已开启" or "已关闭",
            Duration = 1
        })
    end
})

TabHandles.Block1:Divider()

TabHandles.Block1:Button({
    Title = "清除所有ESP",
    Description = "清除所有透视效果",
    Image = "trash",
    ImageSize = 13,
    Callback = function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BillboardGui") then
                obj:Destroy()
            end
        end
        BL = {}
        WindUI:Notify({
            Title = "清除ESP",
            Content = "已清除所有透视效果",
            Duration = 1
        })
    end
})

local teleportDropdown = TabHandles.Block2:Dropdown({
    Title = "选择玩家",
    Description = "选择要传送的玩家",
    Image = "user",
    ImageSize = 13,
    Options = PlayerList,
    Default = "",
    Callback = function(selected)
        local targetPlayer = Plr:FindFirstChild(selected)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and LP.Character then
            LP.Character:PivotTo(targetPlayer.Character.HumanoidRootPart.CFrame)
            WindUI:Notify({
                Title = "传送",
                Content = "已传送到 " .. selected,
                Duration = 2
            })
        end
    end
})

local function refreshPlayerList()
    PlayerList = {}
    for _, player in pairs(Plr:GetPlayers()) do
        table.insert(PlayerList, player.Name)
    end
    teleportDropdown:RefreshOptions(PlayerList)
end

Plr.PlayerAdded:Connect(function()
    refreshPlayerList()
end)

Plr.PlayerRemoving:Connect(function()
    refreshPlayerList()
end)

TabHandles.Block2:Button({
    Title = "刷新玩家列表",
    Description = "刷新当前在线玩家",
    Image = "rotate",
    ImageSize = 13,
    Callback = function()
        refreshPlayerList()
        WindUI:Notify({
            Title = "刷新列表",
            Content = "玩家列表已刷新",
            Duration = 1
        })
    end
})

local last1, last2, last3 = 0, 0, 0
game["Run Service"].Heartbeat:Connect(function()
    local Now = tick()
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    
    if LP.Character.Humanoid then
        LP.Character.Humanoid.WalkSpeed = getgenv().WS
    end

    for _, b in pairs(workspace.Items:GetChildren()) do
        if b:GetAttribute(tostring(LP.UserId) .. "Opened") then
            table.insert(BL, b)
            if b:FindFirstChild("BillboardGui") then
                b.BillboardGui:Destroy()
            end
        end
        if b.Name:match("Chest") and b:IsA("Model") and not table.find(BL, b) and b:FindFirstChild("Main") then
            AddESP(b, "宝箱", tostring(math.floor((LP.Character.HumanoidRootPart.Position - b.Main.Position).Magnitude)), AlienX["透视宝箱"])
        end
    end

    for _, b in pairs(workspace.Characters:GetChildren()) do
        if b:GetAttribute("Lost") and b:GetAttribute("Lost") == false then
            table.insert(BL, b)
            if b:FindFirstChild("BillboardGui") then
                b.BillboardGui:Destroy()
            end
        end
        if table.find({"Lost Child", "Lost Child1", "Lost Child2", "Lost Child3", "Dino Kid", "kraken kid", "Squid kid", "Koala Kid", "koala Kid", "koala"}, b.Name) and b:FindFirstChild("HumanoidRootPart") and not table.find(BL, b) then
            AddESP(b, "孩子", tostring(math.floor((LP.Character.HumanoidRootPart.Position - b.HumanoidRootPart.Position).Magnitude)), AlienX["透视孩子"])
        end
    end
    
    if LP.Character:FindFirstChild("ToolHandle") then
        local tool = LP.Character.ToolHandle.OriginalItem.Value
        if tool then
            if AlienX["杀戮光环"] and Now - last1 >= 0.7 then
                last1 = Now
                if not ({["Old Axe"] = true, ["Good Axe"] = true, ["Spear"] = true, ["Hatchet"] = true, ["Bone Club"] = true})[tool.Name] then return end
                for _, b in pairs(workspace.Characters:GetChildren()) do
                    if b:IsA("Model") and b:FindFirstChild("HumanoidRootPart") and b:FindFirstChild("HitRegisters") then
                        if (LP.Character.HumanoidRootPart.Position - b.HumanoidRootPart.Position).Magnitude <= 100 then
                            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(b, tool, true, LP.Character.HumanoidRootPart.CFrame)
                        end
                    end
                end
            end
            
            if AlienX["自动砍树"] and Now - last2 >= 0.7 then
                last2 = Now
                if not ({["Old Axe"] = true, ["Stone Axe"] = true, ["Iron Axe"] = true})[tool.Name] then return end
                local function ChopTree(Path)
                    for _, b in pairs(Path:GetChildren()) do
                        task.wait(.1)
                        if b:IsA("Model") and ({["Small Tree"] = true, ["TreeBig1"] = true, ["TreeBig2"] = true, ["TreeBig3"] = true})[b.Name] and b:FindFirstChild("HitRegisters") then
                            local trunk = b:FindFirstChild("Trunk") or b:FindFirstChild("HumanoidRootPart") or b.PrimaryPart
                            if trunk then
                                if (LP.Character.HumanoidRootPart.Position - trunk.Position).Magnitude <= 100 then
                                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ToolDamageObject"):InvokeServer(b, tool, true, LP.Character.HumanoidRootPart.CFrame)
                                end
                            end
                        end
                    end
                end
                ChopTree(workspace.Map.Foliage)
                ChopTree(workspace.Map.Landmarks)
            end
        end
    end
    
    if AlienX["自动进食"] and Now - last3 >= 10 then
        last3 = Now
        local HRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if HRP then
            local foundFood = false
            for _, obj in pairs(workspace.Items:GetChildren()) do
                if obj:IsA("Model") and ({["Carrot"] = true, ["Berry"] = true, ["Morsel"] = false, ["Cooked Morsel"] = true, ["Steak"] = false, ["Cooked Steak"] = true})[obj.Name] then
                    local mainPart = obj:FindFirstChild("Handle") or obj.PrimaryPart
                    if mainPart and (mainPart.Position - HRP.Position).Magnitude < 25 then
                        foundFood = true
                        tryEatFood(obj)
                        break
                    end
                end
            end
            if not foundFood then
            end
        end
    end
    task.wait(.1)
end)
