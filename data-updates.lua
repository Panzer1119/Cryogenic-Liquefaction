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

local cryogenicLiquefiedThrusterFuelExpansionRatio = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-expansion-ratio"].value
local cryogenicLiquefiedThrusterOxidizerExpansionRatio = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-expansion-ratio"].value

local cryogenicLiquefiedThrusterFuelBarrelStackSize = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel-stack-size"].value
local cryogenicLiquefiedThrusterOxidizerBarrelStackSize = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel-stack-size"].value

local fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier = settings.startup["cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-fuel-barrel-energy-multiplier"].value
local fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier = settings.startup["cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-oxidizer-barrel-energy-multiplier"].value

local cryogenicLiquefiedThrusterFuelBarrelItem = table.deepcopy(data.raw["item"]["light-oil-barrel"])

cryogenicLiquefiedThrusterFuelBarrelItem.name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel"
--cryogenicLiquefiedThrusterFuelBarrelItem.localised_name = { "item-name.cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel" }
cryogenicLiquefiedThrusterFuelBarrelItem.localised_name = { "item-name.filled-barrel", { "fluid-name.thruster-fuel" } }
--cryogenicLiquefiedThrusterFuelBarrelItem.order = "b[cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel]"
cryogenicLiquefiedThrusterFuelBarrelItem.order = "b[new-fluid]-a[space]-a[thruster-fuel]"
--cryogenicLiquefiedThrusterFuelBarrelItem.icon = "__CryogenicLiquefaction__/graphics/icons/cryogenic-liquefied-thruster-fuel-barrel.png"
cryogenicLiquefiedThrusterFuelBarrelItem.stack_size = cryogenicLiquefiedThrusterFuelBarrelStackSize
cryogenicLiquefiedThrusterFuelBarrelItem.weight = 1000 * 1000 / cryogenicLiquefiedThrusterFuelBarrelStackSize
cryogenicLiquefiedThrusterFuelBarrelItem.icons = {
    {
        icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
        icon_size = 64
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0,
            g = 0.1,
            r = 0.53000000000000007
        }
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.2,
            g = 0.68000000000000007,
            r = 0.93000000000000007
        }
    }
}

local cryogenicLiquefiedThrusterOxidizerBarrelItem = table.deepcopy(data.raw["item"]["water-barrel"])

cryogenicLiquefiedThrusterOxidizerBarrelItem.name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel"
--cryogenicLiquefiedThrusterOxidizerBarrelItem.localised_name = { "item-name.cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel" }
cryogenicLiquefiedThrusterOxidizerBarrelItem.localised_name = { "item-name.filled-barrel", { "fluid-name.thruster-oxidizer" } }
--cryogenicLiquefiedThrusterOxidizerBarrelItem.order = "b[cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel]"
cryogenicLiquefiedThrusterOxidizerBarrelItem.order = "b[new-fluid]-a[space]-a[thruster-oxidizer]"
--cryogenicLiquefiedThrusterOxidizerBarrelItem.icon = "__CryogenicLiquefaction__/graphics/icons/cryogenic-liquefied-thruster-oxidizer-barrel.png"
cryogenicLiquefiedThrusterOxidizerBarrelItem.stack_size = cryogenicLiquefiedThrusterOxidizerBarrelStackSize
cryogenicLiquefiedThrusterOxidizerBarrelItem.weight = 1000 * 1000 / cryogenicLiquefiedThrusterOxidizerBarrelStackSize
cryogenicLiquefiedThrusterOxidizerBarrelItem.icons = {
    {
        icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
        icon_size = 64
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.53000000000000007,
            g = 0.1,
            r = 0
        }
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.93000000000000007,
            g = 0.68000000000000007,
            r = 0.2
        }
    }
}

-- TODO Rename it from filling to cooling?

local fillCryogenicLiquefiedThrusterFuelBarrelRecipe = table.deepcopy(data.raw["recipe"]["light-oil-barrel"])

