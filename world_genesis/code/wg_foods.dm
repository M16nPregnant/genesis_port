/obj/item/wg13/cake
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "strawberryicecreamsandwich"

/obj/item/wg13/cake/attack(mob/living/carbon/M, mob/living/carbon/user) //WG13 Edible Gainium
	to_chat(user, "<span class='notice'>You crunch down on the gainium shard. It tastes like rock candy!</span>")
	playsound(user, 'sound/items/eatfood.ogg', 60, 1)
	qdel(src)
