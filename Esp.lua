_G.FriendColor = Color3.fromRGB(0, 0, 255)
_G.EnemyColor = Color3.fromRGB(255, 0, 0)
_G.UseTeamColor = true

-- Configurações
local ESPEnabled = true
local HealthBarEnabled = true
local NameTagEnabled = true
local BoxEnabled = true

--------------------------------------------------------------------

local Holder = Instance.new("Folder", game.CoreGui)
Holder.Name = "ESP"

local TweenService = game:GetService("TweenService")

-- Painel de controle
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ESPPanel"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0, 10, 0.5, -150)
MainFrame.Size = UDim2.new(0, 200, 0, 300)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", MainFrame)
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.BorderSizePixel = 0
Title.Text = "ESP Controls"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 8)

-- Função para criar botões
local function createToggleButton(name, position, defaultState)
	local Button = Instance.new("TextButton", MainFrame)
	Button.Name = name .. "Button"
	Button.Position = UDim2.new(0, 10, 0, position)
	Button.Size = UDim2.new(1, -20, 0, 40)
	Button.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
	Button.BorderSizePixel = 0
	Button.Text = name .. ": " .. (defaultState and "ON" or "OFF")
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.TextSize = 16
	Button.Font = Enum.Font.SourceSansBold
	
	local ButtonCorner = Instance.new("UICorner", Button)
	ButtonCorner.CornerRadius = UDim.new(0, 6)
	
	return Button
end

local ESPButton = createToggleButton("ESP", 50, ESPEnabled)
local HealthBarButton = createToggleButton("Health Bar", 100, HealthBarEnabled)
local NameTagButton = createToggleButton("Name Tag", 150, NameTagEnabled)
local BoxButton = createToggleButton("Box", 200, BoxEnabled)

-- Botão de fechar
local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Name = "CloseButton"
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.SourceSansBold

local CloseCorner = Instance.new("UICorner", CloseButton)
CloseCorner.CornerRadius = UDim.new(0, 6)

CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- Botão para abrir o painel (tecla)
local OpenButton = Instance.new("TextButton", ScreenGui)
OpenButton.Name = "OpenButton"
OpenButton.Position = UDim2.new(0, 10, 0.5, -20)
OpenButton.Size = UDim2.new(0, 40, 0, 40)
OpenButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
OpenButton.BorderSizePixel = 0
OpenButton.Text = "ESP"
OpenButton.TextColor3 = Color3.fromRGB(0, 0, 0)
OpenButton.TextSize = 14
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.Visible = false

local OpenCorner = Instance.new("UICorner", OpenButton)
OpenCorner.CornerRadius = UDim.new(0, 8)

OpenButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
	OpenButton.Visible = false
end)

--------------------------------------------------------------------

local Box = Instance.new("BoxHandleAdornment")
Box.Name = "nilBox"
Box.Size = Vector3.new(1, 2, 1)
Box.Color3 = Color3.new(100 / 255, 100 / 255, 100 / 255)
Box.Transparency = 0.7
Box.ZIndex = 0
Box.AlwaysOnTop = false
Box.Visible = false

local NameTag = Instance.new("BillboardGui")
NameTag.Name = "nilNameTag"
NameTag.Enabled = false
NameTag.Size = UDim2.new(0, 200, 0, 80)
NameTag.AlwaysOnTop = true
NameTag.StudsOffset = Vector3.new(0, 2.5, 0)

local Tag = Instance.new("TextLabel", NameTag)
Tag.Name = "Tag"
Tag.BackgroundTransparency = 1
Tag.Position = UDim2.new(0, -50, 0, 0)
Tag.Size = UDim2.new(0, 300, 0, 20)
Tag.TextSize = 16
Tag.TextColor3 = Color3.new(1, 1, 1)
Tag.TextStrokeColor3 = Color3.new(0, 0, 0)
Tag.TextStrokeTransparency = 0.3
Tag.Text = "nil"
Tag.Font = Enum.Font.GothamBold
Tag.TextScaled = false

