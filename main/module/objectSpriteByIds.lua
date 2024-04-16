local M = {}

M.objects = {
	[0] = {name = "Bedroom-Bed-1", prototype = "/main/game/locations/prototypes/objects/2x3_prototype.goc"},
	[1] = {name = "Bedroom-Bed-2", prototype = "/main/game/locations/prototypes/objects/1x3_prototype.goc"},
	[2] = {name = "Bedroom-Night Table", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	
	[6] = {name = "Device-Multipurpose-2", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[7] = {name = "Device-Multipurpose-3", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[8] = {name = "Device-Photocopier", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[9] = {name = "Device-Computer (Back)", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[10] = {name = "Device-Computer (Front)", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[11] = {name = "Device-Computer (Left)", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[12] = {name = "Device-Computer (Right)", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[13] = {name = "Device-Multipurpose-1", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	
	[14] = {name = "Furniture-Bench-2", prototype = "/main/game/locations/prototypes/objects/2x1_prototype.goc"},
	[15] = {name = "Furniture-Book Shelf-1", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[16] = {name = "Furniture-Chair (Back)-1", prototype = "/main/game/locations/prototypes/objects/2x2_prototype.goc"},
	[17] = {name = "Furniture-Chair (Front)-1", prototype = "/main/game/locations/prototypes/objects/2x2_prototype.goc"},
	[18] = {name = "Furniture-Chair (Left)-1", prototype = "/main/game/locations/prototypes/objects/2x2_prototype.goc"},
	[19] = {name = "Furniture-Chair (Right)-1", prototype = "/main/game/locations/prototypes/objects/2x2_prototype.goc"},
	[20] = {name = "Furniture-Glass Table-1", prototype = "/main/game/locations/prototypes/objects/2x1_prototype.goc"},
	[21] = {name = "Furniture-Glass Table-2", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},

	
	[22] = {name = "Furniture-Office Chair (Back)-1", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[23] = {name = "Furniture-Office Chair (Front)-1", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},


	[24] = {name = "Furniture-Office Chair (Left)-1", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[25] = {name = "Furniture-Office Chair (Right)-1", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[26] = {name = "Furniture-Shelf-1", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[27] = {name = "Furniture-Shelf-2", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[28] = {name = "Furniture-Shelf-3", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[29] = {name = "Furniture-Small Table-1", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[30] = {name = "Furniture-Small Table-2", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[31] = {name = "Furniture-Sofa-1", prototype = "/main/game/locations/prototypes/objects/2x2_prototype.goc"},
	[32] = {name = "Furniture-Sofa-2", prototype = "/main/game/locations/prototypes/objects/2x2_prototype.goc"},
	[33] = {name = "Furniture-Table (Horizontal)-1", prototype = "/main/game/locations/prototypes/objects/2x1_prototype.goc"},
	[34] = {name = "Furniture-Table (Horizontal)-2", prototype = "/main/game/locations/prototypes/objects/2x1_prototype.goc"},


	[35] = {name = "Furniture-Table (Vertical)-1", prototype = "/main/game/locations/prototypes/objects/1x2_solid_prototype.goc"},


	[36] = {name = "Furniture-Table (Vertical)-2", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[37] = {name = "Furniture-TV Table", prototype = "/main/game/locations/prototypes/objects/2x1_prototype.goc"},
	[38] = {name = "Furniture-Bench-1", prototype = "/main/game/locations/prototypes/objects/2x2_prototype.goc"},
	[39] = {name = "Item-7", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[40] = {name = "Item-8", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[41] = {name = "Item-9", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[42] = {name = "Item-1", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[43] = {name = "Item-2", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[44] = {name = "Item-3", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[45] = {name = "Item-4", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[46] = {name = "Item-5", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[47] = {name = "Item-6", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[48] = {name = "Kitchen-Fridge", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[49] = {name = "Kitchen-Sink", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[50] = {name = "Kitchen-Washer", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[51] = {name = "Kitchen-Cooker", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[52] = {name = "Miscellaneous-Bin-2", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[53] = {name = "Miscellaneous-Chest-1", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[54] = {name = "Miscellaneous-Crate", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[55] = {name = "Miscellaneous-Plant-1", prototype = "/main/game/locations/prototypes/objects/1x2_prototype.goc"},
	[56] = {name = "Miscellaneous-Bin-1", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[57] = {name = "Shop-Counter (Back)", prototype = "/main/game/locations/prototypes/objects/2x2_prototype.goc"},
	[58] = {name = "Shop-Counter (Front)", prototype = "/main/game/locations/prototypes/objects/2x2_prototype.goc"},
	[59] = {name = "Shop-Fridge-1", prototype = "/main/game/locations/prototypes/objects/2x1_prototype.goc"},
	[60] = {name = "Shop-Shelf-1", prototype = "/main/game/locations/prototypes/objects/2x2_prototype.goc"},
	[61] = {name = "Wall-Frame Art", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[62] = {name = "Wall-Round Device", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[63] = {name = "Wall-Socket", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[64] = {name = "Wall-Square Device", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[65] = {name = "Wall-Switch", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},
	[69] = {name = "Wall-Mirror", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"},

	[73] = {name = "Miscellaneous-Stand", prototype = "/main/game/locations/prototypes/objects/1x1_prototype.goc"}
}

return M
