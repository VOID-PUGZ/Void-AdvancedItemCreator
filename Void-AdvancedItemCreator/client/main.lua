local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  PlayerData = {}
end)


RegisterCommand(Config.Command, function()
  OpenItemCreator()
end, false)


function OpenItemCreator()
  local options = {
    {
      title = 'Item Name (Spawncode)',
      description = 'Enter the item spawncode (e.g., burger, water)',
      icon = 'fas fa-tag',
      onSelect = function()
        OpenItemNameInput()
      end
    },
    {
      title = 'Item Label',
      description = 'Enter the display name for the item',
      icon = 'fas fa-font',
      onSelect = function()
        OpenItemLabelInput()
      end
    },
    {
      title = 'Stackable',
      description = 'Choose if the item can be stacked',
      icon = 'fas fa-layer-group',
      onSelect = function()
        OpenStackableInput()
      end
    },
    {
      title = 'Description',
      description = 'Enter the item description',
      icon = 'fas fa-align-left',
      onSelect = function()
        OpenDescriptionInput()
      end
    },
    {
      title = 'Item Type',
      description = 'Select if this is food, drink, or other',
      icon = 'fas fa-utensils',
      onSelect = function()
        OpenItemTypeInput()
      end
    },
    {
      title = 'Prop Selection',
      description = 'Choose the prop model for the item',
      icon = 'fas fa-cube',
      onSelect = function()
        OpenPropSelection()
      end
    },
    {
      title = 'Image Name',
      description = 'Choose the image name & extension for the item',
      icon = 'fas fa-utensils',
      onSelect = function()
        OpenImageSelector()
      end
    },
    {
      title = 'Generate Item',
      description = 'Create the item and save to output.txt',
      icon = 'fas fa-save',
      onSelect = function()
        GenerateItem()
      end
    }
  }
  lib.registerContext({
    id = 'item_creator_main',
    title = 'Advanced Item Creator',
    options = options
  })
  lib.showContext('item_creator_main')
end

function OpenItemNameInput()
  local input = lib.inputDialog('Item Name', {
    {
      type = 'input',
      label = 'Spawncode',
      description = 'Enter the item spawncode (no spaces)',
      required = true,
      placeholder = 'e.g., burger'
    }
  })

  if input then
    TriggerServerEvent('void-itemcreator:setItemName', input[1])
    Wait(100)
    OpenItemCreator()
  end
end

function OpenItemLabelInput()
  local input = lib.inputDialog('Item Label', {
    {
      type = 'input',
      label = 'Display Name',
      description = 'Enter the display name for the item',
      required = true,
      placeholder = 'e.g., Delicious Burger'
    }
  })

  if input then
    TriggerServerEvent('void-itemcreator:setItemLabel', input[1])
    Wait(100)
    OpenItemCreator()
  end
end

function OpenStackableInput()
  local options = {
    {
      title = 'Yes - Item can be stacked',
      description = 'Multiple items can be combined in one slot',
      icon = 'fas fa-check',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setStackable', true)
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'No - Item cannot be stacked',
      description = 'Each item takes its own slot',
      icon = 'fas fa-times',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setStackable', false)
        Wait(100)
        OpenItemCreator()
      end
    }
  }
  lib.registerContext({
    id = 'stackable_selector',
    title = 'Select Stackable Option',
    menu = 'item_creator_main',
    options = options
  })
  lib.showContext('stackable_selector')
end

function OpenPropSelection()
  local options = {
    {
      title = 'Food Props',
      description = 'Common food item props',
      icon = 'fas fa-hamburger',
      onSelect = function()
        OpenFoodProps()
      end
    },
    {
      title = 'Drink Props',
      description = 'Common drink item props',
      icon = 'fas fa-wine-glass',
      onSelect = function()
        OpenDrinkProps()
      end
    },
    {
      title = 'Weapon Props',
      description = 'Weapon and tool props',
      icon = 'fas fa-gun',
      onSelect = function()
        OpenWeaponProps()
      end
    },
    {
      title = 'Misc Props',
      description = 'Other miscellaneous props',
      icon = 'fas fa-box',
      onSelect = function()
        OpenMiscProps()
      end
    }
  }
  lib.registerContext({
    id = 'prop_category_selector',
    title = 'Select Prop Category',
    menu = 'item_creator_main',
    options = options
  })
  lib.showContext('prop_category_selector')
end

function OpenFoodProps()
  local options = {
    {
      title = 'Back to Categories',
      description = 'Return to prop categories',
      icon = 'fas fa-arrow-left',
      onSelect = function()
        OpenPropSelection()
      end
    },
    {
      title = 'Burger',
      description = 'prop_cs_burger_01',
      icon = 'fas fa-hamburger',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_cs_burger_01')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Pizza',
      description = 'prop_pizza_box_01',
      icon = 'fas fa-pizza-slice',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_pizza_box_01')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Apple',
      description = 'prop_apple_01',
      icon = 'fas fa-apple-alt',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_apple_01')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Banana',
      description = 'prop_banana_01',
      icon = 'fas fa-banana',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_banana_01')
        Wait(100)
        OpenItemCreator()
      end
    }
  }
  lib.registerContext({
    id = 'food_props',
    title = 'Food Props',
    menu = 'prop_category_selector',
    options = options
  })
  lib.showContext('food_props')
