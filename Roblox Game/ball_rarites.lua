local ColorValueWeights = {}

ColorValueWeights.colors = {
	{Color = Color3.fromRGB(255, 0, 0), Value = 1, Weight = 50}, -- Red
	{Color = Color3.fromRGB(0, 255, 0), Value = 2, Weight = 30}, -- Green
	{Color = Color3.fromRGB(0, 0, 255), Value = 4, Weight = 15}, -- Blue
	{Color = Color3.fromRGB(128, 0, 128), Value = 8, Weight = 5}  -- Purple
    {Color = Color3.fromRGB(255, 255, 0), Value = 16, Weight = 1} -- Yellow
    {Color = Color3.fromRGB(255, 128, 0), Value = 32, Weight = 0.5} -- Orange
    {Color = Color3.fromRGB(255, 0, 255), Value = 64, Weight = 0.1} -- Magenta
    {Color = Color3.fromRGB(0, 255, 255), Value = 128, Weight = 0.05} -- Cyan
    {Color = Color3.fromRGB(255, 255, 255), Value = 256, Weight = 0.01} -- White
    {Color = Color3.fromRGB(0, 0, 0), Value = 512, Weight = 0.001} -- Black
}

return ColorValueWeights