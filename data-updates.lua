--Copyright 2024 Paul Hagedorn (Panzer1119)
--
--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at
--
--http://www.apache.org/licenses/LICENSE-2.0
--
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.

local liquefactionRequiresCryogenicPlant = settings.startup["cryogenic-liquefaction-liquefaction-requires-cryogenic-plant"].value

local cryogenicLiquefiedThrusterFuelExpansionRatio = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-expansion-ratio"].value
local cryogenicLiquefiedThrusterOxidizerExpansionRatio = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-expansion-ratio"].value

local cryogenicLiquefiedThrusterFuelBarrelStackSize = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel-stack-size"].value
local cryogenicLiquefiedThrusterOxidizerBarrelStackSize = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel-stack-size"].value

local fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier = settings.startup["cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-fuel-barrel-energy-multiplier"].value
local fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier = settings.startup["cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-oxidizer-barrel-energy-multiplier"].value

local itemThrusterFuelBarrel = data.raw["item"]["thruster-fuel-barrel"]
local itemThrusterOxidizerBarrel = data.raw["item"]["thruster-oxidizer-barrel"]

--itemThrusterFuelBarrel.name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel"
--itemThrusterFuelBarrel.localised_name = { "item-name.cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel" }
--itemThrusterFuelBarrel.localised_name = { "item-name.filled-barrel", { "fluid-name.thruster-fuel" } }
--itemThrusterFuelBarrel.order = "b[cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel]"
--itemThrusterFuelBarrel.order = "b[new-fluid]-a[space]-a[thruster-fuel]"
--itemThrusterFuelBarrel.icon = "__CryogenicLiquefaction__/graphics/icons/cryogenic-liquefied-thruster-fuel-barrel.png"
itemThrusterFuelBarrel.stack_size = cryogenicLiquefiedThrusterFuelBarrelStackSize
itemThrusterFuelBarrel.weight = 1000 * 1000 / cryogenicLiquefiedThrusterFuelBarrelStackSize
--itemThrusterFuelBarrel.icons = {
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
--        icon_size = 64
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0,
--            g = 0.1,
--            r = 0.53000000000000007
--        }
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.2,
--            g = 0.68000000000000007,
--            r = 0.93000000000000007
--        }
--    }
--}

--itemThrusterOxidizerBarrel.name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel"
--itemThrusterOxidizerBarrel.localised_name = { "item-name.cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel" }
--itemThrusterOxidizerBarrel.localised_name = { "item-name.filled-barrel", { "fluid-name.thruster-oxidizer" } }
--itemThrusterOxidizerBarrel.order = "b[cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel]"
--itemThrusterOxidizerBarrel.order = "b[new-fluid]-a[space]-a[thruster-oxidizer]"
--itemThrusterOxidizerBarrel.icon = "__CryogenicLiquefaction__/graphics/icons/cryogenic-liquefied-thruster-oxidizer-barrel.png"
itemThrusterOxidizerBarrel.stack_size = cryogenicLiquefiedThrusterOxidizerBarrelStackSize
itemThrusterOxidizerBarrel.weight = 1000 * 1000 / cryogenicLiquefiedThrusterOxidizerBarrelStackSize
--itemThrusterOxidizerBarrel.icons = {
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
--        icon_size = 64
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.53000000000000007,
--            g = 0.1,
--            r = 0
--        }
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.93000000000000007,
--            g = 0.68000000000000007,
--            r = 0.2
--        }
--    }
--}

-- TODO Rename it from filling to cooling?

local recipeThrusterFuelBarrel = data.raw["recipe"]["thruster-fuel-barrel"]
local recipeThrusterOxidizerBarrel = data.raw["recipe"]["thruster-oxidizer-barrel"]

