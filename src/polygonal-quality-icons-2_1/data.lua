local icon_path = "__polygonal-quality-icons__/graphics/icons/"

local outline_styles = {
	"black-outline",
	"white-outline",
	"colored-outline-black",
	"colored-outline-white",
	"dashed-black-outline",
	"dashed-white-outline",
	"numbers-black-outline",
	"numbers-white-outline"
}

local quality_levels = {
	"normal",
	"uncommon",
	"rare",
	"epic",
	"legendary",
	"any",
	-- Mythic Quality [VextexFux]
	"mythic",
	-- Quality++ [Puzz1ebox]
	"mythical",
	"masterwork",
	"wonderous",
	"artifactual"
}

function create_virtual_signals()
	local signals = {}
	for _, style in ipairs(outline_styles) do
		for _, quality in ipairs(quality_levels) do
			table.insert(signals, {
				type = "virtual-signal",
				name = "polygonal-quality-icons-" .. quality .. "-" .. style,
				icon = icon_path .. style .. "/quality-" .. quality .. ".png",
				hidden = true
			})
		end
	end
	return signals
end

data:extend(create_virtual_signals())
