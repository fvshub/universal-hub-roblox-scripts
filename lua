-- Universal Hub by Delta Executor
-- Games: SAB & ADM

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local TabHolder = Instance.new("Frame")
local SABTab = Instance.new("TextButton")
local ADMTab = Instance.new("TextButton")
local Divider = Instance.new("Frame")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local CloseBtn = Instance.new("TextButton")
local StatusDot = Instance.new("Frame")
local StatusLabel = Instance.new("TextLabel")

-- Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Setup GUI
ScreenGui.Name = "UniversalHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Main Frame
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -230, 0.5, -200)
Main.Size = UDim2.new(0, 460, 0, 400)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(168, 85, 247)
Main:FindFirstChildOfClass("UIStroke").Thickness = 1.2

-- Title
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 18, 0, 16)
Title.Size = UDim2.new(0, 300, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ Universal Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left

Subtitle.Parent = Main
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 18, 0, 44)
Subtitle.Size = UDim2.new(0, 300, 0, 18)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Delta Executor  •  Select a script to inject"
Subtitle.TextColor3 = Color3.fromRGB(120, 120, 160)
Subtitle.TextSize = 12
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
CloseBtn.Parent = Main
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Position = UDim2.new(1, -38, 0, 14)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Status dot
StatusDot.Parent = Main
StatusDot.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
StatusDot.Position = UDim2.new(0, 18, 0, 72)
StatusDot.Size = UDim2.new(0, 8, 0, 8)
StatusDot.BorderSizePixel = 0
Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

StatusLabel.Parent = Main
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 32, 0, 66)
StatusLabel.Size = UDim2.new(0, 200, 0, 18)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Hub Online"
StatusLabel.TextColor3 = Color3.fromRGB(34, 197, 94)
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Divider
Divider.Parent = Main
Divider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Divider.BorderSizePixel = 0
Divider.Position = UDim2.new(0, 0, 0, 90)
Divider.Size = UDim2.new(1, 0, 0, 1)

-- Tab Buttons
TabHolder.Parent = Main
TabHolder.BackgroundTransparency = 1
TabHolder.Position = UDim2.new(0, 12, 0, 97)
TabHolder.Size = UDim2.new(1, -24, 0, 34)

local function makeTab(btn, label, xPos)
    btn.Parent = TabHolder
    btn.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
    btn.Position = UDim2.new(0, xPos, 0, 0)
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.Font = Enum.Font.GothamBold
    btn.Text = label
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

makeTab(SABTab, "SAB", 0)
makeTab(ADMTab, "ADM", 108)

-- Scroll Frame for script cards
ScrollFrame.Parent = Main
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.Position = UDim2.new(0, 12, 0, 140)
ScrollFrame.Size = UDim2.new(1, -24, 1, -155)
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(168, 85, 247)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.BorderSizePixel = 0

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Script Data
local Scripts = {
    SAB = {
        {
            name = "Freeze Trade",
            desc = "Freeze all active trades",
            icon = "❄️",
            color = Color3.fromRGB(0, 207, 255),
            exec = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/fvs-creator/freeze-trade-tool-sab/refs/heads/main/loader.lua"))()
            end
        },
        {
            name = "Spawner",
            desc = "Spawn any brainrot item instantly",
            icon = "🧠",
            color = Color3.fromRGB(168, 85, 247),
            exec = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/fvs-creator/X-Ware-Hub/refs/heads/main/spawner.lua"))()
            end
        },
        {
            name = "A/P Gifter",
            desc = "AP Gifter to any player",
            icon = "🎁",
            color = Color3.fromRGB(245, 158, 11),
            exec = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/fvs-creator/FVS-sab/refs/heads/main/free%20admin%20panel.lua"))()
            end
        },
    },
    ADM = {
        {
            name = "House Cloner",
            desc = "Clone any house model in ADM",
            icon = "🏠",
            color = Color3.fromRGB(34, 197, 94),
            exec = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/fvshub/adm-house-cloner-/refs/heads/main/lua"))()
            end
        },
        {
            name = "Spawner",
            desc = "Spawn ADM items on demand",
            icon = "⚡",
            color = Color3.fromRGB(249, 115, 22),
            exec = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/fvshub/Adm-Spawner-pets-bucks/refs/heads/main/lua"))()
            end
        },
        {
            name = "Freeze Trader",
            desc = "Lock trade windows in ADM",
            icon = "🧊",
            color = Color3.fromRGB(56, 189, 248),
            exec = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/fvshub/adm-freeze-trader/refs/heads/main/lua"))()
            end
        },
    }
}