-- Container da barra de vida com sombra
local HealthBarContainer = Instance.new("Frame", NameTag)
HealthBarContainer.Name = "HealthBarContainer"
HealthBarContainer.Position = UDim2.new(0, 50, 0, 28)
HealthBarContainer.Size = UDim2.new(0, 100, 0, 14)
HealthBarContainer.BackgroundTransparency = 1

-- Sombra da barra
local HealthBarShadow = Instance.new("Frame", HealthBarContainer)
HealthBarShadow.Name = "Shadow"
HealthBarShadow.Position = UDim2.new(0, 2, 0, 2)
HealthBarShadow.Size = UDim2.new(1, 0, 1, 0)
HealthBarShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
HealthBarShadow.BackgroundTransparency = 0.5
HealthBarShadow.BorderSizePixel = 0
HealthBarShadow.ZIndex = 1

local ShadowCorner = Instance.new("UICorner", HealthBarShadow)
ShadowCorner.CornerRadius = UDim.new(0, 4)

-- Background da barra
local HealthBarBackground = Instance.new("Frame", HealthBarContainer)
HealthBarBackground.Name = "HealthBarBG"
HealthBarBackground.Position = UDim2.new(0, 0, 0, 0)
HealthBarBackground.Size = UDim2.new(1, 0, 1, 0)
HealthBarBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
HealthBarBackground.BorderSizePixel = 2
HealthBarBackground.BorderColor3 = Color3.fromRGB(255, 255, 255)
HealthBarBackground.ZIndex = 2

local BGCorner = Instance.new("UICorner", HealthBarBackground)
BGCorner.CornerRadius = UDim.new(0, 4)

-- Barra de vida com gradiente
local HealthBar = Instance.new("Frame", HealthBarBackground)
HealthBar.Name = "HealthBar"
HealthBar.Size = UDim2.new(1, -4, 1, -4)
HealthBar.Position = UDim2.new(0, 2, 0, 2)
HealthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
HealthBar.BorderSizePixel = 0
HealthBar.ZIndex = 3

local HealthCorner = Instance.new("UICorner", HealthBar)
HealthCorner.CornerRadius = UDim.new(0, 3)

-- Gradiente na barra de vida
local HealthGradient = Instance.new("UIGradient", HealthBar)
HealthGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 100)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 0))
}
HealthGradient.Rotation = 90

-- Brilho na barra
local HealthShine = Instance.new("Frame", HealthBar)
HealthShine.Name = "Shine"
HealthShine.Size = UDim2.new(1, 0, 0.4, 0)
HealthShine.Position = UDim2.new(0, 0, 0, 0)
HealthShine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HealthShine.BackgroundTransparency = 0.7
HealthShine.BorderSizePixel = 0
HealthShine.ZIndex = 4

local ShineCorner = Instance.new("UICorner", HealthShine)
ShineCorner.CornerRadius = UDim.new(0, 3)

-- Texto da vida com sombra
local HealthText = Instance.new("TextLabel", HealthBarContainer)
HealthText.Name = "HealthText"
HealthText.BackgroundTransparency = 1
HealthText.Position = UDim2.new(0, 0, 0, 18)
HealthText.Size = UDim2.new(1, 0, 0, 16)
HealthText.TextSize = 13
HealthText.TextColor3 = Color3.fromRGB(255, 255, 255)
HealthText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
HealthText.TextStrokeTransparency = 0.2
HealthText.Text = "100/100"
HealthText.Font = Enum.Font.GothamBold
HealthText.TextScaled = false
HealthText.ZIndex = 5

-- Funções de atualização de visibilidade
local function updateESPVisibility()
	for _, holder in pairs(Holder:GetChildren()) do
		local box = holder:FindFirstChildWhichIsA("BoxHandleAdornment")
		local nameTag = holder:FindFirstChildWhichIsA("BillboardGui")
		
		if box then
			box.Visible = ESPEnabled and BoxEnabled
		end
		
		if nameTag then
			nameTag.Enabled = ESPEnabled and (NameTagEnabled or HealthBarEnabled)
			if nameTag:FindFirstChild("Tag") then
				nameTag.Tag.Visible = NameTagEnabled
			end
			if nameTag:FindFirstChild("HealthBarContainer") then
				nameTag.HealthBarContainer.Visible = HealthBarEnabled
			end
		end
	end
