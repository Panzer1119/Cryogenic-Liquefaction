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

itemThrusterFuelBarrel.localised_name = { "item-name.cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel" }
itemThrusterFuelBarrel.localised_description = { "item-description.cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel" }
itemThrusterFuelBarrel.stack_size = cryogenicLiquefiedThrusterFuelBarrelStackSize
itemThrusterFuelBarrel.weight = 1000 * 1000 / cryogenicLiquefiedThrusterFuelBarrelStackSize

itemThrusterOxidizerBarrel.localised_name = { "item-name.cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel" }
itemThrusterOxidizerBarrel.localised_description = { "item-description.cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel" }
itemThrusterOxidizerBarrel.stack_size = cryogenicLiquefiedThrusterOxidizerBarrelStackSize
itemThrusterOxidizerBarrel.weight = 1000 * 1000 / cryogenicLiquefiedThrusterOxidizerBarrelStackSize

-- TODO Rename it from filling to cooling?

local recipeThrusterFuelBarrel = data.raw["recipe"]["thruster-fuel-barrel"]
local recipeThrusterOxidizerBarrel = data.raw["recipe"]["thruster-oxidizer-barrel"]

--recipeThrusterFuelBarrel.localised_name = { "recipe-name.fill-barrel", { "fluid-name.thruster-fuel" } }
recipeThrusterFuelBarrel.energy_required = recipeThrusterFuelBarrel.energy_required * fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
recipeThrusterFuelBarrel.ingredients = {
    { type = "item", name = "barrel", amount = 1, ignored_by_stats = 1 },
    { type = "fluid", name = "thruster-fuel", amount = 50 * cryogenicLiquefiedThrusterFuelExpansionRatio, ignored_by_stats = 50 * cryogenicLiquefiedThrusterFuelExpansionRatio }
}

--recipeThrusterOxidizerBarrel.localised_name = { "recipe-name.fill-barrel", { "fluid-name.thruster-oxidizer" } }
recipeThrusterOxidizerBarrel.energy_required = recipeThrusterOxidizerBarrel.energy_required * fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
recipeThrusterOxidizerBarrel.ingredients = {
    { type = "item", name = "barrel", amount = 1, ignored_by_stats = 1 },
    { type = "fluid", name = "thruster-oxidizer", amount = 50 * cryogenicLiquefiedThrusterOxidizerExpansionRatio, ignored_by_stats = 50 * cryogenicLiquefiedThrusterOxidizerExpansionRatio }
}

if liquefactionRequiresCryogenicPlant then
    recipeThrusterFuelBarrel.category = "cryogenics"
    recipeThrusterOxidizerBarrel.category = "cryogenics"
else
    recipeThrusterFuelBarrel.category = "chemistry-or-cryogenics"
    recipeThrusterOxidizerBarrel.category = "chemistry-or-cryogenics"
end

local recipeEmptyThrusterFuelBarrel = data.raw["recipe"]["empty-thruster-fuel-barrel"]
local recipeEmptyThrusterOxidizerBarrel = data.raw["recipe"]["empty-thruster-oxidizer-barrel"]

--recipeEmptyThrusterFuelBarrel.localised_name = { "recipe-name.empty-filled-barrel", { "fluid-name.thruster-fuel" } }
recipeEmptyThrusterFuelBarrel.category = "chemistry-or-cryogenics"
recipeEmptyThrusterFuelBarrel.energy_required = recipeEmptyThrusterFuelBarrel.energy_required * fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier / 10 -- time to craft in seconds (at crafting speed 1)
recipeEmptyThrusterFuelBarrel.results = {
    { type = "item", name = "barrel", amount = 1 },
    { type = "fluid", name = "thruster-fuel", amount = 50 * cryogenicLiquefiedThrusterFuelExpansionRatio }
}

--recipeEmptyThrusterOxidizerBarrel.localised_name = { "recipe-name.empty-filled-barrel", { "fluid-name.thruster-oxidizer" } }
recipeEmptyThrusterOxidizerBarrel.category = "chemistry-or-cryogenics"
recipeEmptyThrusterOxidizerBarrel.energy_required = recipeEmptyThrusterOxidizerBarrel.energy_required * fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier / 10 -- time to craft in seconds (at crafting speed 1)
recipeEmptyThrusterOxidizerBarrel.results = {
    { type = "item", name = "barrel", amount = 1 },
    { type = "fluid", name = "thruster-oxidizer", amount = 50 * cryogenicLiquefiedThrusterOxidizerExpansionRatio }
}
