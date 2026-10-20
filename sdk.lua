local function getKeyCachePath(scriptId)
	if scriptId == nil then
		return nil
	end

	local safeId = tostring(scriptId):gsub("[^%w_-]", "_")
	if safeId == "" then
		return nil
	end

	return "FunctionHubArvn/key_" .. safeId .. ".txt"
end

local function readCachedKey(path)
	if not path or type(readfile) ~= "function" or type(isfile) ~= "function" then
		return nil
	end

	local exists, hasFile = pcall(isfile, path)
	if not exists or not hasFile then
		return nil
	end

	local ok, key = pcall(readfile, path)
	if ok and type(key) == "string" and #key > 0 then
		return key
	end
	return nil
end

local function saveCachedKey(path, key)
	if not path or type(writefile) ~= "function" then
		return
	end

	if type(makefolder) == "function" and type(isfolder) == "function" then
		local exists, hasFolder = pcall(isfolder, "FunctionHubArvn")
		if exists and not hasFolder then
			pcall(makefolder, "FunctionHubArvn")
		end
	end

	pcall(writefile, path, key)
end

local function deleteCachedKey(path)
	if path and type(delfile) == "function" then
		pcall(delfile, path)
	end
end

return {
	sdk = loadstring(game:HttpGet("https://sdk.luaprot.net/"))(),
	scriptId = nil,
	keyURL = nil,
	visible = false,
	scriptName = nil,
	validCallback = nil,
	show = function(self)
		if not self then
			return error("You must namecall this method. Example: keySystem:show()")
		elseif self.visible then
			return error("The key system is already visible.")
		end

		local keyCachePath = getKeyCachePath(self.scriptId)
		local cachedKey = readCachedKey(keyCachePath)
		if cachedKey then
			self.sdk.scriptId = self.scriptId
			local checkOk, cachedResult = pcall(function()
				return self.sdk:checkKey(cachedKey)
			end)
			if checkOk and cachedResult and cachedResult.status == "VALID" then
				if self.validCallback then
					self.validCallback(cachedKey)
				else
					self.sdk:loadScript()
				end
				return self
			elseif checkOk then
				deleteCachedKey(keyCachePath)
			end
		end
		
		local keySystem = Instance.new("ScreenGui")
		keySystem.Name = "LuaProtKeySystem"
		keySystem.IgnoreGuiInset = true
		keySystem.ResetOnSpawn = false
		keySystem.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
		keySystem.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		local main = Instance.new("Frame")
		main.Active = true
		main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		main.BorderSizePixel = 0
		main.ClipsDescendants = true
		main.AnchorPoint = Vector2.new(0.5, 0.5)
		main.Position = UDim2.fromScale(0.5, 0.5)
		main.Size = UDim2.fromScale(0.451951, 0.521690)

		local left = Instance.new("Frame")
		left.Active = true
		left.BackgroundTransparency = 1
		left.Size = UDim2.fromScale(0.459215, 1)

		local logo = Instance.new("Frame")
		logo.Active = true
		logo.BackgroundTransparency = 1
		logo.Position = UDim2.fromScale(0.175439, 0.108291)
		logo.Size = UDim2.fromScale(0.313596, 0.0473773)

		local uIListLayout = Instance.new("UIListLayout")
		uIListLayout.FillDirection = Enum.FillDirection.Horizontal
		uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		uIListLayout.Parent = logo

		local luaProt = Instance.new("TextLabel")
		luaProt.Active = true
		luaProt.AutomaticSize = Enum.AutomaticSize.X
		luaProt.BackgroundTransparency = 1
		luaProt.FontFace = Font.new(
			"rbxassetid://11702779409",
			Enum.FontWeight.Bold,
			Enum.FontStyle.Italic
		)
		luaProt.LayoutOrder = 1
		luaProt.Size = UDim2.fromScale(0, 1)
		luaProt.Text = "LuaProt"
		luaProt.TextColor3 = Color3.new(1, 1, 1)
		luaProt.TextScaled = true
		luaProt.TextXAlignment = Enum.TextXAlignment.Left

		local uITextSizeConstraint = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint.MaxTextSize = 29
		uITextSizeConstraint.Parent = luaProt

		luaProt.Parent = logo

		local var_unknown = Instance.new("TextLabel")
		var_unknown.Active = true
		var_unknown.AutomaticSize = Enum.AutomaticSize.X
		var_unknown.BackgroundTransparency = 1
		var_unknown.FontFace = Font.new(
			"rbxassetid://11702779409",
			Enum.FontWeight.Bold,
			Enum.FontStyle.Italic
		)
		var_unknown.LayoutOrder = 2
		var_unknown.Size = UDim2.fromScale(0, 1)
		var_unknown.Text = "."
		var_unknown.TextColor3 = Color3.fromRGB(0, 125, 250)
		var_unknown.TextScaled = true
		var_unknown.TextXAlignment = Enum.TextXAlignment.Left

		local uITextSizeConstraint1 = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint1.MaxTextSize = 29
		uITextSizeConstraint1.Parent = var_unknown

		var_unknown.Parent = logo
		logo.Parent = left

		local scriptName = Instance.new("TextLabel")
		scriptName.Active = true
		scriptName.BackgroundTransparency = 1
		scriptName.FontFace = Font.new(
			"rbxassetid://11702779409",
			Enum.FontWeight.Light,
			Enum.FontStyle.Italic
		)
		scriptName.Position = UDim2.fromScale(0.108114, 0.663282)
		scriptName.Size = UDim2.fromScale(0.763158, 0.274112)
		scriptName.Text = self.scriptName and ("Welcome to " .. self.scriptName) or "Welcome"
		scriptName.TextColor3 = Color3.new(1, 1, 1)
		scriptName.TextScaled = true
		scriptName.TextXAlignment = Enum.TextXAlignment.Left

		local uIGradient = Instance.new("UIGradient")
		uIGradient.Rotation = 90
		uIGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 0.56),
		})
		uIGradient.Parent = scriptName

		local uITextSizeConstraint2 = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint2.MaxTextSize = 58
		uITextSizeConstraint2.Parent = scriptName

		scriptName.Parent = left

		local background = Instance.new("Frame")
		background.Active = true
		background.BackgroundTransparency = 1
		background.ClipsDescendants = true
		background.Size = UDim2.fromScale(1, 1)

		local ellipse1 = Instance.new("ImageLabel")
		ellipse1.Active = true
		ellipse1.BackgroundTransparency = 1
		ellipse1.Image = "rbxassetid://118261594552972"
		ellipse1.ImageColor3 = Color3.fromRGB(44, 84, 250)
		ellipse1.Size = UDim2.fromScale(1, 1)
		ellipse1.Parent = background

		local ellipse2 = Instance.new("ImageLabel")
		ellipse2.Active = true
		ellipse2.BackgroundTransparency = 1
		ellipse2.Image = "rbxassetid://96081323989846"
		ellipse2.ImageColor3 = Color3.fromRGB(45, 85, 251)
		ellipse2.Size = UDim2.fromScale(1, 1)
		ellipse2.Parent = background

		background.Parent = left
		left.Parent = main

		local right = Instance.new("Frame")
		right.Active = true
		right.BackgroundTransparency = 1
		right.Position = UDim2.fromScale(0.526687, 0.279188)
		right.Size = UDim2.fromScale(0.40282, 0.439932)

		local uICorner = Instance.new("UICorner")
		uICorner.BottomLeftRadius = UDim.new(0, 10)
		uICorner.BottomRightRadius = UDim.new(0, 10)
		uICorner.TopLeftRadius = UDim.new(0, 10)
		uICorner.TopRightRadius = UDim.new(0, 10)
		uICorner.Parent = right

		local box = Instance.new("Frame")
		box.Active = true
		box.BackgroundTransparency = 1
		box.Position = UDim2.fromScale(0, 0.230769)
		box.Size = UDim2.fromScale(1, 0.138462)

		local uICorner1 = Instance.new("UICorner")
		uICorner1.Parent = box

		local uIStroke = Instance.new("UIStroke")
		uIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Center
		uIStroke.Color = Color3.fromRGB(209, 233, 255)
		uIStroke.Thickness = 1.35
		uIStroke.Parent = box

		local input = Instance.new("TextBox")
		input.BackgroundTransparency = 1
		input.PlaceholderText = "abcdefghijklmnopqrstuvwxy"
		input.Position = UDim2.fromScale(0.025, 0.0555556)
		input.Selectable = false
		input.Size = UDim2.fromScale(0.945, 0.916667)
		input.Text = ""
		input.TextColor3 = Color3.fromRGB(242, 242, 247)
		input.TextScaled = true
		input.TextXAlignment = Enum.TextXAlignment.Left

		local uITextSizeConstraint3 = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint3.Name = "UITextSizeConstraint"
		uITextSizeConstraint3.MaxTextSize = 13
		uITextSizeConstraint3.Parent = input

		input.Parent = box
		box.Parent = right

		local buttons = Instance.new("Frame")
		buttons.Name = "buttons"
		buttons.Active = true
		buttons.BackgroundTransparency = 1
		buttons.Position = UDim2.fromScale(0, 0.538462)
		buttons.Size = UDim2.fromScale(1, 0.461538)

		local key = Instance.new("TextButton")
		key.Name = "submitKey"
		key.BackgroundColor3 = Color3.fromRGB(44, 84, 250)
		key.BackgroundTransparency = 0.2
		key.Position = UDim2.fromScale(0, -0.208333)
		key.Size = UDim2.fromScale(1, 0.4)
		key.Text = ""
		key.TextScaled = true

		local uICorner2 = Instance.new("UICorner")
		uICorner2.Name = "UICorner"
		uICorner2.Parent = key

		local key1 = Instance.new("TextLabel")
		key1.Name = "enterKey"
		key1.Active = true
		key1.BackgroundTransparency = 1
		key1.FontFace = Font.new(
			"rbxassetid://11702779409",
			Enum.FontWeight.Bold,
			Enum.FontStyle.Normal
		)
		key1.Position = UDim2.fromScale(0.34, 0.333333)
		key1.Size = UDim2.fromScale(0.32, 0.333333)
		key1.Text = "Submit Key"
		key1.TextColor3 = Color3.fromRGB(252, 252, 253)
		key1.TextScaled = true

		local uITextSizeConstraint4 = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint4.Name = "UITextSizeConstraint"
		uITextSizeConstraint4.MaxTextSize = 23
		uITextSizeConstraint4.Parent = key1

		key1.Parent = key

		local uITextSizeConstraint5 = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint5.Name = "UITextSizeConstraint"
		uITextSizeConstraint5.MaxTextSize = 1
		uITextSizeConstraint5.Parent = key

		key.Parent = buttons

		local key2 = Instance.new("TextButton")
		key2.BackgroundColor3 = Color3.new(1, 1, 1)
		key2.Position = UDim2.fromScale(0, 0.316667)
		key2.Size = UDim2.fromScale(1, 0.4)
		key2.Text = ""
		key2.TextScaled = true
		key2.Visible = false

		local uICorner3 = Instance.new("UICorner")
		uICorner3.Parent = key2

		local getKey = Instance.new("TextLabel")
		getKey.Active = true
		getKey.BackgroundTransparency = 1
		getKey.FontFace = Font.new(
			"rbxassetid://11702779409",
			Enum.FontWeight.Bold,
			Enum.FontStyle.Normal
		)
		getKey.Position = UDim2.fromScale(0.5, 0.5)
		getKey.Size = UDim2.fromScale(0.1825, 0.333333)
		getKey.Text = "Get key"
		getKey.TextColor3 = Color3.fromRGB(21, 112, 239)
		getKey.TextScaled = true
		getKey.AnchorPoint = Vector2.new(0.5, 0.5)

		local uITextSizeConstraint6 = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint6.MaxTextSize = 23
		uITextSizeConstraint6.Parent = getKey

		getKey.Parent = key2

		local uITextSizeConstraint7 = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint7.MaxTextSize = 1
		uITextSizeConstraint7.Parent = key2

		key2.Parent = buttons

		buttons.Parent = right

		local title = Instance.new("Frame")
		title.Active = true
		title.BackgroundTransparency = 1
		title.Size = UDim2.fromScale(1, 0.107692)

		local title1 = Instance.new("TextLabel")
		title1.Active = true
		title1.BackgroundTransparency = 1
		title1.FontFace = Font.new("rbxassetid://11702779409")
		title1.Position = UDim2.fromScale(0, 0.571429)
		title1.Size = UDim2.fromScale(0.545, 1)
		title1.Text = "Enter script key"
		title1.TextColor3 = Color3.new(1, 1, 1)
		title1.TextScaled = true
		title1.TextXAlignment = Enum.TextXAlignment.Left

		local uITextSizeConstraint8 = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint8.MaxTextSize = 29
		uITextSizeConstraint8.Parent = title1
		
		local valid = Instance.new("TextLabel")
		valid.Active = true
		valid.BackgroundTransparency = 1
		valid.FontFace = Font.new("rbxassetid://11702779409")
		valid.Position = UDim2.fromScale(0.453089, 1.32143)
		valid.Size = UDim2.fromScale(0.545, 0.75)
		valid.Text = "Valid!"
		valid.TextColor3 = Color3.fromRGB(79, 255, 70)
		valid.TextScaled = true
		valid.TextTransparency = 0.145
		valid.TextXAlignment = Enum.TextXAlignment.Right
		valid.Visible = false

		local uITextSizeConstraint = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint.MaxTextSize = 29
		uITextSizeConstraint.Parent = valid
		
		local invalid = Instance.new("TextLabel")
		invalid.Active = true
		invalid.BackgroundTransparency = 1
		invalid.FontFace = Font.new("rbxassetid://11702779409")
		invalid.Position = UDim2.fromScale(0.453089, 1.32143)
		invalid.Size = UDim2.fromScale(0.545, 0.75)
		invalid.Text = "Invalid key!"
		invalid.TextColor3 = Color3.fromRGB(255, 53, 53)
		invalid.TextScaled = true
		invalid.TextTransparency = 0.145
		invalid.TextXAlignment = Enum.TextXAlignment.Right
		invalid.Visible = false

		local uITextSizeConstraint = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint.MaxTextSize = 29
		uITextSizeConstraint.Parent = invalid

		title1.Parent = title
		valid.Parent = title
		invalid.Parent = title
		title.Parent = right
		right.Parent = main
		main.Parent = keySystem
		
		if self.keyURL and typeof(self.keyURL) == "string" then
			key2.Visible = true
			
			key2.MouseButton1Click:Connect(function()
				if setclipboard then
					setclipboard(self.keyURL)
					getKey.Size = UDim2.fromScale(0.5, 0.5)
					getKey.Text = "Copied URL to clipboard!"
					task.wait(3)
					getKey.Size = UDim2.fromScale(0.1825, 0.333333)
					getKey.Text = "Get key"
				else
					getKey.Size = UDim2.fromScale(0.5, 0.5)
					getKey.Text = "Can't copy URL: " .. self.keyURL
				end
			end)
		end
		
		key.MouseButton1Click:Connect(function()
			if #input.Text > 0 then
				local key = input.Text
				self.sdk.scriptId = self.scriptId
				
				local checkOk, result = pcall(function()
					return self.sdk:checkKey(key)
				end)
				if checkOk and result and result.status == "VALID" then
					saveCachedKey(keyCachePath, key)
					invalid.Visible = false
					valid.Visible = true
					if result.data and result.data.discordUsername then
						scriptName.Text = "Welcome " .. result.data.discordUsername .. "!"
					end
					
					task.delay(1, function()
						keySystem:Destroy()
					end)
					
					if self.validCallback then
						self.validCallback(key)
					else
						self.sdk:loadScript()
					end
				else
					invalid.Visible = true
					valid.Visible = false
					
					task.delay(3, function()
						invalid.Visible = false
					end)
				end
			end
		end)
		
		self.visible = true
		keySystem.Parent = gethui and gethui() or ({pcall(function() return game:GetService("CoreGui") end)})[2] or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	end
}
