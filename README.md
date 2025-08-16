# Void Advanced Item Creator

A FiveM script for QBCore that allows administrators to create ox_inventory items through an intuitive command interface with ox_lib context menus.

## Features

- **Easy Item Creation**: Create items through a simple command interface
- **ox_lib Integration**: Modern, responsive UI using ox_lib context menus
- **Automatic Formatting**: Generates properly formatted ox_inventory item code
- **Food/Drink Support**: Special handling for consumable items with proper status effects
- **File Output**: Automatically saves generated items to `output.txt`

## Dependencies

- [qb-core](https://github.com/qbcore-framework/qb-core)
- [ox_lib](https://github.com/overextended/ox_lib)

## Installation

1. Download and place the script in your server's resources folder
2. Add `ensure void-advanceditemcreator` to your `server.cfg`
3. Restart your server

## Usage

### Main Command
- `/createitem` - Opens the item creator interface

### Additional Commands
- `/itemdata` - Check current item data
- `/clearitemdata` - Clear current item data

### Creating an Item

1. Use `/createitem` to open the interface
2. Fill in the required fields:
   - **Item Name (Spawncode)**: The item's unique identifier (e.g., `burger`)
   - **Item Label**: Display name (e.g., `Delicious Burger`)
   - **Weight**: Item weight in grams
   - **Stack**: true or false
   - **Prop**: Chose A list Of Props To be used
   - **Description**: Optional item description
   - **Item Type**: Select if it's food, drink, or other

3. Click "Generate Item" to create and save the item

## Output Format

### Food/Drink Items
```lua
['burger'] = {
    label = 'Delicious Burger',
    weight = 220,
    allowArmed = false,
    client = {
        status = { hunger = 25 },
        anim = 'eating',
        prop = 'burger',
        usetime = 2500,
    },
},
```

### Regular Items
```lua
['toolbox'] = {
    label = 'Toolbox',
    weight = 1000,
    stack = 1,
    description = 'A sturdy toolbox for repairs',
},
```

## Configuration

Edit `config.lua` to customize:
- Command name
- Output file path
- Default values
- Food/drink detection
- Animation and prop mappings

## Permissions

Admin Locked.

## Support

For support, please check:
1. Ensure all dependencies are properly installed
2. Check server console for any error messages
3. Verify you have admin permissions

## License

## Discord
```lua
Join My Discord For Support
-- https://discord.gg/7nkuEFWp --
```


This script is provided as-is for educational and server use purposes.