end

function OpenDrinkProps()
  local options = {
    {
      title = 'Back to Categories',
      description = 'Return to prop categories',
      icon = 'fas fa-arrow-left',
      onSelect = function()
        OpenPropSelection()
      end
    },
    {
      title = 'Coffee Cup',
      description = 'prop_coffee_cup_trailer',
      icon = 'fas fa-coffee',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_coffee_cup_trailer')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Water Bottle',
      description = 'prop_ld_flow_bottle',
      icon = 'fas fa-wine-bottle',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_ld_flow_bottle')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Beer Bottle',
      description = 'prop_beer_bottle',
      icon = 'fas fa-beer',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_beer_bottle')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Wine Glass',
      description = 'prop_wine_glass',
      icon = 'fas fa-wine-glass',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_wine_glass')
        Wait(100)
        OpenItemCreator()
      end
    }
  }
  lib.registerContext({
    id = 'drink_props',
    title = 'Drink Props',
    menu = 'prop_category_selector',
    options = options
  })
  lib.showContext('drink_props')
end

function OpenWeaponProps()
  local options = {
    {
      title = 'Back to Categories',
      description = 'Return to prop categories',
      icon = 'fas fa-arrow-left',
      onSelect = function()
        OpenPropSelection()
      end
    },
    {
      title = 'Knife',
      description = 'prop_knife',
      icon = 'fas fa-knife',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_knife')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Hammer',
      description = 'prop_tool_hammer',
      icon = 'fas fa-hammer',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_tool_hammer')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Wrench',
      description = 'prop_tool_wrench',
      icon = 'fas fa-wrench',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_tool_wrench')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Screwdriver',
      description = 'prop_tool_screwdvr01',
      icon = 'fas fa-screwdriver',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_tool_screwdvr01')
        Wait(100)
        OpenItemCreator()
      end
    }
  }
  lib.registerContext({
    id = 'weapon_props',
    title = 'Weapon & Tool Props',
    menu = 'prop_category_selector',
    options = options
  })
  lib.showContext('weapon_props')
end

function OpenMiscProps()
  local options = {
    {
      title = 'Back to Categories',
      description = 'Return to prop categories',
      icon = 'fas fa-arrow-left',
      onSelect = function()
        OpenPropSelection()
      end
    },
    {
      title = 'Phone',
      description = 'prop_npc_phone_02',
      icon = 'fas fa-mobile-alt',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_npc_phone_02')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Wallet',
      description = 'prop_ld_wallet_01',
      icon = 'fas fa-wallet',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_ld_wallet_01')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Keys',
      description = 'prop_cuff_keys_01',
      icon = 'fas fa-key',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_cuff_keys_01')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Cigarette',
      description = 'prop_cs_ciggy_01',
      icon = 'fas fa-smoking',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setProp', 'prop_cs_ciggy_01')
        Wait(100)
        OpenItemCreator()
      end
    }
  }

  lib.registerContext({
    id = 'misc_props',
    title = 'Miscellaneous Props',
    menu = 'prop_category_selector',
    options = options
  })

  lib.showContext('misc_props')
end

function OpenDescriptionInput()
  local input = lib.inputDialog('Item Description', {
    {
      type = 'textarea',
      label = 'Description',
      description = 'Enter a description for the item',
      required = false,
      placeholder = 'Optional description...'
    }
  })
  if input then
    TriggerServerEvent('void-itemcreator:setDescription', input[1])
    Wait(100)
    OpenItemCreator()
  end
end

function OpenItemTypeInput()
  local options = {
    {
      title = 'Food',
      description = 'This item is food',
      icon = 'fas fa-hamburger',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setItemType', 'food')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Drink',
      description = 'This item is a drink',
      icon = 'fas fa-wine-glass',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setItemType', 'drink')
        Wait(100)
        OpenItemCreator()
      end
    },
    {
      title = 'Other',
      description = 'This item is neither food nor drink',
      icon = 'fas fa-box',
      onSelect = function()
        TriggerServerEvent('void-itemcreator:setItemType', 'other')
        Wait(100)
        OpenItemCreator()
      end
    }
  }
  lib.registerContext({
    id = 'item_type_selector',
    title = 'Select Item Type',
    menu = 'item_creator_main',
    options = options
  })
  lib.showContext('item_type_selector')
end

function OpenImageSelector()
  local input = lib.inputDialog('Image URL', {
    {
      type = 'textarea',
      label = 'Description',
      description = 'Enter a thee image name for the item',
      required = true,
      placeholder = 'Optional Image Name/Extension'
    }
  })
  if input then
    TriggerServerEvent('void-itemcreator:setURL', input[1])
    Wait(100)
    OpenItemCreator()
  end
end

function GenerateItem()
  TriggerServerEvent('void-itemcreator:generateItem')
end

RegisterNetEvent('void-itemcreator:notify', function(message, type)
  lib.notify({ description = message, type = type or 'info' })
end)
