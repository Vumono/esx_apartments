# esx_apartments
Simple apartments resource managed clientside, the storage and clothing all use exports and can easily be changed. PR's are always welcome.

This resource is created with esx Legacy, other versions **might** not work without modifying the resource.

### WIP
* invite players into home
* givekeys to other players
* more different motels

### Dependencies
* [es_extended] https://github.com/overextended/es_extended #ox version
* [ox_inventory](https://github.com/overextended/ox_inventory)
* [qtarget](https://github.com/QuantusRP/qtarget)
* [nh-context](https://github.com/LukeWasTakenn/nh-context)
* [fivem-appearance](https://forum.cfx.re/t/brp-fivem-appearance/4170313)
* [cd-drawtextui](https://github.com/dsheedes/cd_drawtextui)
### recommended
* [Breze-motelroom](https://forum.cfx.re/t/release-motel-room-mlo/846934)

Make sure to follow the detailed installation of the Dependencies
### Installation
* download the resource
* drop the resource somewhere in resources folder
* start the resource after the dependencies in server.cfg

If you wish to change the locations, you have to do it yourself in the client.lua. 
To add the stash add this to your ox_inventory\data\stashes.lua
```{
		coords = vec3(150.8704, -1003.6064, -98.9825),
		target = {
			loc = vec3(149.47420, -1004.55900, -99.98502),
			length = 0.6,
			width = 1.8,
			heading = 90,
			minZ = 43.34,
			maxZ = 44.74
		},
		name = 'Apartmentstash',
		label = 'Apartement stash',
		owner = true,
		slots = 50,
		weight = 400000,
	},