-- Toast notification
local function showToast(message, color)
    local toast = Instance.new("Frame")
    toast.Parent = ScreenGui
    toast.BackgroundColor3 = Color3.fromRGB(15, 40, 20)
    toast.BorderSizePixel = 0
    toast.Position = UDim2.new(0.5, -160, 0, -60)
    toast.Size = UDim2.new(0, 320, 0, 46)
    Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", toast)
    stroke.Color = color or Color3.fromRGB(34, 197, 94)
    stroke.Thickness = 1

    local lbl = Instance.new("TextLabel", toast)
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, -16, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "✅  " .. message .. " — Injected!"
    lbl.TextColor3 = Color3.fromRGB(74, 222, 128)
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    -- Slide in
    TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Position = UDim2.new(0.5, -160, 0, 20)
    }):Play()

    task.delay(2.5, function()
        TweenService:Create(toast, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Position = UDim2.new(0.5, -160, 0, -60)
        }):Play()
        task.delay(0.3, function() toast:Destroy() end)
    end)
end

-- Build Cards
local function buildCards(game_key)
    for _, child in ipairs(ScrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local totalHeight = 0
    for i, s in ipairs(Scripts[game_key]) do
        local card = Instance.new("Frame")
        card.Parent = ScrollFrame
        card.BackgroundColor3 = Color3.fromRGB(18, 18, 30)
        card.BorderSizePixel = 0
        card.Size = UDim2.new(1, 0, 0, 62)
        card.LayoutOrder = i
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
        local stroke = Instance.new("UIStroke", card)
        stroke.Color = s.color
        stroke.Transparency = 0.7
        stroke.Thickness = 1

        -- Accent bar
        local bar = Instance.new("Frame", card)
        bar.BackgroundColor3 = s.color
        bar.BorderSizePixel = 0
        bar.Position = UDim2.new(0, 0, 0, 10)
        bar.Size = UDim2.new(0, 3, 0, 42)
        Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 4)

        -- Icon
        local icon = Instance.new("TextLabel", card)
        icon.BackgroundTransparency = 1
        icon.Position = UDim2.new(0, 14, 0, 0)
        icon.Size = UDim2.new(0, 36, 1, 0)
        icon.Font = Enum.Font.Gotham
        icon.Text = s.icon
        icon.TextSize = 22
        icon.TextColor3 = Color3.fromRGB(255, 255, 255)

        -- Script Name
        local nameLabel = Instance.new("TextLabel", card)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Position = UDim2.new(0, 56, 0, 12)
        nameLabel.Size = UDim2.new(0, 220, 0, 20)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Text = game_key .. " " .. s.name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextSize = 14
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left

        -- Desc
        local desc = Instance.new("TextLabel", card)
        desc.BackgroundTransparency = 1
        desc.Position = UDim2.new(0, 56, 0, 34)
        desc.Size = UDim2.new(0, 200, 0, 16)
        desc.Font = Enum.Font.Gotham
        desc.Text = s.desc
        desc.TextColor3 = Color3.fromRGB(100, 100, 140)
        desc.TextSize = 11
        desc.TextXAlignment = Enum.TextXAlignment.Left

        -- Execute Button
        local execBtn = Instance.new("TextButton", card)
        execBtn.BackgroundColor3 = s.color
        execBtn.Position = UDim2.new(1, -90, 0.5, -14)
        execBtn.Size = UDim2.new(0, 80, 0, 28)
        execBtn.Font = Enum.Font.GothamBold
        execBtn.Text = "Execute"
        execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        execBtn.TextSize = 12
        execBtn.BorderSizePixel = 0
        Instance.new("UICorner", execBtn).CornerRadius = UDim.new(0, 7)

        execBtn.MouseButton1Click:Connect(function()
            execBtn.Text = "..."
            execBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            task.delay(0.3, function()
                execBtn.Text = "⟳ Loading"
            end)
            task.delay(1.2, function()
                execBtn.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
                execBtn.Text = "✓ Done!"
                showToast(game_key .. " " .. s.name, s.color)
                pcall(s.exec)
                task.delay(2, function()
                    execBtn.BackgroundColor3 = s.color
                    execBtn.Text = "Execute"
                end)
            end)
        end)

        totalHeight = totalHeight + 62 + 8
    end

    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

-- Tab switching
local activeTab = "SAB"

local function setTab(key)
    activeTab = key
    buildCards(key)
    if key == "SAB" then
        SABTab.BackgroundColor3 = Color3.fromRGB(80, 30, 120)
        ADMTab.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
        Main:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(168, 85, 247)
    else
        ADMTab.BackgroundColor3 = Color3.fromRGB(20, 80, 50)
        SABTab.BackgroundColor3 = Color3.fromRGB(30, 20, 50)
        Main:FindFirstChildOfClass("UIStroke").Color = Color3.fromRGB(34, 197, 94)
    end
end

SABTab.MouseButton1Click:Connect(function() setTab("SAB") end)
ADMTab.MouseButton1Click:Connect(function() setTab("ADM") end)

-- Init
setTab("SAB")
