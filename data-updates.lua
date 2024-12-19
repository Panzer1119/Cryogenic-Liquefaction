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

-- Retrieve settings

local liquefactionRequiresCryogenicPlant = settings.startup["cryogenic-liquefaction-liquefaction-requires-cryogenic-plant"].value

local cryogenicLiquefiedThrusterFuelExpansionRatio = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-expansion-ratio"].value
local cryogenicLiquefiedThrusterOxidizerExpansionRatio = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-expansion-ratio"].value

local cryogenicLiquefiedThrusterFuelBarrelStackSize = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel-stack-size"].value
local cryogenicLiquefiedThrusterOxidizerBarrelStackSize = settings.startup["cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel-stack-size"].value

local fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier = settings.startup["cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-fuel-barrel-energy-multiplier"].value
local fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier = settings.startup["cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-oxidizer-barrel-energy-multiplier"].value

-- Calculate some values

local cryogenicLiquefiedThrusterFuelBarrelWeight = 1000 * 1000 / cryogenicLiquefiedThrusterFuelBarrelStackSize
local cryogenicLiquefiedThrusterOxidizerBarrelWeight = 1000 * 1000 / cryogenicLiquefiedThrusterOxidizerBarrelStackSize

local emptyCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier = fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier / 10
local emptyCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier = fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier / 10

-- Define some functions

-- Multiplies the amount (and if set ignored_by_stats) by the multiplier of the item identified by the itemType and itemName
local function multiplyItem(items, itemType, itemName, multiplier)
    for _, item in pairs(items) do
        -- If the item does not have a name field, treat the item as an array and compare the first value to the itemName and skip it if it does not match
        if not item.name and item[1] ~= itemName then
            goto continue
        end
        -- If the item does have a name field, compare the item's type and name to the itemType and itemName and skip it if they do not match
        if item.type ~= itemType or item.name ~= itemName then
            goto continue
        end
        -- Multiply the amount (and if set ignored_by_stats) by the multiplier
        item.amount = item.amount * multiplier
        if item.ignored_by_stats then
            item.ignored_by_stats = item.ignored_by_stats * multiplier
        end
        :: continue ::
    end
end

-- Removes the item from the table if the item's key matches the value
local function removeEntryByKeyValue(object, key, value)
    for i = #object, 1, -1 do
        if object[i][key] == value then
            table.remove(object, i)
            return
        end
    end
    error("Could not find entry with key '" .. key .. "' and value '" .. value .. "' in table " .. serpent.block(object))
end

-- Modify items

local itemThrusterFuelBarrel = data.raw["item"]["thruster-fuel-barrel"]
local itemThrusterOxidizerBarrel = data.raw["item"]["thruster-oxidizer-barrel"]

itemThrusterFuelBarrel.localised_name = { "item-name.cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel" }
itemThrusterFuelBarrel.localised_description = { "item-description.cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel" }
itemThrusterFuelBarrel.stack_size = cryogenicLiquefiedThrusterFuelBarrelStackSize
itemThrusterFuelBarrel.weight = cryogenicLiquefiedThrusterFuelBarrelWeight

itemThrusterOxidizerBarrel.localised_name = { "item-name.cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel" }
itemThrusterOxidizerBarrel.localised_description = { "item-description.cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel" }
itemThrusterOxidizerBarrel.stack_size = cryogenicLiquefiedThrusterOxidizerBarrelStackSize
itemThrusterOxidizerBarrel.weight = cryogenicLiquefiedThrusterOxidizerBarrelWeight

-- Modify recipes

-- -- Modify the filling recipes for the cryogenic liquefied thruster fuel and oxidizer barrels

-- TODO Rename it from filling to cooling?

local recipeThrusterFuelBarrel = data.raw["recipe"]["thruster-fuel-barrel"]
local recipeThrusterOxidizerBarrel = data.raw["recipe"]["thruster-oxidizer-barrel"]

recipeThrusterFuelBarrel.localised_name = { "recipe-name.cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-fuel-barrel" }
recipeThrusterFuelBarrel.localised_description = { "recipe-description.cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-fuel-barrel" }
recipeThrusterFuelBarrel.energy_required = recipeThrusterFuelBarrel.energy_required * fillCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
multiplyItem(recipeThrusterFuelBarrel.ingredients, "fluid", "thruster-fuel", cryogenicLiquefiedThrusterFuelExpansionRatio)

