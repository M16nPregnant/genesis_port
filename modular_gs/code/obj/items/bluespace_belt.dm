/obj/item/bluespace_belt
	name = "bluespace belt"
	desc = "A belt made using bluespace technology. The power of space and time, used to hide the fact you are fat."
	icon = 'modular_gs/icons/obj/clothing/bluespace_belt.dmi'
	worn_icon = 'modular_gs/icons/mob/clothing/bsbelts.dmi'
	icon_state = "bluespace_belt"
	inhand_icon_state = "bluespace_belt"
	slot_flags = ITEM_SLOT_BELT
	equip_sound = 'modular_gs/sound/items/equip/toolbelt_equip.ogg'
	drop_sound = 'modular_gs/sound/items/handling/toolbelt_drop.ogg'
	pickup_sound =  'modular_gs/sound/items/handling/toolbelt_pickup.ogg'
	var/equipped = FALSE		// is it in the belt slot?

/obj/item/bluespace_belt/equipped(mob/user, slot)
	..()
	if(!iscarbon(user))
		return
	var/mob/living/carbon/U = user
	if(slot == ITEM_SLOT_BELT)
		equipped = TRUE
		to_chat(U, "<span class='notice'>You put the belt around your waist and your mass begins to shrink...</span>")
		U.hider_add(src)
	else if(equipped)
		equipped = FALSE
		to_chat(user, "<span class='notice'>The belt is opened, letting your mass flow out!</span>")
		U.hider_remove(src)

/obj/item/bluespace_belt/dropped(mob/user)
	..()
	if(!iscarbon(user))
		return
	var/mob/living/carbon/U = user
	if (equipped)
		to_chat(U, "<span class='warning'>The belt is opened, letting your mass flow out!</span>")
	U.hider_remove(src)

/obj/item/bluespace_belt/proc/fat_hide(var/mob/living/carbon/user)
	return -(user.fatness_real - 1)

/obj/item/bluespace_belt/primitive
	name = "primitive bluespace belt"
	desc = "A primitive belt made using bluespace technology. The power of space and time, used to hide the fact you are fat. This one requires cells to continue operating, and may suffer from random failures."
	icon = 'modular_gs/icons/obj/clothing/bluespace_belt.dmi'
	icon_state = "primitive_belt"
	inhand_icon_state = "primitive_belt"

	var/cell_type = /obj/item/stock_parts/power_store/cell/high
	var/obj/item/stock_parts/power_store/cell/cell
	var/power_drain = 3
	var/mob/living/carbon/user		// the fatass who's weight we must track for power drain calcs
	var/overloaded = FALSE		// is it EMP'ed?

	// RegisterSignal(user, COMSIG_MOB_CLICKON, PROC_REF(on_clicked), TRUE)

/obj/item/bluespace_belt/primitive/examine(mob/user)
	. = ..()
	if(cell && cell.charge)
		. += "<span class='notice'>It seems to have [display_energy(cell.charge)] of power remaining.</span>"
	else
		. += "<span class='notice'>It seems to be out of power.</span>"

/obj/item/bluespace_belt/primitive/Initialize(mapload)
	. = ..()
	if(!cell && cell_type)
		cell = new cell_type

/obj/item/bluespace_belt/primitive/emp_act(severity)
	. = ..()

	if(cell && !(. & EMP_PROTECT_CONTENTS))
		cell.emp_act(severity)

	overloaded = TRUE
	to_chat(loc, "<span class='warning'>\The [src] overloads!</span>")
	deactivate()
	addtimer(CALLBACK(src, PROC_REF(emp_act_end)), severity*10, TIMER_UNIQUE | TIMER_NO_HASH_WAIT | TIMER_OVERRIDE)

/obj/item/bluespace_belt/primitive/proc/emp_act_end()
	overloaded = FALSE
	activate()

/obj/item/bluespace_belt/primitive/proc/activate()
	if (overloaded)
		deactivate()
		return

	if(!cell)
		deactivate()
		return

	if(!cell.charge)
		deactivate()
		return

	if(!isnull(user) && equipped)
		user.hider_add(src)

	icon_state = "primitive_belt"
	START_PROCESSING(SSprocessing, src)

/obj/item/bluespace_belt/primitive/proc/deactivate()
	if(!isnull(user))
		user.hider_remove(src)

	STOP_PROCESSING(SSprocessing, src)
	icon_state = "primitive_belt_off"

/obj/item/bluespace_belt/primitive/fat_hide(var/mob/living/carbon/user)
	var/weight_to_hide = 0
	// if (user?.client?.prefs.helplessness_belts)
	// 	var/belts_pref = user?.client?.prefs.helplessness_belts
	// 	weight_to_hide = min(belts_pref, user.fatness_real - 1)
	// else		//make sure to indent this bit below later
	weight_to_hide = min(FATNESS_LEVEL_19, user.fatness_real - 1)
	return -(weight_to_hide)


/obj/item/bluespace_belt/primitive/equipped(mob/U, slot)
	..()
	if(!iscarbon(U))
		user = null
		return

	user = U
	if(slot == ITEM_SLOT_BELT && !cell)
		equipped = TRUE
		to_chat(user, "<span class='notice'>You put the belt around your waist, but it seems that the battery is missing!</span>")
		deactivate()
	else if(slot == ITEM_SLOT_BELT && !cell.charge)
		equipped = TRUE
		to_chat(user, "<span class='notice'>You put the belt around your waist, but it seems that the battery is dead!</span>")
		deactivate()
	else if(slot == ITEM_SLOT_BELT && cell.charge)
		equipped = TRUE
		to_chat(user, "<span class='notice'>You put the belt around your waist and your mass begins to shrink...</span>")
		activate()
	else
		if(equipped)
			equipped = FALSE
			to_chat(user, "<span class='notice'>The belt is opened, letting your mass flow out!</span>")
			user.hider_remove(src)

/obj/item/bluespace_belt/primitive/item_interaction(mob/living/person, obj/item/W, list/modifiers)
	if (istype(W, /obj/item/stock_parts/power_store/cell))
		if(!person.transferItemToLoc(W, src))
			return
		if (!cell)
			to_chat(person, "<span class='notice'>You put the cell into the belt</span>")
		else
			to_chat(person, "<span class='notice'>You swiftly replace the cell in the belt</span>")
			person.put_in_hands(cell)
		cell = W

		if (equipped && cell.charge)
			to_chat(person, "<span class='notice'>Your mass begins to shrink as the belt is powered again...</span>")
			user = person

		activate()

/obj/item/bluespace_belt/primitive/attack_self(mob/person)
	if (!cell)
		return

	to_chat(person, "<span class='notice'>You take the cell out of the belt, letting your mass flow out!</span>")
	person.put_in_hands(cell)
	cell = null
	deactivate()


/obj/item/bluespace_belt/primitive/dropped(mob/person)
	..()
	user = null
	equipped = FALSE

/obj/item/bluespace_belt/primitive/process()
	if(isnull(user))
		return

	if (!cell)
		return

	if (!cell.charge)
		to_chat(user, "<span class='notice'>The belt beeps as it's battery runs out, and your mass starts flowing out!</span>")
		deactivate()
		return

	if(!equipped)
		STOP_PROCESSING(SSprocessing, src)
		return

	power_drain = min(power_drain, cell.charge)
	cell.use(power_drain)
	cell.update_icon()
