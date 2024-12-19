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

data:extend({
    {
        type = "bool-setting",
        name = "cryogenic-liquefaction-liquefaction-requires-cryogenic-plant",
        setting_type = "startup",
        order = "aa",
        default_value = true,
    },
    {
        type = "double-setting",
        name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-expansion-ratio",
        setting_type = "startup",
        order = "ba",
        default_value = 800,
        minimum_value = 0.01,
        maximum_value = 1000000
    },
    {
        type = "double-setting",
        name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-expansion-ratio",
        setting_type = "startup",
        order = "bb",
        default_value = 800,
        minimum_value = 0.01,
        maximum_value = 1000000
    },
    {
        type = "int-setting",
        name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-fuel-barrel-stack-size",
        setting_type = "startup",
        order = "ca",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 1000
    },
    {
        type = "int-setting",
        name = "cryogenic-liquefaction-cryogenic-liquefied-thruster-oxidizer-barrel-stack-size",
        setting_type = "startup",
        order = "cb",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 1000
    },
    {
        type = "double-setting",
        name = "cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-fuel-barrel-energy-multiplier",
        setting_type = "startup",
        order = "da",
        default_value = 1000,
        minimum_value = 0.01,
        maximum_value = 1000000
    },
    {
        type = "double-setting",
        name = "cryogenic-liquefaction-fill-cryogenic-liquefied-thruster-oxidizer-barrel-energy-multiplier",
        setting_type = "startup",
        order = "db",
        default_value = 1000,
        minimum_value = 0.01,
        maximum_value = 1000000
    }
})
