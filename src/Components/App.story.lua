local flipbook = script:FindFirstAncestor("flipbook")

local React = require(flipbook.Packages.React)
local ModuleLoader = require(flipbook.Packages.ModuleLoader)
local App = require(script.Parent.App)

return {
	summary = "The main component that handles the entire plugin",
	controls = {},
	story = React.createElement(App, {
		loader = ModuleLoader.new(),
	}),
}