end

-- Eventos dos botões
ESPButton.MouseButton1Click:Connect(function()
	ESPEnabled = not ESPEnabled
	ESPButton.Text = "ESP: " .. (ESPEnabled and "ON" or "OFF")
	ESPButton.BackgroundColor3 = ESPEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
	updateESPVisibility()
	
	for _, player in pairs(game:GetService("Players"):GetPlayers()) do
		if player.Character and player.Character:FindFirstChild("GetReal") then
			player.Character.GetReal.Enabled = ESPEnabled
		end
	end
end)

HealthBarButton.MouseButton1Click:Connect(function()
	HealthBarEnabled = not HealthBarEnabled
	HealthBarButton.Text = "Health Bar: " .. (HealthBarEnabled and "ON" or "OFF")
	HealthBarButton.BackgroundColor3 = HealthBarEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
	updateESPVisibility()
end)

NameTagButton.MouseButton1Click:Connect(function()
	NameTagEnabled = not NameTagEnabled
	NameTagButton.Text = "Name Tag: " .. (NameTagEnabled and "ON" or "OFF")
	NameTagButton.BackgroundColor3 = NameTagEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
	updateESPVisibility()
end)

BoxButton.MouseButton1Click:Connect(function()
	BoxEnabled = not BoxEnabled
	BoxButton.Text = "Box: " .. (BoxEnabled and "ON" or "OFF")
	BoxButton.BackgroundColor3 = BoxEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
	updateESPVisibility()
end)

-- Atalho de teclado (INSERT para abrir/fechar)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
		MainFrame.Visible = not MainFrame.Visible
		OpenButton.Visible = not MainFrame.Visible
	end
end)

--------------------------------------------------------------------

local LoadCharacter = function(v)
	repeat wait() until v.Character ~= nil
	local humanoid = v.Character:WaitForChild("Humanoid")
	local vHolder = Holder:FindFirstChild(v.Name)
	vHolder:ClearAllChildren()
	
	local b = Box:Clone()
	b.Name = v.Name .. "Box"
	b.Adornee = v.Character
	b.Parent = vHolder
	b.Visible = ESPEnabled and BoxEnabled
	
	local t = NameTag:Clone()
	t.Name = v.Name .. "NameTag"
	t.Enabled = ESPEnabled and (NameTagEnabled or HealthBarEnabled)
	t.Parent = vHolder
	t.Adornee = v.Character:WaitForChild("Head", 5)
	
	if not t.Adornee then
		return UnloadCharacter(v)
	end
	
	t.Tag.Text = v.Name
	t.Tag.Visible = NameTagEnabled
	t.HealthBarContainer.Visible = HealthBarEnabled
	
	b.Color3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
	t.Tag.TextColor3 = Color3.new(v.TeamColor.r, v.TeamColor.g, v.TeamColor.b)
	
	local lastHealth = humanoid.Health
	local connections = {}
	
	-- Função para atualizar a barra de vida
	local function UpdateHealthBar()
		local success = pcall(function()
			if not humanoid or not humanoid.Parent then return end
			
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			local maxh = math.floor(humanoid.MaxHealth)
			local h = math.floor(humanoid.Health)
			
			-- Animação suave da barra
			local healthPercent = math.clamp(h / maxh, 0, 1)
			local targetSize = UDim2.new(healthPercent, -4, 1, -4)
			
			local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			local tween = TweenService:Create(t.HealthBarContainer.HealthBarBG.HealthBar, tweenInfo, {Size = targetSize})
			tween:Play()
			
			-- Gradiente de cor baseado na vida
			if healthPercent > 0.6 then
				t.HealthBarContainer.HealthBarBG.HealthBar.UIGradient.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 100)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 0))
				}
			elseif healthPercent > 0.3 then
				t.HealthBarContainer.HealthBarBG.HealthBar.UIGradient.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 0))
				}
			else
				t.HealthBarContainer.HealthBarBG.HealthBar.UIGradient.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
				}
			end
			
			-- Atualiza o texto
			t.HealthBarContainer.HealthText.Text = h .. "/" .. maxh
			
			-- Efeito de dano (pisca vermelho)
			if h < lastHealth then
				t.HealthBarContainer.HealthBarBG.BorderColor3 = Color3.fromRGB(255, 0, 0)
				task.delay(0.15, function()
					if t and t.Parent then
						t.HealthBarContainer.HealthBarBG.BorderColor3 = Color3.fromRGB(255, 255, 255)
					end
				end)
			end
			
			lastHealth = h
		end)
		
		if not success then
			-- Desconecta todos os eventos se houver erro
			for _, conn in pairs(connections) do
				conn:Disconnect()
			end
		end
	end
	
	-- Conecta múltiplos eventos para garantir atualização
	table.insert(connections, humanoid.HealthChanged:Connect(UpdateHealthBar))
	table.insert(connections, humanoid:GetPropertyChangedSignal("Health"):Connect(UpdateHealthBar))
	
	-- Atualização inicial
	UpdateHealthBar()
	
	-- Limpa conexões quando o personagem é removido
	table.insert(connections, humanoid.Died:Connect(function()
		for _, conn in pairs(connections) do
			conn:Disconnect()
		end
	end))
