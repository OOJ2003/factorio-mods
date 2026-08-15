-- TODO: find a clever way to auto-generate at least a lot of these
local foundry_recyclables = {
  {
    root = "space-age",
    result = "molten-iron",
    amount = 5,
    count = 2,
    item = "iron-plate"
  },
  {
    root = "space-age",
    result = "molten-iron",
    amount = 5,
    count = 2,
    item = "iron-gear-wheel"
  },
  {
    root = "space-age",
    result = "molten-iron",
    amount = 5,
    count = 4,
    item = "iron-stick"
  },
  {
    root = "space-age",
    result = "molten-iron",
    amount = 20,
    count = 1,
    item = "engine-unit"
  },
  {
    root = "space-age",
    result = "molten-iron",
    amount = 15,
    count = 2,
    item = "steel-plate"
  },
  {
    root = "space-age",
    result = "molten-copper",
    amount = 5,
    count = 2,
    item = "copper-plate"
  },
  {
    root = "space-age",
    result = "molten-copper",
    amount = 2.5,
    count = 4,
    item = "copper-cable"
  },
  {
    root = "base",
    result = "light-oil",
    amount = 10,
    count = 1,
    item = "rocket-fuel"
  },
}

namePrefix = "foundre-"

local recipes = {}
local i = 0

for k, v in ipairs(foundry_recyclables) do
  recipes[k] = {
    type = "recipe",
    categories = { "metallurgy" },
    subgroup = "raw-material",
    name = namePrefix .. "foundry-recycle-" .. v.item,
    hide_from_player_crafting = true,
    enabled = false,
    maximum_productivity = 0, -- does not support productivity
    energy_required = 0.5,    -- time to craft in seconds (at crafting speed 1)
    ingredients = {
      { type = "item", name = v.item, amount = v.count },
    },
    results = { { type = "fluid", name = v.result, amount = v.amount } },
    icons = {
      {
        icon = "__recycler__/graphics/icons/recycling.png",
        scale = 0.5
      },
      {
        --TODO: is it possible to check the item's icon?
        icon = "__base__/graphics/icons/" .. v.item .. ".png",
        scale = 0.375,
        shift = { -4, -4 }
      },
      {
        icon = "__" .. v.root .. "__/graphics/icons/fluid/" .. v.result .. ".png",
        scale = 0.375,
        shift = { 4, 4 }
      },
      {
        icon = "__recycler__/graphics/icons/recycling-top.png",
        scale = 0.5,
      },
    }
  }
  i = i + 1
end

data:extend(recipes)

