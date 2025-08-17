local QBCore = exports['qb-core']:GetCoreObject()

local ItemData = {
    name = nil,
    label = nil,
    stackable = nil,
    description = nil,
    itemType = nil,
    prop = nil,
    inventorySystem = nil
}


RegisterNetEvent('void-itemcreator:setItemName', function(name)
    local src = source
    ItemData.name = name
    TriggerClientEvent('void-itemcreator:notify', src, 'Item name set to: ' .. name, 'success')
end)

RegisterNetEvent('void-itemcreator:setItemLabel', function(label)
    local src = source
    ItemData.label = label
    TriggerClientEvent('void-itemcreator:notify', src, 'Item label set to: ' .. label, 'success')
end)

RegisterNetEvent('void-itemcreator:setStackable', function(stackable)
    local src = source
    ItemData.stackable = stackable
    local status = stackable and 'stackable' or 'not stackable'
    TriggerClientEvent('void-itemcreator:notify', src, 'Item set to: ' .. status, 'success')
end)

RegisterNetEvent('void-itemcreator:setDescription', function(description)
    local src = source
    ItemData.description = description
    TriggerClientEvent('void-itemcreator:notify', src, 'Item description set to: ' .. description, 'success')
end)

RegisterNetEvent('void-itemcreator:setItemType', function(itemType)
    local src = source
    ItemData.itemType = itemType
    TriggerClientEvent('void-itemcreator:notify', src, 'Item type set to: ' .. itemType, 'success')
end)

RegisterNetEvent('void-itemcreator:setProp', function(prop)
    local src = source
    ItemData.prop = prop
    TriggerClientEvent('void-itemcreator:notify', src, 'Item prop set to: ' .. prop, 'success')
end)

RegisterNetEvent('void-itemcreator:setInventorySystem', function(system)
    local src = source
    ItemData.inventorySystem = system
    local systemName = system == 'qb' and 'qb-inventory' or 'ox_inventory'
    TriggerClientEvent('void-itemcreator:notify', src, 'Inventory system set to: ' .. systemName, 'success')
end)


RegisterNetEvent('void-itemcreator:generateItem', function()
    local src = source
    if not ItemData.name or not ItemData.label or not ItemData.stackable then
        TriggerClientEvent('void-itemcreator:notify', src, 'Please fill in all required fields first!', 'error')
        return
    end
    
    if not ItemData.inventorySystem then
        TriggerClientEvent('void-itemcreator:notify', src, 'Please select an inventory system first!', 'error')
        return
    end

    local itemCode = GenerateItemCode()
    
    local success = SaveToFile(itemCode)
    
    if success then
        TriggerClientEvent('void-itemcreator:notify', src, 'Item generated and saved to output.txt!', 'success')
        ItemData = {
            name = nil,
            label = nil,
            stackable = nil,
            description = nil,
            itemType = nil,
            prop = nil,
            inventorySystem = nil
        }
    else
        TriggerClientEvent('void-itemcreator:notify', src, 'Failed to save item to file!', 'error')
    end
end)


function GenerateItemCode()
    local itemCode = ""
    
    if ItemData.inventorySystem == 'qb' then
        -- qb-inventory format
        itemCode = string.format([[
%s					 = { name = '%s', 			  	  	      label = '%s', 			   weight = 0, 		       type = 'item', 		    image = '%s.png', 				     unique = false, 	       useable = true, 	    shouldClose = true,       combinable = nil,   description = '%s'},]], 
            ItemData.name,
            ItemData.name, 
            ItemData.label, 
            ItemData.name,
            ItemData.description or 'No description provided'
        )
    else
        -- ox_inventory format
        if ItemData.itemType == 'food' or ItemData.itemType == 'drink' then
            local statusType = ItemData.itemType == 'food' and 'hunger' or 'thirst'
            local statusValue = ItemData.itemType == 'food' and 25 or 30
            local anim = ItemData.itemType == 'food' and 'eating' or 'drinking'
            
            itemCode = string.format([[
 ['%s'] = {
        label = '%s',
        stackable = %s,
        allowArmed = %s,
        client = {
            status = { %s = %d },
            anim = '%s',
            prop = '%s',
            usetime = %d,
        },
    },]], 
                ItemData.name, 
                ItemData.label, 
                tostring(ItemData.stackable), 
                tostring(Config.Defaults.allowArmed), 
                statusType, 
                statusValue, 
                anim, 
                ItemData.prop or 'prop_cs_burger_01', 
                Config.Defaults.usetime
            )
        else
            itemCode = string.format([[
 ['%s'] = {
        label = '%s',
        stackable = %s,
        description = '%s',
    },]], 
                ItemData.name, 
                ItemData.label, 
                tostring(ItemData.stackable), 
                ItemData.description or ''
            )
        end
    end
    
    return itemCode
end


function SaveToFile(itemCode)
    local filePath = GetResourcePath(GetCurrentResourceName()) .. '/' .. Config.OutputFile
    local timestamp = os.date('%Y-%m-%d %H:%M:%S')
    local separator = string.rep('-', 50)
    local content = string.format([[
-- Generated on: %s
-- Item: %s
%s
%s

]], timestamp, ItemData.name, separator, itemCode)
    local file = io.open(filePath, 'a')
    if file then
        file:write(content)
        file:close()
        return true
    else
        return false
    end
end


QBCore.Commands.Add('itemdata', 'Check current item data', {}, false, function(source, args)
    local src = source
    local data = json.encode(ItemData, {indent = true})
    TriggerClientEvent('void-itemcreator:notify', src, 'Current item data: ' .. data, 'primary')
end)


QBCore.Commands.Add('clearitemdata', 'Clear current item data', {}, false, function(source, args)
    local src = source
            ItemData = {
            name = nil,
            label = nil,
            stackable = nil,
            description = nil,
            itemType = nil,
            prop = nil,
            inventorySystem = nil
        }
    TriggerClientEvent('void-itemcreator:notify', src, 'Item data cleared!', 'success')
end)


RegisterNetEvent('void-itemcreator:getItemData', function()
    local src = source
    TriggerClientEvent('void-itemcreator:receiveItemData', src, ItemData)
end)
