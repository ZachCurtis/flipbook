local flipbook = script:FindFirstAncestor("flipbook")

local React = require(flipbook.Packages.React)
local internalStorybook = require(flipbook["init.storybook"])
local Sidebar = require(script.Parent.Sidebar)

return {
	summary = "Sidebar containing brand, searchbar, and component tree",
	controls = {},
	story = React.createElement(Sidebar, {
		storybooks = {
			internalStorybook,
		},
		selectStory = print,
		selectStorybook = print,
	}),
}
