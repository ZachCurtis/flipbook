local CoreGui = game:GetService("CoreGui")

local flipbook = script:FindFirstAncestor("flipbook")

local React = require(flipbook.Packages.React)
local ReactRoblox = require(flipbook.Packages.ReactRoblox)
local Sift = require(flipbook.Packages.Sift)
local StoryError = require(flipbook.Components.StoryError)
local ScrollingFrame = require(flipbook.Components.ScrollingFrame)
local types = require(script.Parent.Parent.types)
local mountStory = require(flipbook.Story.mountStory)

local e = React.createElement

local defaultProps = {
	isMountedInViewport = false,
	zoom = 0,
}

type Props = typeof(defaultProps) & {
	layoutOrder: number,
	story: types.Story,
	ref: any,
	controls: { [string]: any },
	storyModule: ModuleScript,
}

local StoryPreview = React.forwardRef(function(props: Props, ref: any)
	props = Sift.Dictionary.merge(defaultProps, props)

	local err, setErr = React.useState(nil)

	React.useEffect(function()
		setErr(nil)
	end, { props.story, ref })

	React.useEffect(function()
		if props.story and ref.current then
			local success, result = xpcall(function()
				return mountStory(props.story, props.controls, ref.current)
			end, debug.traceback)

			if success then
				return result
			else
				setErr(result)
				return nil
			end
		end

		return nil
	end, { props.story, props.controls, props.isMountedInViewport, ref.current })

	if err then
		return e(StoryError, {
			layoutOrder = props.layoutOrder,
			err = err,
		})
	else
		if props.isMountedInViewport then
			return ReactRoblox.createPortal({
				Story = e("ScreenGui", {
					ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
					ref = ref,
				}),
			}, CoreGui)
		else
			return e(ScrollingFrame, {
				BackgroundTransparency = 1,
				LayoutOrder = props.layoutOrder,
				ScrollingDirection = Enum.ScrollingDirection.XY,
				AutomaticCanvasSize = Enum.AutomaticSize.XY,
				CanvasSize = UDim2.new(),
				Size = UDim2.fromScale(1, 1),
				ref = ref,
			}, {
				Scale = e("UIScale", {
					Scale = 1 + props.zoom,
				}),
			})
		end
	end
end)

return StoryPreview
