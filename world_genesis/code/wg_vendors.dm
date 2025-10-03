//WORLD GENESIS - SNACKTRON VENDOR
/obj/machinery/vending/imported/snacktron
	name = "SnackTron™"
	desc = "The flagship vending product for World Genesis. When you need a snack we've got your back!"
	icon = 'world_genesis/icons/machinery/vendors.dmi'
	icon_state = "snacktron"
	panel_type = "panel15"
	light_mask = "nt_food-light-mask"
	light_color = "#00ff40"
	product_ads = "You've encountered SnackTron! How fortunate for your hunger and/or thirst!;We've got your back when it comes to snacks!;What time is it? Snack time!"
	vend_reply = "SnackTron hopes you enjoy your selection!"

	product_categories = list(
		list(
			"name" = "Snacks",
			"icon" = "cookie",
			"products" = list(
				/obj/item/food/peanuts/random = 6,
				/obj/item/food/cnds/random = 6,
				/obj/item/food/pistachios = 6,
				/obj/item/food/cornchips/random = 6,
				/obj/item/food/sosjerky = 6,
				/obj/item/reagent_containers/cup/soda_cans/cola = 6,
				/obj/item/reagent_containers/cup/soda_cans/lemon_lime = 6,
				/obj/item/reagent_containers/cup/soda_cans/starkist = 6,
				/obj/item/reagent_containers/cup/soda_cans/pwr_game = 6,
			),
		),
		list(
			"name" = "Meals",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/nt = 6,
				/obj/item/storage/box/foodpack/nt/burger = 6,
				/obj/item/storage/box/foodpack/nt/chicken_sammy = 6,
				/obj/item/food/vendor_tray_meal/side = 6,
				/obj/item/food/vendor_tray_meal/side/crackers_and_jam = 6,
				/obj/item/food/vendor_tray_meal/side/crackers_and_cheese = 6,
			),
		),
	)

	refill_canister = /obj/item/vending_refill/snack/imported
	default_price = PAYCHECK_CREW * 0.5
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES
	allow_custom = TRUE



//WORLD GENESIS - GLOBODROBE VENDOR
/obj/machinery/vending/imported/globodrobe
	name = "Globodrobe™"
	desc = "A specialized machine that vends modular clothing items for the horizontally impaired."
	icon = 'world_genesis/icons/machinery/vendors.dmi'
	icon_state = "globodrobe"
	panel_type = "panel15"
	light_mask = "nt_food-light-mask"
	light_color = "#ff00f2"
	product_ads = "Wardrobe around the globe!;Suited and booted!;The finest threads for the finest employees!"
	vend_reply = "Looking good boss! Stop by again soon!"

	product_categories = list(
		list(
			"name" = "Jumpsuits",
			"icon" = "shirt",
			"products" = list(
				/obj/item/clothing/under/color/grey/cargo = 6,
				/obj/item/clothing/under/color/grey/medical= 6,
				/obj/item/clothing/under/color/grey/science = 6,
				/obj/item/clothing/under/color/grey/service = 6,
				/obj/item/clothing/under/color/grey/security = 6,
				/obj/item/clothing/under/color/grey/command = 6,
				/obj/item/clothing/under/color/grey/engi = 6,
			),
		),
	)

	refill_canister = /obj/item/vending_refill/snack/imported
	default_price = PAYCHECK_CREW * 0.5
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES
	allow_custom = TRUE

//Cake
/obj/item/wg13/devilcake
	icon = 'world_genesis/icons/machinery/vendors.dmi'
	icon_state = "devilcake"
	name = "Devil's Food Cake"
	desc = "A twisted treat that lets out demonic groans when bit into."

/obj/item/wg13/devilcake/attack(mob/living/carbon/M, mob/living/carbon/user) //WG13 Edible Gainium
	to_chat(M, "<span class='alert'>You take a bite from the devil's food cake.</span>")
	to_chat(user, "<span class='notice'>You feed the devil's food cake to [M], causing it to regenrate some of itself as you do so!</span>")
	playsound(M, 'sound/items/eatfood.ogg', 60, 1)
	M.fatness_real += 20
