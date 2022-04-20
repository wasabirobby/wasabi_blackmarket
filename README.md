# Wasabi's ESX Black Market Script

This resource was created as a free alternative for a alternating black market script with security against client dumps.

<b>Features:</b>
- Custom UI(Credits to whoever created 'Shops UI' : https://forum.cfx.re/t/release-esx-shops-ui/1025053)
- Option to add multiple locations where black market ped will spawn at randomly per server restart
- Config saved to server side and sent to client via callback to eliminate sweaty kids from attempting to obtain location via client dump
- Location and additional security checks to ensure no one triggers events for profit
- Ability to add custom images or just drag over inventory image of item name into the `html/images/` directory
- All weapon item images have already been added for your convenience(Credits to `linden_inventory` for those images)
- Configurable webhooks for purchase logs as well as exploit logs
- 0.00 MS on idle - 0.00 MS while in use
- It's FREE

## Requirements
- es_extended (v1.2 and above, easy to adjust for older though)
- qtarget


## Installation

- Download 
- Put script in your `resources` directory
- Add `ensure wasabi_blackmarket` in your `server.cfg`

### Extra Information
- Only supports weapons as items (May add config option for server owners who use weapons in the future)
- Images must match the same name as the item name in config and placed in the `html/images` directory
- Will add additional features such as random police notify soon when I have time

## Preview
- Simple Preview: https://www.youtube.com/watch?v=aoZngJ2I81k

- Server console on start: https://cdn.discordapp.com/attachments/894737355418771506/966159496105820181/consoleprint.png
- Webhook preview: https://cdn.discordapp.com/attachments/894737355418771506/966195867705032724/unknown.png

# Support
Join our discord <a href='https://discord.gg/XJFNyMy3Bv'>HERE</a> for additional scripts and support!