--recipeThrusterFuelBarrel.name = "cryogenic-liquefaction-fill-cryogenic-cryogenic-liquefied-thruster-fuel-barrel"
--recipeThrusterFuelBarrel.localised_name = { "recipe-name.fill-barrel", { "fluid-name.thruster-fuel" } }
--recipeThrusterFuelBarrel.order = "b[new-fluid]-a[space]-a[thruster-fuel]"
recipeThrusterFuelBarrel.energy_required = recipeThrusterFuelBarrel.energy_required * fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
recipeThrusterFuelBarrel.ingredients = {
    { type = "item", name = "barrel", amount = 1, ignored_by_stats = 1 },
    { type = "fluid", name = "thruster-fuel", amount = 50 * cryogenicLiquefiedThrusterFuelExpansionRatio, ignored_by_stats = 50 * cryogenicLiquefiedThrusterFuelExpansionRatio }
}
--recipeThrusterFuelBarrel.results = {
--    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel", amount = 1, ignored_by_stats = 1 }
--}
--recipeThrusterFuelBarrel.enabled = false
--recipeThrusterFuelBarrel.always_show_made_in = false
--recipeThrusterFuelBarrel.icons = {
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
--        icon_size = 64
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0,
--            g = 0.1,
--            r = 0.53000000000000007
--        }
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.2,
--            g = 0.68000000000000007,
--            r = 0.93000000000000007
--        }
--    },
--    {
--        icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
--        icon_size = 64,
--        scale = 0.25,
--        shift = {
--            -8,
--            -8
--        }
--    }
--}

--recipeThrusterOxidizerBarrel.name = "cryogenic-liquefaction-fill-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel"
--recipeThrusterOxidizerBarrel.localised_name = { "recipe-name.fill-barrel", { "fluid-name.thruster-oxidizer" } }
--recipeThrusterOxidizerBarrel.order = "b[new-fluid]-a[space]-a[thruster-oxidizer]"
recipeThrusterOxidizerBarrel.energy_required = recipeThrusterOxidizerBarrel.energy_required * fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
recipeThrusterOxidizerBarrel.ingredients = {
    { type = "item", name = "barrel", amount = 1, ignored_by_stats = 1 },
    { type = "fluid", name = "thruster-oxidizer", amount = 50 * cryogenicLiquefiedThrusterOxidizerExpansionRatio, ignored_by_stats = 50 * cryogenicLiquefiedThrusterOxidizerExpansionRatio }
}
--recipeThrusterOxidizerBarrel.results = {
--    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel", amount = 1, ignored_by_stats = 1 }
--}
--recipeThrusterOxidizerBarrel.enabled = false
--recipeThrusterOxidizerBarrel.always_show_made_in = false
--recipeThrusterOxidizerBarrel.icons = {
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
--        icon_size = 64
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.53000000000000007,
--            g = 0.1,
--            r = 0
--        }
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.93000000000000007,
--            g = 0.68000000000000007,
--            r = 0.2
--        }
--    },
--    {
--        icon = "__space-age__/graphics/icons/fluid/thruster-oxidizer.png",
--        icon_size = 64,
--        scale = 0.25,
--        shift = {
--            -8,
--            -8
--        }
--    }
--}

if liquefactionRequiresCryogenicPlant then
    recipeThrusterFuelBarrel.category = "cryogenics"
    recipeThrusterOxidizerBarrel.category = "cryogenics"
else
    recipeThrusterFuelBarrel.category = "chemistry-or-cryogenics"
    recipeThrusterOxidizerBarrel.category = "chemistry-or-cryogenics"
end

local recipeEmptyThrusterFuelBarrel = data.raw["recipe"]["empty-thruster-fuel-barrel"]
local recipeEmptyThrusterOxidizerBarrel = data.raw["recipe"]["empty-thruster-oxidizer-barrel"]