data:extend({
  {
    type = "recipe",
    categories = { "metallurgy" },
    subgroup = "raw-material",
    name = namePrefix .. "foundry-recycle-electronic-circuit",
    hide_from_player_crafting = true,
    enabled = false,
    maximum_productivity = 0, -- does not support productivity
    energy_required = 0.5,    -- time to craft in seconds (at crafting speed 1)
    ingredients = {
      { type = "item", name = "electronic-circuit", amount = 2 },
    },
    results = {
      { type = "fluid", name = "molten-copper", amount = 3 },
      { type = "fluid", name = "molten-iron",   amount = 5 }
    },
    icons = {
      {
        icon = "__recycler__/graphics/icons/recycling.png",
        scale = 0.5
      },
      {
        icon = "__base__/graphics/icons/electronic-circuit.png",
        scale = 0.375,
        shift = { -4, -4 }
      },
      {
        icon = "__space-age__/graphics/icons/fluid/molten-copper.png",
        scale = 0.375,
        shift = { 4, 4 }
      },
      {
        icon = "__recycler__/graphics/icons/recycling-top.png",
        scale = 0.5,
      },
    }
  },
  {
    type = "recipe",
    categories = { "metallurgy" },
    subgroup = "raw-material",
    name = namePrefix .. "foundry-recycle-advanced-circuit",
    hide_from_player_crafting = true,
    enabled = false,
    maximum_productivity = 0, -- does not support productivity
    energy_required = 0.5,    -- time to craft in seconds (at crafting speed 1)
    ingredients = {
      { type = "item", name = "advanced-circuit", amount = 2 },
    },
    results = {
      { type = "fluid", name = "molten-copper", amount = 7 },
      { type = "fluid", name = "molten-iron",   amount = 10 }
    },
    icons = {
      {
        icon = "__recycler__/graphics/icons/recycling.png",
        scale = 0.5
      },
      {
        icon = "__base__/graphics/icons/advanced-circuit.png",
        scale = 0.375,
        shift = { -4, -4 }
      },
      {
        icon = "__space-age__/graphics/icons/fluid/molten-copper.png",
        scale = 0.375,
        shift = { 4, 4 }
      },
      {
        icon = "__recycler__/graphics/icons/recycling-top.png",
        scale = 0.5,
      },
    }
  },
  {
    type = "recipe",
    categories = { "metallurgy" },
    subgroup = "raw-material",
    name = namePrefix .. "foundry-recycle-battery",
    hide_from_player_crafting = true,
    enabled = false,
    maximum_productivity = 0, -- does not support productivity
    energy_required = 0.5,    -- time to craft in seconds (at crafting speed 1)
    ingredients = {
      { type = "item", name = "battery", amount = 2 },
    },
    results = {
      { type = "fluid", name = "molten-copper", amount = 5 },
      { type = "fluid", name = "molten-iron",   amount = 5 }
    },
    icons = {
      {
        icon = "__recycler__/graphics/icons/recycling.png",
        scale = 0.5
      },
      {
        icon = "__base__/graphics/icons/battery.png",
        scale = 0.375,
        shift = { -4, -4 }
      },
      {
        icon = "__base__/graphics/icons/fluid/sulfuric-acid.png",
        scale = 0.375,
        shift = { 4, 4 }
      },
      {
        icon = "__recycler__/graphics/icons/recycling-top.png",
        scale = 0.5,
      },
    }
  },
  {
    type = "recipe",
    categories = { "metallurgy" },
    subgroup = "raw-material",
    name = namePrefix .. "foundry-recycle-electric-engine-unit",
    hide_from_player_crafting = true,
    enabled = false,
    maximum_productivity = 0, -- does not support productivity
    energy_required = 0.5,    -- time to craft in seconds (at crafting speed 1)
    ingredients = {
      { type = "item", name = "electric-engine-unit", amount = 1 },
    },
    results = {
      { type = "fluid", name = "molten-copper", amount = 10 },
      { type = "fluid", name = "molten-iron", amount = 30 }
    },
    icons = {
      {
        icon = "__recycler__/graphics/icons/recycling.png",
        scale = 0.5,
      },
      {
        icon = "__base__/graphics/icons/electric-engine-unit.png",
        scale = 0.375,
        shift = { -4, -4 }
      },
      {
        icon = "__space-age__/graphics/icons/fluid/molten-copper.png",
        scale = 0.375,
        shift = { 4, 4 }
      },
      {
        icon = "__recycler__/graphics/icons/recycling-top.png",
        scale = 0.5,
      },
    }
  },
  {
    type = "recipe",
    categories = { "metallurgy" },
    subgroup = "raw-material",
    name = namePrefix .. "foundry-recycle-processing-unit",
    hide_from_player_crafting = true,
    enabled = false,
    maximum_productivity = 0, -- does not support productivity
    energy_required = 0.5,    -- time to craft in seconds (at crafting speed 1)
    ingredients = {
      { type = "item", name = "processing-unit", amount = 1 },
    },
    results = {
      { type = "fluid", name = "molten-copper", amount = 74 },
      { type = "fluid", name = "molten-iron", amount = 120 }
    },
    icons = {
      {
        icon = "__recycler__/graphics/icons/recycling.png",
        scale = 0.5
      },
      {
        icon = "__base__/graphics/icons/processing-unit.png",
        scale = 0.375,
        shift = { -4, -4 }
      },
      {
        icon = "__space-age__/graphics/icons/fluid/molten-copper.png",
        scale = 0.375,
        shift = { 4, 4 }
      },
      {
        icon = "__recycler__/graphics/icons/recycling-top.png",
        scale = 0.5,
      },
    }
  },
  {
    type = "recipe",
    categories = { "metallurgy" },
    subgroup = "raw-material",
    name = namePrefix .. "foundry-recycle-low-density-structure",
    hide_from_player_crafting = true,
    enabled = false,
    maximum_productivity = 0, -- does not support productivity
    energy_required = 0.5,    -- time to craft in seconds (at crafting speed 1)
    ingredients = {
      { type = "item", name = "low-density-structure", amount = 1 },
    },
    results = {
      { type = "fluid", name = "molten-iron", amount = 20 },
      { type = "fluid", name = "molten-copper", amount = 60 }
    },
    icons = {
      {
        icon = "__recycler__/graphics/icons/recycling.png",
        scale = 0.5
      },
      {
        icon = "__base__/graphics/icons/low-density-structure.png",
        scale = 0.375,
        shift = { -4, -4 }
      },
      {
        icon = "__space-age__/graphics/icons/fluid/molten-copper.png",
        scale = 0.375,
        shift = { 4, 4 }
      },
      {
        icon = "__recycler__/graphics/icons/recycling-top.png",
        scale = 0.5,
      },
    }
  },
})

local tech_effects = {}
for k, v in ipairs(foundry_recyclables) do
  tech_effects[k] = {
    type   = "unlock-recipe",
    recipe = namePrefix .. "foundry-recycle-" .. v.item
  }
end

local other_names = { "electronic-circuit", "advanced-circuit", "engine-unit", "electric-engine-unit", "battery",
  "rocket-fuel", "processing-unit", "low-density-structure" }

for k, v in ipairs(other_names) do
  table.insert(tech_effects, {
    type   = "unlock-recipe",
    recipe = namePrefix .. "foundry-recycle-" .. v
  })
end

data:extend { {
  type = "technology",
  name = namePrefix .. "foundry-recycling",
  icon_size = 256,
  icons = {
    {
      icon = "__recycler__/graphics/icons/recycling.png",
      scale = 4
    },
    {
      icon = "__base__/graphics/icons/electronic-circuit.png",
      scale = 3,
      shift = { -64, -64 }
    },
    {
      icon = "__space-age__/graphics/icons/fluid/molten-copper.png",
      scale = 3,
      shift = { 64, 64 }
    },
    {
      icon = "__recycler__/graphics/icons/recycling-top.png",
      scale = 4,
    },
  },
  effects = tech_effects,
  prerequisites = { "recycling", "foundry" },
  unit =
  {
    count = 500,
    ingredients = {
      { "automation-science-pack", 1 },
      { "logistic-science-pack",   1 },
      { "chemical-science-pack",   1 },
      { "space-science-pack",      1 },
    },
    time = 30
  },
} }
