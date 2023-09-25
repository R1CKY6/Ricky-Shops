Config = {}

Config.Framework = 'esx' -- esx or qbcore

Config.Locales = {
    ['add'] = "Add",
    ['remove_all'] = "Remove all",
    ['buy'] = "Buy",
    ['basket'] = "Basket",
    ['search_product'] = "Search a Product",
    ['total_price'] = "Total Price",
    ['no_money'] = "You do not have money"
}


Config.Shops = {
    [1] = {
        blip = {
            enable = true,
            sprite = 59,
            colour = 69,
            scale = 0.8,
            label = "Shop"
        },
        coords = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
        },
        item = {
            {
                name = "burger",
                label = "Burger",
                price = 500,
                type = "legendary",
                img = 'burger.png'
            },
            {
                name = "acqua",
                label = "Water",
                price = 5,
                type = "rare",
                img = 'water.png'
            },
            {
                name = "chips",
                label = "Chips",
                price = 5,
                type = "comune",
                img = 'chips.png'
            },
            {
                name = "bandage",
                label = "Bandage",
                price = 5,
                type = "epic",
                img = 'bandage.png'
            },
            {
                name = "acqua",
                label = "Pile",
                price = 5,
                type = "superlegendary",
                img = 'pile.png'
            },
        }
    },
    [2] = {
        blip = {
            enable = true,
            sprite = 59,
            colour = 69,
            scale = 0.8,
            label = "Shop"
        },
        coords = {
			vec3(-1393.409, -606.624, 30.319)
        },
        item = {
            {
                label = "Burger",
                price = 5,
                type = "legendary",
                img = 'burger.png'
            },
        }
    },
}