--recipeEmptyThrusterFuelBarrel.name = "cryogenic-liquefaction-empty-cryogenic-cryogenic-liquefied-thruster-fuel-barrel"
--recipeEmptyThrusterFuelBarrel.localised_name = { "recipe-name.empty-filled-barrel", { "fluid-name.thruster-fuel" } }
--recipeEmptyThrusterFuelBarrel.order = "b[new-fluid]-a[space]-a[thruster-fuel]"
--recipeEmptyThrusterFuelBarrel.category = "cryogenics"
recipeEmptyThrusterFuelBarrel.category = "chemistry-or-cryogenics"
recipeEmptyThrusterFuelBarrel.energy_required = recipeEmptyThrusterFuelBarrel.energy_required * fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier / 10 -- time to craft in seconds (at crafting speed 1)
--recipeEmptyThrusterFuelBarrel.ingredients = {
--    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel", amount = 1 }
--}
recipeEmptyThrusterFuelBarrel.results = {
    { type = "item", name = "barrel", amount = 1 },
    { type = "fluid", name = "thruster-fuel", amount = 50 * cryogenicLiquefiedThrusterFuelExpansionRatio }
}
--recipeEmptyThrusterFuelBarrel.enabled = false
--recipeEmptyThrusterFuelBarrel.always_show_made_in = false
--recipeEmptyThrusterFuelBarrel.icons = {
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png",
--        icon_size = 64
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0,
--            g = 0.1,
--            r = 0.53000000000000007
--        }
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.2,
--            g = 0.68000000000000007,
--            r = 0.93000000000000007
--        }
--    },
--    {
--        icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
--        icon_size = 64,
--        scale = 0.25,
--        shift = {
--            7,
--            8
--        }
--    }
--}

--recipeEmptyThrusterOxidizerBarrel.name = "cryogenic-liquefaction-empty-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel"
--recipeEmptyThrusterOxidizerBarrel.localised_name = { "recipe-name.empty-filled-barrel", { "fluid-name.thruster-oxidizer" } }
--recipeEmptyThrusterOxidizerBarrel.order = "b[new-fluid]-a[space]-a[thruster-oxidizer]"
--recipeEmptyThrusterOxidizerBarrel.category = "cryogenics"
recipeEmptyThrusterOxidizerBarrel.category = "chemistry-or-cryogenics"
recipeEmptyThrusterOxidizerBarrel.energy_required = recipeEmptyThrusterOxidizerBarrel.energy_required * fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier / 10 -- time to craft in seconds (at crafting speed 1)
--recipeEmptyThrusterOxidizerBarrel.ingredients = {
--    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel", amount = 1 }
--}
recipeEmptyThrusterOxidizerBarrel.results = {
    { type = "item", name = "barrel", amount = 1 },
    { type = "fluid", name = "thruster-oxidizer", amount = 50 * cryogenicLiquefiedThrusterOxidizerExpansionRatio }
}
--recipeEmptyThrusterOxidizerBarrel.enabled = false
--recipeEmptyThrusterOxidizerBarrel.always_show_made_in = false
--recipeEmptyThrusterOxidizerBarrel.icons = {
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png",
--        icon_size = 64
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.53000000000000007,
--            g = 0.1,
--            r = 0
--        }
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.93000000000000007,
--            g = 0.68000000000000007,
--            r = 0.2
--        }
--    },
--    {
--        icon = "__space-age__/graphics/icons/fluid/thruster-oxidizer.png",
--        icon_size = 64,
--        scale = 0.25,
--        shift = {
--            7,
--            8
--        }
--    }
--}

--local recipeThrusterFuelBarrelRecycling = data.raw["recipe"]["thruster-fuel-barrel-recycling"]
--local recipeThrusterOxidizerBarrelRecycling = data.raw["recipe"]["thruster-oxidizer-barrel-recycling"]

