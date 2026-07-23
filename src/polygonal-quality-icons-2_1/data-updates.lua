local icon_path = "__polygonal-quality-icons__/graphics/icons/" ..
	settings.startup["polygonal-quality-icons-icon-style"].value .. "/"

data.raw["quality"]["normal"].icon = icon_path .. "quality-normal.png"
data.raw["quality"]["uncommon"].icon = icon_path .. "quality-uncommon.png"
data.raw["quality"]["rare"].icon = icon_path .. "quality-rare.png"
data.raw["quality"]["epic"].icon = icon_path .. "quality-epic.png"
data.raw["quality"]["legendary"].icon = icon_path .. "quality-legendary.png"
data.raw["virtual-signal"]["signal-any-quality"].icon = icon_path .. "quality-any.png"

function update_conditionally(quality, icon)
	if (data.raw["quality"][quality]) then
		data.raw["quality"][quality].icon = icon
	end
end

-- Mythic Quality [VextexFux]
update_conditionally("mythic", icon_path .. "quality-mythic.png")
-- Quality++ [Puzz1ebox]
update_conditionally("mythical", icon_path .. "quality-mythical.png")
update_conditionally("masterwork", icon_path .. "quality-masterwork.png")
update_conditionally("wonderous", icon_path .. "quality-wonderous.png")
update_conditionally("artifactual", icon_path .. "quality-artifactual.png")