fillCryogenicLiquefiedThrusterFuelBarrelRecipe.name = "cryogenic-liquefaction-fill-cryogenic-cryogenic-liquefied-thruster-fuel-barrel"
fillCryogenicLiquefiedThrusterFuelBarrelRecipe.localised_name = { "recipe-name.fill-barrel", { "fluid-name.thruster-fuel" } }
fillCryogenicLiquefiedThrusterFuelBarrelRecipe.order = "b[new-fluid]-a[space]-a[thruster-fuel]"
fillCryogenicLiquefiedThrusterFuelBarrelRecipe.category = "cryogenics"
fillCryogenicLiquefiedThrusterFuelBarrelRecipe.energy_required = fillCryogenicLiquefiedThrusterFuelBarrelRecipe.energy_required * fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
fillCryogenicLiquefiedThrusterFuelBarrelRecipe.ingredients = {
    { type = "item", name = "barrel", amount = 1, ignored_by_stats = 1 },
    { type = "fluid", name = "thruster-fuel", amount = 50 * cryogenicLiquefiedThrusterFuelExpansionRatio, ignored_by_stats = 50 * cryogenicLiquefiedThrusterFuelExpansionRatio }
}
fillCryogenicLiquefiedThrusterFuelBarrelRecipe.results = {
    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel", amount = 1, ignored_by_stats = 1 }
}
--fillCryogenicLiquefiedThrusterFuelBarrelRecipe.enabled = false
--fillCryogenicLiquefiedThrusterFuelBarrelRecipe.always_show_made_in = false
fillCryogenicLiquefiedThrusterFuelBarrelRecipe.icons = {
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
        icon_size = 64
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0,
            g = 0.1,
            r = 0.53000000000000007
        }
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.2,
            g = 0.68000000000000007,
            r = 0.93000000000000007
        }
    },
    {
        icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
        icon_size = 64,
        scale = 0.25,
        shift = {
            -8,
            -8
        }
    }
}

local fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe = table.deepcopy(data.raw["recipe"]["water-barrel"])

fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.name = "cryogenic-liquefaction-fill-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel"
fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.localised_name = { "recipe-name.fill-barrel", { "fluid-name.thruster-oxidizer" } }
fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.order = "b[new-fluid]-a[space]-a[thruster-oxidizer]"
fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.category = "cryogenics"
fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.energy_required = fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.energy_required * fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.ingredients = {
    { type = "item", name = "barrel", amount = 1, ignored_by_stats = 1 },
    { type = "fluid", name = "thruster-oxidizer", amount = 50 * cryogenicLiquefiedThrusterOxidizerExpansionRatio, ignored_by_stats = 50 * cryogenicLiquefiedThrusterOxidizerExpansionRatio }
}
fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.results = {
    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel", amount = 1, ignored_by_stats = 1 }
}
--fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.enabled = false
--fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.always_show_made_in = false
fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe.icons = {
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
        icon_size = 64
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.53000000000000007,
            g = 0.1,
            r = 0
        }
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.93000000000000007,
            g = 0.68000000000000007,
            r = 0.2
        }
    },
    {
        icon = "__space-age__/graphics/icons/fluid/thruster-oxidizer.png",
        icon_size = 64,
        scale = 0.25,
        shift = {
            -8,
            -8
        }
    }
}

local emptyCryogenicLiquefiedThrusterFuelBarrelRecipe = table.deepcopy(data.raw["recipe"]["empty-light-oil-barrel"])

emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.name = "cryogenic-liquefaction-empty-cryogenic-cryogenic-liquefied-thruster-fuel-barrel"
emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.localised_name = { "recipe-name.empty-filled-barrel", { "fluid-name.thruster-fuel" } }
emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.order = "b[new-fluid]-a[space]-a[thruster-fuel]"
--emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.category = "cryogenics"
emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.category = "chemistry-or-cryogenics"
emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.energy_required = emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.energy_required * fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier / 10 -- time to craft in seconds (at crafting speed 1)
emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.ingredients = {
    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel", amount = 1 }
}
emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.results = {
    { type = "item", name = "barrel", amount = 1 },
    { type = "fluid", name = "thruster-fuel", amount = 50 * cryogenicLiquefiedThrusterFuelExpansionRatio }
}
--emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.enabled = false
--emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.always_show_made_in = false
emptyCryogenicLiquefiedThrusterFuelBarrelRecipe.icons = {
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png",
        icon_size = 64
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0,
            g = 0.1,
            r = 0.53000000000000007
        }
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.2,
            g = 0.68000000000000007,
            r = 0.93000000000000007
        }
    },
    {
        icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
        icon_size = 64,
        scale = 0.25,
        shift = {
            7,
            8
        }
    }
}

local emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe = table.deepcopy(data.raw["recipe"]["empty-water-barrel"])

emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.name = "cryogenic-liquefaction-empty-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel"
emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.localised_name = { "recipe-name.empty-filled-barrel", { "fluid-name.thruster-oxidizer" } }
emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.order = "b[new-fluid]-a[space]-a[thruster-oxidizer]"
--emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.category = "cryogenics"
emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.category = "chemistry-or-cryogenics"
emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.energy_required = emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.energy_required * fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier / 10 -- time to craft in seconds (at crafting speed 1)
emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.ingredients = {
    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel", amount = 1 }
}
emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.results = {
    { type = "item", name = "barrel", amount = 1 },
    { type = "fluid", name = "thruster-oxidizer", amount = 50 * cryogenicLiquefiedThrusterOxidizerExpansionRatio }
}
--emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.enabled = false
--emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.always_show_made_in = false
emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe.icons = {
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png",
        icon_size = 64
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.53000000000000007,
            g = 0.1,
            r = 0
        }
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.93000000000000007,
            g = 0.68000000000000007,
            r = 0.2
        }
    },
    {
        icon = "__space-age__/graphics/icons/fluid/thruster-oxidizer.png",
        icon_size = 64,
        scale = 0.25,
        shift = {
            7,
            8
        }
    }
}

local recycleCryogenicLiquefiedThrusterFuelBarrelRecipe = table.deepcopy(data.raw["recipe"]["light-oil-barrel-recycling"])

recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.name = "cryogenic-liquefaction-recycle-cryogenic-cryogenic-liquefied-thruster-fuel-barrel"
recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.localised_name = { "recipe-name.recycling", "SERPENT PLACEHOLDER" }
--recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.order = "b[new-fluid]-a[space]-a[thruster-fuel]"
--recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.category = "cryogenics" -- Recycling happens in the Recycler
--recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.energy_required = recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.energy_required * fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.ingredients = {
    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel", amount = 1 }
}
recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.results = {
    { type = "item", name = "barrel", amount = 0.25, extra_count_fraction = 0.25 }
}
--recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.enabled = false
--recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.always_show_made_in = false
recycleCryogenicLiquefiedThrusterFuelBarrelRecipe.icons = {
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
        icon_size = 64
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0,
            g = 0.1,
            r = 0.53000000000000007
        }
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.2,
            g = 0.68000000000000007,
            r = 0.93000000000000007
        }
    },
    {
        icon = "__space-age__/graphics/icons/fluid/thruster-fuel.png",
        icon_size = 64,
        scale = 0.25,
        shift = {
            -8,
            -8
        }
    }
}

local recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe = table.deepcopy(data.raw["recipe"]["water-barrel-recycling"])

recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.name = "cryogenic-liquefaction-recycle-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel"
recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.localised_name = { "recipe-name.recycling", "SERPENT PLACEHOLDER" }
--recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.order = "b[new-fluid]-a[space]-a[thruster-oxidizer]"
--recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.category = "cryogenics" -- Recycling happens in the Recycler
--recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.energy_required = recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.energy_required * fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.ingredients = {
    { type = "item", name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel", amount = 1 }
}
recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.results = {
    { type = "item", name = "barrel", amount = 0.25, extra_count_fraction = 0.25 }
}
--recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.enabled = false
--recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.always_show_made_in = false
recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe.icons = {
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
        icon_size = 64
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.53000000000000007,
            g = 0.1,
            r = 0
        }
    },
    {
        icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
        icon_size = 64,
        tint = {
            a = 0.75,
            b = 0.93000000000000007,
            g = 0.68000000000000007,
            r = 0.2
        }
    },
    {
        icon = "__space-age__/graphics/icons/fluid/thruster-oxidizer.png",
        icon_size = 64,
        scale = 0.25,
        shift = {
            -8,
            -8
        }
    }
}

data:extend({
    cryogenicLiquefiedThrusterFuelBarrelItem,
    cryogenicLiquefiedThrusterOxidizerBarrelItem,
    fillCryogenicLiquefiedThrusterFuelBarrelRecipe,
    fillCryogenicLiquefiedThrusterOxidizerBarrelRecipe,
    emptyCryogenicLiquefiedThrusterFuelBarrelRecipe,
    emptyCryogenicLiquefiedThrusterOxidizerBarrelRecipe,
    recycleCryogenicLiquefiedThrusterFuelBarrelRecipe,
    recycleCryogenicLiquefiedThrusterOxidizerBarrelRecipe
})

local fluid_handling = data.raw["technology"]["fluid-handling"]

if fluid_handling then
    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-fill-cryogenic-cryogenic-liquefied-thruster-fuel-barrel" })
    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-fill-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel" })
    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-empty-cryogenic-cryogenic-liquefied-thruster-fuel-barrel" })
    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-empty-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel" })
    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-recycle-cryogenic-cryogenic-liquefied-thruster-fuel-barrel" })
    table.insert(fluid_handling.effects, { type = "unlock-recipe", recipe = "cryogenic-liquefaction-recycle-cryogenic-cryogenic-liquefied-thruster-oxidizer-barrel" })
end