end

local UnloadCharacter = function(v)
	local vHolder = Holder:FindFirstChild(v.Name)
	if vHolder and (vHolder:FindFirstChild(v.Name .. "Box") ~= nil or vHolder:FindFirstChild(v.Name .. "NameTag") ~= nil) then
		vHolder:ClearAllChildren()
	end
end

local LoadPlayer = function(v)
	local vHolder = Instance.new("Folder", Holder)
	vHolder.Name = v.Name
	
	v.CharacterAdded:Connect(function()
		pcall(LoadCharacter, v)
	end)
	
	v.CharacterRemoving:Connect(function()
		pcall(UnloadCharacter, v)
	end)
	
	v.Changed:Connect(function(prop)
		if prop == "TeamColor" then
			UnloadCharacter(v)
			wait()
			LoadCharacter(v)
		end
	end)
	
	LoadCharacter(v)
end

local UnloadPlayer = function(v)
	UnloadCharacter(v)
	local vHolder = Holder:FindFirstChild(v.Name)
	if vHolder then
		vHolder:Destroy()
	end
end

for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	spawn(function() pcall(LoadPlayer, v) end)
end

game:GetService("Players").PlayerAdded:Connect(function(v)
	pcall(LoadPlayer, v)
end)

game:GetService("Players").PlayerRemoving:Connect(function(v)
	pcall(UnloadPlayer, v)
end)

game:GetService("Players").LocalPlayer.NameDisplayDistance = 0

if _G.Reantheajfdfjdgs then
	return
end

_G.Reantheajfdfjdgs = ":suifayhgvsdghfsfkajewfrhk321rk213kjrgkhj432rj34f67df"

local players = game:GetService("Players")
local plr = players.LocalPlayer

function esp(target, color)
	if target.Character then
		if not target.Character:FindFirstChild("GetReal") then
			local highlight = Instance.new("Highlight")
			highlight.RobloxLocked = true
			highlight.Name = "GetReal"
			highlight.Adornee = target.Character
			highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			highlight.FillColor = color
			highlight.Enabled = ESPEnabled
			highlight.Parent = target.Character
		else
			target.Character.GetReal.FillColor = color
			target.Character.GetReal.Enabled = ESPEnabled
		end
	end
end

while task.wait() do
	for i, v in pairs(players:GetPlayers()) do
		if v ~= plr then
			esp(v, _G.UseTeamColor and v.TeamColor.Color or ((plr.TeamColor == v.TeamColor) and _G.FriendColor or _G.EnemyColor))
		end
	end
end