recipeThrusterOxidizerBarrel.localised_name = { "recipe-name.cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-oxidizer-barrel" }
recipeThrusterOxidizerBarrel.localised_description = { "recipe-description.cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-oxidizer-barrel" }
recipeThrusterOxidizerBarrel.energy_required = recipeThrusterOxidizerBarrel.energy_required * fillCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
multiplyItem(recipeThrusterOxidizerBarrel.ingredients, "fluid", "thruster-oxidizer", cryogenicLiquefiedThrusterOxidizerExpansionRatio)

if liquefactionRequiresCryogenicPlant then
    recipeThrusterFuelBarrel.category = "cryogenics"
    recipeThrusterOxidizerBarrel.category = "cryogenics"
else
    recipeThrusterFuelBarrel.category = "chemistry-or-cryogenics"
    recipeThrusterOxidizerBarrel.category = "chemistry-or-cryogenics"
end

-- -- Modify the emptying recipes for the cryogenic liquefied thruster fuel and oxidizer barrels

local recipeEmptyThrusterFuelBarrel = data.raw["recipe"]["empty-thruster-fuel-barrel"]
local recipeEmptyThrusterOxidizerBarrel = data.raw["recipe"]["empty-thruster-oxidizer-barrel"]

recipeEmptyThrusterFuelBarrel.localised_name = { "recipe-name.cryogenic-liquefaction-empty-cryogenic-liquefied-thruster-fuel-barrel" }
recipeEmptyThrusterFuelBarrel.localised_description = { "recipe-description.cryogenic-liquefaction-empty-cryogenic-liquefied-thruster-fuel-barrel" }
recipeEmptyThrusterFuelBarrel.category = "chemistry-or-cryogenics"
recipeEmptyThrusterFuelBarrel.energy_required = recipeEmptyThrusterFuelBarrel.energy_required * emptyCryogenicLiquefiedThrusterFuelBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
multiplyItem(recipeEmptyThrusterFuelBarrel.results, "fluid", "thruster-fuel", cryogenicLiquefiedThrusterFuelExpansionRatio)

recipeEmptyThrusterOxidizerBarrel.localised_name = { "recipe-name.cryogenic-liquefaction-empty-cryogenic-liquefied-thruster-fuel-barrel" }
recipeEmptyThrusterOxidizerBarrel.localised_description = { "recipe-description.cryogenic-liquefaction-empty-cryogenic-liquefied-thruster-fuel-barrel" }
recipeEmptyThrusterOxidizerBarrel.category = "chemistry-or-cryogenics"
recipeEmptyThrusterOxidizerBarrel.energy_required = recipeEmptyThrusterOxidizerBarrel.energy_required * emptyCryogenicLiquefiedThrusterOxidizerBarrelEnergyMultiplier -- time to craft in seconds (at crafting speed 1)
multiplyItem(recipeEmptyThrusterOxidizerBarrel.results, "fluid", "thruster-oxidizer", cryogenicLiquefiedThrusterOxidizerExpansionRatio)

-- Modify technologies

-- Move the fill recipe unlocks to the Cryogenic plant technology if liquefactionRequiresCryogenicPlant is true
if liquefactionRequiresCryogenicPlant then
    -- Get the technologies
    local technologyFluidHandling = data.raw["technology"]["fluid-handling"]
    local technologyCryogenicPlant = data.raw["technology"]["cryogenic-plant"]
    -- Check if the technologies exist
    if not technologyFluidHandling then
        error("Technology 'fluid-handling' does not exist.")
    end
    if not technologyCryogenicPlant then
        error("Technology 'cryogenic-plant' does not exist.")
    end
    affectedRecipes = { "thruster-fuel-barrel", "thruster-oxidizer-barrel", }
    for _, recipeName in pairs(affectedRecipes) do
        -- Remove the fill recipes from the Fluid handling technology
        removeEntryByKeyValue(technologyFluidHandling.effects, "recipe", recipeName)
        -- Move the fill recipes to the Cryogenic plant technology
        table.insert(technologyCryogenicPlant.effects, { type = "unlock-recipe", recipe = recipeName })
    end
end
