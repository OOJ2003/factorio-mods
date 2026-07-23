local custom_icons = {
	["holmium-plate-calcite"] = {
		{ icon = "__calcite-casting__/graphics/icons/casting-holmium.png" }
	},
}

local custom_localized_name = {
	["holmium-plate-calcite"] = { "item-name.holmium-plate" }
}

---@param recipe data.RecipePrototype
local function generate_icons(recipe)
	local icons = custom_icons[recipe.name]

	if not icons then
		if recipe.icons then
			icons = recipe.icons
		elseif recipe.icon then
			icons = { { icon = recipe.icon } }
		end
	end

	if not icons then
		local item_name = recipe.main_product or recipe.results[1].name
		local item = data.raw.item[item_name]

		if not item then
			return nil
		elseif item.icons then
			icons = item.icons
		elseif item.icon then
			icons = { { icon = item.icon } }
		end
	end

	if not icons then return nil end

	---@type data.IconData
	local calcite_backdrop = {
		icon = "__space-age__/graphics/icons/calcite.png",
		scale = 0.25,
		shift = { -10, -10 },
		floating = true,
		draw_background = true,
	}

	table.insert(icons, 1, calcite_backdrop)
	icons[2].draw_background = true

	return icons
end

local recipes = {}

for _, recipe in pairs(data.raw["recipe"]) do
	local subgroup = recipe.subgroup and data.raw["item-subgroup"][recipe.subgroup]

	if (recipe.category == "metallurgy" or recipe.category == "crafting-with-fluid-or-metallurgy")
		and (subgroup and subgroup.group == "intermediate-products")
		and recipe.ingredients and #recipe.ingredients == 1 and recipe.ingredients[1].type == "fluid"
		and recipe.results and #recipe.results == 1 and recipe.results[1].type == "item"
	then
		local new_recipe = table.deepcopy(recipe)
		local ingredient = new_recipe.ingredients[1]
		local result = new_recipe.results[1]
		local multiplier = math.floor(500 / ingredient.amount)

		if result.amount_max then
			result.amount_min = result.amount_min * multiplier
			result.amount_max = result.amount_max * multiplier
		else
			result.amount = result.amount * multiplier
		end

		ingredient.amount = ingredient.amount * multiplier
		ingredient.fluidbox_multiplier = 2

		table.insert(new_recipe.ingredients, 1, { type = "item", name = "calcite", amount = 1 })

		new_recipe.name = recipe.name .. "-calcite"
		new_recipe.energy_required = math.floor(recipe.energy_required * multiplier * 9) / 10 -- 10% speed boost
		new_recipe.localised_name = { "recipe-name.calcite-casting-suffix", custom_localized_name[new_recipe.name] or { "recipe-name." .. recipe.name } }
		new_recipe.category = "metallurgy"
		new_recipe.icons = generate_icons(new_recipe)
		new_recipe.icon = nil
		new_recipe.hide_from_signal_gui = false

		---@diagnostic disable-next-line: assign-type-mismatch
		data:extend({ new_recipe })
		recipes[recipe.name] = new_recipe.name
	end
end

for _, tech in pairs(data.raw["technology"]) do
	if tech.effects then
		for _, effect in ipairs(tech.effects) do
			if effect.type == "unlock-recipe" and effect.recipe then
				local new_recipe = recipes[effect.recipe]
				if new_recipe then
					table.insert(tech.effects, {
						type = "unlock-recipe",
						recipe = new_recipe,
					})
				end
			end
		end
	end
end
