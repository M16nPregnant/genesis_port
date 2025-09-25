
// see code/module/crafting/table.dm

////////////////////////////////////////////////PIZZA!!!////////////////////////////////////////////////

//GS13 - this has been ported from CHOMP/Virgo, but I've decided to adjust the recipe a bit
// there's both the recipe and the defines for the pizza itself here

/obj/item/food/pizza/framewrecker
	name = "Framewrecker Pizza"
	desc = "You feel your arteries clogging just by merely looking at this monster. Is this even real, or a mere hallucination?"
	icon = 'modular_gs/icons/obj/food/food64x64.dmi'
	icon_state = "theonepizza"
	pixel_x = -16
	pixel_y = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 200, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/consumable/nutriment/vitamin = 20)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "overwhelming surge of calories" = 10)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD | ANTITOXIC

	var/slicelist = list(/obj/item/food/pizzaslice/framewrecker/mushroom,
						 /obj/item/food/pizzaslice/framewrecker/veggie,
						 /obj/item/food/pizzaslice/framewrecker/cheese,
						 /obj/item/food/pizzaslice/framewrecker/pineapple,
						 /obj/item/food/pizzaslice/framewrecker/meat)



//slices
/obj/item/food/pizzaslice/framewrecker
	name = "Framewrecker Pizza Slice"
	desc = "This mere slice is the size of pizza on its own!"
	icon = 'modular_gs/icons/obj/food/ported_meals.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 60)
	icon_state = "big_mushroom_slice"
	filling_color = "#FFA500"

/obj/item/food/pizzaslice/framewrecker/mushroom
	name = "Giant mushroom pizza slice"
	icon_state = "big_mushroom_slice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushrooms" = 1, "delight" = 5)
	foodtype = GRAIN | VEGETABLES | DAIRY | JUNKFOOD

/obj/item/food/pizzaslice/framewrecker/veggie
	name = "Giant veggie pizza slice"
	icon_state = "big_veggie_slice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "veggies" = 1, "delight" = 5)
	foodtype = GRAIN | VEGETABLES | DAIRY | JUNKFOOD

/obj/item/food/pizzaslice/framewrecker/pineapple
	name = "Giant pineapple pizza slice"
	icon_state = "big_pineapple_slice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "ham" = 1, "pineapple" = 5)
	foodtype = GRAIN | VEGETABLES | DAIRY | JUNKFOOD | FRUIT
/obj/item/food/pizzaslice/framewrecker/meat
	name = "Giant meat pizza slice"
	icon_state = "big_veggie_slice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "delight" = 5)
	foodtype = GRAIN | VEGETABLES | DAIRY | JUNKFOOD | MEAT
/obj/item/food/pizzaslice/framewrecker/cheese
	name = "Giant cheese pizza slice"
	icon_state = "big_cheese_slice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "delight" = 5)
	foodtype = GRAIN | VEGETABLES | DAIRY | JUNKFOOD

/obj/item/food/pizza/framewrecker/attackby(var/obj/item/W, var/mob/living/user)
	if(istype(W,/obj/item/kitchen/knife))
		user.visible_message("<b>\The [user]</b> starts to slowly cut through The One Pizza.", "<span class='notice'>You start to slowly cut through The One Pizza.</span>")
		if(!src)
			return		// We got disappeared already
		user.visible_message("<b>\The [user]</b> successfully cuts The One Pizza.", "<span class='notice'>You successfully cut The One Pizza.</span>")
		for(var/slicetype in slicelist)
			new slicetype(src.loc)
		qdel(src)



// recipe

/datum/crafting_recipe/food/framewrecker_pizza
	name = "Framewrecker Pizza"
	reqs = list(
		/obj/item/food/pizzabread = 4,
		/obj/item/food/meat/cutlet = 4,
		/obj/item/food/cheesewedge = 8,
		/obj/item/food/grown/tomato = 8,
		/obj/item/food/pineappleslice = 2,
		/obj/item/food/grown/mushroom/chanterelle = 2
	)
	result = /obj/item/food/pizza/framewrecker
	subcategory = CAT_PIZZA
