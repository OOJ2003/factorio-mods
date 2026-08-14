local custom_icons = {
	["holmium-plate-calcite"] = {
		{ icon = "__calcite-casting-fork__/graphics/icons/casting-holmium.png" }
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

	if recipe.name == "molten-plastic-to-plastic-bar-calcite" then
		calcite_backdrop.shift = { 10, 10 }
		table.insert(icons, calcite_backdrop)
		icons[1].draw_background = true
	else
		table.insert(icons, 1, calcite_backdrop)
		icons[2].draw_background = true
	end

	return icons
end

local recipes = {}

---@param recipe data.RecipePrototype
---@return boolean
local function uses_casting_category(recipe)
	if mods["molten_plastic"] and recipe.name == "molten-plastic-to-plastic-bar" then
		return true
	end

	if recipe.category == "metallurgy" or recipe.category == "crafting-with-fluid-or-metallurgy" then
		return true
	end

	for _, category in ipairs(recipe.categories or {}) do
		if category == "metallurgy" or category == "crafting-with-fluid-or-metallurgy" then
			return true
		end
	end

	return false
end

---@param recipe data.RecipePrototype
---@return number?
local function get_recipe_multiplier(recipe)
	if mods["molten-tungsten"] and recipe.name == "casting-tungsten-carbide" then
		return 50
	end

	if recipe.ingredients and #recipe.ingredients == 1 and recipe.ingredients[1].type == "fluid" then
		return math.floor(500 / recipe.ingredients[1].amount)
	end

	return nil
end

for _, recipe in pairs(data.raw["recipe"]) do
	local subgroup = recipe.subgroup and data.raw["item-subgroup"][recipe.subgroup]
	local multiplier = get_recipe_multiplier(recipe)

	if uses_casting_category(recipe)
		and (subgroup and subgroup.group == "intermediate-products")
		and multiplier
		and recipe.results and #recipe.results == 1 and recipe.results[1].type == "item"
	then
		local new_recipe = table.deepcopy(recipe)
		local result = new_recipe.results[1]

		if result.amount_max then
			result.amount_min = result.amount_min * multiplier
			result.amount_max = result.amount_max * multiplier
		else
			result.amount = result.amount * multiplier
		end

		for _, ingredient in ipairs(new_recipe.ingredients) do
			ingredient.amount = ingredient.amount * multiplier
			if ingredient.type == "fluid" then
				ingredient.fluidbox_multiplier = 2
			end
		end

		table.insert(new_recipe.ingredients, 1, { type = "item", name = "calcite", amount = 1 })

		new_recipe.name = recipe.name .. "-calcite"
		new_recipe.energy_required = math.floor(recipe.energy_required * multiplier * 9) / 10 -- 10% speed boost
		new_recipe.localised_name = {
			"recipe-name.calcite-casting-suffix",
			custom_localized_name[new_recipe.name] or recipe.localised_name or { "recipe-name." .. recipe.name },
		}
		if new_recipe.categories then
			new_recipe.categories = { "metallurgy" }
			new_recipe.category = nil
		else
			new_recipe.category = "metallurgy"
		end
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
