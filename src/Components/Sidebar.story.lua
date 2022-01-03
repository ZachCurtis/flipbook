local Roact = require(script.Parent.Parent.Packages.Roact)
local Sidebar = require(script.Parent.Sidebar)

return {
	summary = "The sidebar that displays all the available stories for the current Storybook",
	story = Roact.createElement(Sidebar, {
		stories = {},
	}),
}