--recipeThrusterFuelBarrelRecycling.name = "cryogenic-liquefaction-recycle-cryogenic-cryogenic-liquefied-thruster-fuel-barrel"
--recipeThrusterFuelBarrelRecycling.localised_name = { "recipe-name.recycling", "SERPENT PLACEHOLDER" }
--recipeThrusterFuelBarrelRecycling.order = "b[new-fluid]-a[space]-a[thruster-fuel]"
--recipeThrusterFuelBarrelRecycling.category = "cryogenics" -- Recycling happens in the Recycler
--recipeThrusterFuelBarrelRecycling.energy_required = recipeThrusterFuelBarrelRecycling.energy_required * fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
--recipeThrusterFuelBarrelRecycling.ingredients = {
--    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel", amount = 1 }
--}
--recipeThrusterFuelBarrelRecycling.results = {
--    { type = "item", name = "barrel", amount = 0.25, extra_count_fraction = 0.25 }
--}
--recipeThrusterFuelBarrelRecycling.enabled = false
--recipeThrusterFuelBarrelRecycling.always_show_made_in = false
--recipeThrusterFuelBarrelRecycling.icons = {
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
--        icon_size = 64
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0,
--            g = 0.1,
--            r = 0.53000000000000007
--        }
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.2,
--            g = 0.68000000000000007,
--            r = 0.93000000000000007
--        }
--    },
--    {
--        icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
--        icon_size = 64,
--        scale = 0.25,
--        shift = {
--            -8,
--            -8
--        }
--    }
--}

--recipeThrusterOxidizerBarrelRecycling.name = "cryogenic-liquefaction-recycle-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel"
--recipeThrusterOxidizerBarrelRecycling.localised_name = { "recipe-name.recycling", "SERPENT PLACEHOLDER" }
--recipeThrusterOxidizerBarrelRecycling.order = "b[new-fluid]-a[space]-a[thruster-oxidizer]"
--recipeThrusterOxidizerBarrelRecycling.category = "cryogenics" -- Recycling happens in the Recycler
--recipeThrusterOxidizerBarrelRecycling.energy_required = recipeThrusterOxidizerBarrelRecycling.energy_required * fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
--recipeThrusterOxidizerBarrelRecycling.ingredients = {
--    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel", amount = 1 }
--}
--recipeThrusterOxidizerBarrelRecycling.results = {
--    { type = "item", name = "barrel", amount = 0.25, extra_count_fraction = 0.25 }
--}
--recipeThrusterOxidizerBarrelRecycling.enabled = false
--recipeThrusterOxidizerBarrelRecycling.always_show_made_in = false
--recipeThrusterOxidizerBarrelRecycling.icons = {
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
--        icon_size = 64
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.53000000000000007,
--            g = 0.1,
--            r = 0
--        }
--    },
--    {
--        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
--        icon_size = 64,
--        tint = {
--            a = 0.75,
--            b = 0.93000000000000007,
--            g = 0.68000000000000007,
--            r = 0.2
--        }
--    },
--    {
--        icon = "__space-age__/graphics/icons/fluid/thruster-oxidizer.png",
--        icon_size = 64,
--        scale = 0.25,
--        shift = {
--            -8,
--            -8
--        }
--    }
--}

--data:extend({
    --itemThrusterFuelBarrel,
    --itemThrusterOxidizerBarrel,
    --recipeThrusterFuelBarrel,
    --recipeThrusterOxidizerBarrel,
    --recipeEmptyThrusterFuelBarrel,
    --recipeEmptyThrusterOxidizerBarrel,
    --recipeThrusterFuelBarrelRecycling,
    --recipeThrusterOxidizerBarrelRecycling
--})

--local fluid_handling = data.raw["technology"]["fluid-handling"]
--
--if fluid_handling then
--    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-fill-cryogenic-cryogenic-liquefied-thruster-fuel-barrel" })
--    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-fill-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel" })
--    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-empty-cryogenic-cryogenic-liquefied-thruster-fuel-barrel" })
--    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-empty-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel" })
--    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-recycle-cryogenic-cryogenic-liquefied-thruster-fuel-barrel" })
--    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-recycle-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel" })
--end
