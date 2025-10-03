
/mob/living/carbon/human/proc/update_body_size(mob/living/carbon/human/H, size_change)
	if(!istype(H))
		return

// /*
	var/obj/item/organ/genital/butt/butt = H.get_organ_slot(ORGAN_SLOT_BUTT)
	var/obj/item/organ/genital/belly/belly = H.get_organ_slot(ORGAN_SLOT_BELLY)
	var/obj/item/organ/genital/breasts/breasts = H.get_organ_slot(ORGAN_SLOT_BREASTS)
	// var/obj/item/organ/genital/taur_belly/tbelly = H.get_organ_slot(ORGAN_SLOT_TAUR_BELLY)

	if(butt)
		if(butt.max_genital_size > 0)
			if((butt.genital_size + size_change) <= butt.max_genital_size)
				butt.set_size(size_change + butt.set_genital_size)
		else
			butt.set_size(size_change + butt.set_genital_size)
	if(belly)
		if(belly.max_genital_size > 0)
			if((belly.genital_size + size_change) <= belly.max_genital_size)
				belly.set_size(size_change + belly.set_genital_size)
		else
			belly.set_size(size_change + belly.set_genital_size)
	// if(tbelly)
	// 	if(tbelly.max_genital_size > 0)
	// 		if((tbelly.size + size_change) <= tbelly.max_genital_size)
	// 			tbelly.set_size(size_change)
	// 	else
	// 		tbelly.set_size(size_change)
	if(breasts)
		if(breasts.max_genital_size > 0)
			if((breasts.genital_size + size_change) <= breasts.max_genital_size)
				breasts.set_size(size_change + breasts.set_genital_size)
		else
			breasts.set_size(size_change + breasts.set_genital_size)

	// H.genital_override = TRUE
	H.update_body()
	H.update_worn_undersuit()
	H.update_worn_oversuit()

// Do this later.
// */

/mob/living/carbon/human/proc/handle_fatness_trait(trait, trait_lose, trait_gain, fatness_lose, fatness_gain, chat_lose, chat_gain, weight_stage)
	var/mob/living/carbon/human/H = src
	if(H.fatness < fatness_lose)
		if (chat_lose)
			to_chat(H, chat_lose)
		if (trait)
			REMOVE_TRAIT(H, trait, OBESITY)
		if (trait_lose)
			ADD_TRAIT(H, trait_lose, OBESITY)
		update_body_size(H, weight_stage - 1)
	else if(H.fatness >= fatness_gain)
		if (chat_gain)
			to_chat(H, chat_gain)
		if (trait)
			REMOVE_TRAIT(H, trait, OBESITY)
		if (trait_gain)
			ADD_TRAIT(H, trait_gain, OBESITY)
		update_body_size(H, weight_stage)

/mob/living/carbon/human/proc/handle_helplessness()
	return TRUE
	/*
	Later
	var/mob/living/carbon/human/fatty = src
	var/datum/preferences/preferences = fatty?.client?.prefs
	if(!istype(preferences) || HAS_TRAIT(fatty, TRAIT_NO_HELPLESSNESS))
		return FALSE

	if(preferences.helplessness_no_movement)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_no_movement)
				to_chat(fatty, "<span class='warning'>You have become too fat to move anymore.</span>")
				ADD_TRAIT(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_no_movement)
			to_chat(fatty, "<span class='notice'>You have become thin enough to regain some of your mobility.</span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_MOVE, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_clumsy)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clumsy)
				to_chat(fatty, "<span class='warning'>Your newfound weight has made it hard to manipulate objects.</span>")
				ADD_TRAIT(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_clumsy)
			to_chat(fatty, "<span class='notice'>You feel like you have lost enough weight to recover your dexterity.</span>")
			REMOVE_TRAIT(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_CLUMSY, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_nearsighted)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NEARSIGHT, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_nearsighted)
				to_chat(fatty, "<span class='warning'>Your fat makes it difficult to see the world around you. </span>")
				fatty.become_nearsighted(HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_nearsighted)
			to_chat(fatty, "<span class='notice'>You are thin enough to see your enviornment again. </span>")
			fatty.cure_nearsighted(HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NEARSIGHT, HELPLESSNESS_TRAIT))
			fatty.cure_nearsighted(HELPLESSNESS_TRAIT)


	if(preferences.helplessness_hidden_face)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_hidden_face)
				to_chat(fatty, "<span class='warning'>You have gotten fat enough that your face is now unrecognizable. </span>")
				ADD_TRAIT(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_hidden_face)
			to_chat(fatty, "<span class='notice'>You have lost enough weight to allow people to now recognize your face.</span>")
			REMOVE_TRAIT(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_DISFIGURED, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_mute)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_mute)
				to_chat(fatty, "<span class='warning'>Your fat makes it impossible for you to speak.</span>")
				ADD_TRAIT(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_mute)
			to_chat(fatty, "<span class='notice'>You are thin enough now to be able to speak again. </span>")
			REMOVE_TRAIT(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_MUTE, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_immobile_arms)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_immobile_arms)
				to_chat(fatty, "<span class='warning'>Your arms are now engulfed in fat, making it impossible to move your arms. </span>")
				ADD_TRAIT(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
				ADD_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
				fatty.update_disabled_bodyparts()

		else if(fatty.fatness < preferences.helplessness_immobile_arms)
			to_chat(fatty, "<span class='notice'>You are able to move your arms again. </span>")
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
			fatty.update_disabled_bodyparts()

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_L_ARM, HELPLESSNESS_TRAIT)
			REMOVE_TRAIT(fatty, TRAIT_PARALYSIS_R_ARM, HELPLESSNESS_TRAIT)
			fatty.update_disabled_bodyparts()

	if(preferences.helplessness_clothing_jumpsuit)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clothing_jumpsuit)
				ADD_TRAIT(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)

				var/obj/item/clothing/under/jumpsuit = fatty.w_uniform
				if(istype(jumpsuit) && jumpsuit.modular_icon_location == null)
					to_chat(fatty, "<span class='warning'>[jumpsuit] can no longer contain your weight!</span>")
					fatty.dropItemToGround(jumpsuit)

		else if(fatty.fatness < preferences.helplessness_clothing_jumpsuit)
			to_chat(fatty, "<span class='notice'>You feel thin enough to put on jumpsuits now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_JUMPSUIT, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_clothing_misc)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clothing_misc)
				ADD_TRAIT(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)

				var/obj/item/clothing/suit/worn_suit = fatty.wear_suit
				if(istype(worn_suit) && !istype(worn_suit, /obj/item/clothing/suit/mod))
					to_chat(fatty, "<span class='warning'>[worn_suit] can no longer contain your weight!</span>")
					fatty.dropItemToGround(worn_suit)

				var/obj/item/clothing/gloves/worn_gloves = fatty.gloves
				if(istype(worn_gloves)&& !istype(worn_gloves, /obj/item/clothing/gloves/mod))
					to_chat(fatty, "<span class='warning'>[worn_gloves] can no longer contain your weight!</span>")
					fatty.dropItemToGround(worn_gloves)

				var/obj/item/clothing/shoes/worn_shoes = fatty.shoes
				if(istype(worn_shoes) && !istype(worn_shoes, /obj/item/clothing/shoes/mod))
					to_chat(fatty, "<span class='warning'>[worn_shoes] can no longer contain your weight!</span>")
					fatty.dropItemToGround(worn_shoes)

		else if(fatty.fatness < preferences.helplessness_clothing_misc)
			to_chat(fatty, "<span class='notice'>You feel thin enough to put on suits, shoes, and gloves now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_MISC, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_belts)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_BELT, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_belts)
				ADD_TRAIT(fatty, TRAIT_NO_BELT, HELPLESSNESS_TRAIT)

				// if(istype(fatty.belt, /obj/item/bluespace_belt))
				var/obj/item/bluespace_belt/primitive/PBS_belt = fatty.belt
				if(istype(PBS_belt) && fatty.fatness > preferences.helplessness_belts)
					// to_chat(fatty, "<span class='warning'>[PBS_belt] can no longer contain your weight!</span>")
					fatty.visible_message("<span class='warning'>[PBS_belt] fails as it's unable to contain [fatty]'s bulk!</span>", "<span class='warning'>[PBS_belt] fails as it's unable to contain your bulk!</span>")
					fatty.dropItemToGround(PBS_belt)

				var/obj/item/storage/belt/belt = fatty.belt
				if(istype(belt))
					// to_chat(fatty, "<span class='warning'>[belt] can no longer contain your weight!</span>")
					fatty.visible_message("<span class='warning'>With a loud ripping sound, [fatty]'s [belt] snaps open!</span>", "<span class='warning'>With a loud ripping sound, your [belt] snaps open!</span>")
					fatty.dropItemToGround(belt)

		else if(fatty.fatness < preferences.helplessness_belts)
			to_chat(fatty, "<span class='notice'>You feel thin enough to put on belts now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_BELT, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_BELT, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_BELT, HELPLESSNESS_TRAIT)

	if(preferences.helplessness_clothing_back)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_clothing_back)
				ADD_TRAIT(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)
				var/obj/item/back_item = fatty.back
				if(istype(back_item) && !istype(back_item, /obj/item/mod))
					to_chat(fatty, "<span class='warning'>Your weight makes it impossible for you to carry [back_item].</span>")
					fatty.dropItemToGround(back_item)

		else if(fatty.fatness < preferences.helplessness_clothing_back)
			to_chat(fatty, "<span class='notice'>You feel thin enough to hold items on your back now. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_BACKPACK, HELPLESSNESS_TRAIT)


	if(preferences.helplessness_no_buckle)
		if(!HAS_TRAIT_FROM(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT))
			if(fatty.fatness >= preferences.helplessness_no_buckle)
				to_chat(fatty, "<span class='warning'>You feel like you've gotten too big to fit on anything.</span>")
				ADD_TRAIT(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)

		else if(fatty.fatness < preferences.helplessness_no_buckle)
			to_chat(fatty, "<span class='notice'>You feel thin enough to sit on things again. </span>")
			REMOVE_TRAIT(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)

	else
		if(HAS_TRAIT_FROM(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT))
			REMOVE_TRAIT(fatty, TRAIT_NO_BUCKLE, HELPLESSNESS_TRAIT)
*/

/datum/movespeed_modifier/fatness
	id = "fat"
	variable = TRUE

/mob/living/carbon
	var/list/fatness_delay_modifiers

/datum/fatness_delay_modifier
	var/name
	var/amount = 0
	var/multiplier = 1

/mob/living/carbon/proc/add_fat_delay_modifier(name = "", amount = 0, multiplier = 1)
	var/find_name = FALSE
	for(var/datum/fatness_delay_modifier/modifier in fatness_delay_modifiers)
		if(modifier.name == name && find_name == FALSE)
			modifier.amount = amount
			modifier.multiplier = multiplier
			find_name = TRUE
	if(find_name == FALSE)
		var/datum/fatness_delay_modifier/new_modifier = new()
		new_modifier.name = name
		new_modifier.amount = amount
		new_modifier.multiplier = multiplier
		LAZYADD(fatness_delay_modifiers, new_modifier)

/mob/living/carbon/proc/remove_fat_delay_modifier(name)
	for(var/datum/fatness_delay_modifier/modifier in fatness_delay_modifiers)
		if(modifier.name == name)
			LAZYREMOVE(fatness_delay_modifiers, modifier)

/mob/living/carbon/human/proc/apply_fatness_speed_modifiers(fatness_delay)
	var/mob/living/carbon/human/H = src
	var/delay_cap = FATNESS_MAX_MOVE_PENALTY
	if(HAS_TRAIT(H, TRAIT_WEAKLEGS))
		delay_cap = 60
	for(var/datum/fatness_delay_modifier/modifier in H.fatness_delay_modifiers)
		fatness_delay = fatness_delay + modifier.amount
	for(var/datum/fatness_delay_modifier/modifier in H.fatness_delay_modifiers)
		fatness_delay *= modifier.multiplier
	fatness_delay = max(fatness_delay, 0)
	fatness_delay = min(fatness_delay, delay_cap)
	return fatness_delay

/mob/living/carbon/human/proc/handle_fatness()
	// handle_modular_items()
	var/mob/living/carbon/human/H = src
	// update movement speed
	var/fatness_delay = 0
	if(H.fatness && !HAS_TRAIT(H, TRAIT_NO_FAT_SLOWDOWN))
		fatness_delay = (H.fatness / FATNESS_DIVISOR)
		fatness_delay = min(fatness_delay, FATNESS_MAX_MOVE_PENALTY)

		if(HAS_TRAIT(H, TRAIT_STRONGLEGS))
			fatness_delay = fatness_delay * FATNESS_STRONGLEGS_MODIFIER

		if(HAS_TRAIT(H, TRAIT_WEAKLEGS))
			if(H.fatness <= FATNESS_LEVEL_8)
				fatness_delay += fatness_delay * FATNESS_WEAKLEGS_MODIFIER / 100
			if(H.fatness > FATNESS_LEVEL_8)
				fatness_delay += (H.fatness / FATNESS_LEVEL_8) * FATNESS_WEAKLEGS_MODIFIER
				fatness_delay = min(fatness_delay, 60)

	if(fatness_delay)
		fatness_delay = apply_fatness_speed_modifiers(fatness_delay)
		H.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/fatness, TRUE, fatness_delay)
	else
		H.remove_movespeed_modifier(/datum/movespeed_modifier/fatness)

	if(HAS_TRAIT(H, TRAIT_FATNESS_19))
		handle_fatness_trait(
			TRAIT_FATNESS_19,
			TRAIT_FATNESS_18,
			null,
			FATNESS_LEVEL_19,
			INFINITY,
			"<span class='notice'>You feel like you've regained some mobility!</span>",
			null,
			20)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_18))
		handle_fatness_trait(
			TRAIT_FATNESS_18,
			TRAIT_FATNESS_17,
			TRAIT_FATNESS_19,
			FATNESS_LEVEL_18,
			FATNESS_LEVEL_19,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			19)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_17))
		handle_fatness_trait(
			TRAIT_FATNESS_17,
			TRAIT_FATNESS_16,
			TRAIT_FATNESS_18,
			FATNESS_LEVEL_17,
			FATNESS_LEVEL_18,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			18)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_16))
		handle_fatness_trait(
			TRAIT_FATNESS_16,
			TRAIT_FATNESS_15,
			TRAIT_FATNESS_17,
			FATNESS_LEVEL_16,
			FATNESS_LEVEL_17,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			17)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_15))
		handle_fatness_trait(
			TRAIT_FATNESS_15,
			TRAIT_FATNESS_14,
			TRAIT_FATNESS_16,
			FATNESS_LEVEL_15,
			FATNESS_LEVEL_16,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			16)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_14))
		handle_fatness_trait(
			TRAIT_FATNESS_14,
			TRAIT_FATNESS_13,
			TRAIT_FATNESS_15,
			FATNESS_LEVEL_14,
			FATNESS_LEVEL_15,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			15)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_13))
		handle_fatness_trait(
			TRAIT_FATNESS_13,
			TRAIT_FATNESS_12,
			TRAIT_FATNESS_14,
			FATNESS_LEVEL_13,
			FATNESS_LEVEL_14,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			14)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_12))
		handle_fatness_trait(
			TRAIT_FATNESS_12,
			TRAIT_FATNESS_11,
			TRAIT_FATNESS_13,
			FATNESS_LEVEL_12,
			FATNESS_LEVEL_13,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			13)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_11))
		handle_fatness_trait(
			TRAIT_FATNESS_11,
			TRAIT_FATNESS_10,
			TRAIT_FATNESS_12,
			FATNESS_LEVEL_11,
			FATNESS_LEVEL_12,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			12)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_10))
		handle_fatness_trait(
			TRAIT_FATNESS_10,
			TRAIT_FATNESS_9,
			TRAIT_FATNESS_11,
			FATNESS_LEVEL_10,
			FATNESS_LEVEL_11,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			11)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_9))
		handle_fatness_trait(
			TRAIT_FATNESS_9,
			TRAIT_FATNESS_8,
			TRAIT_FATNESS_10,
			FATNESS_LEVEL_9,
			FATNESS_LEVEL_10,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			10)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_8))
		handle_fatness_trait(
			TRAIT_FATNESS_8,
			TRAIT_FATNESS_7,
			TRAIT_FATNESS_9,
			FATNESS_LEVEL_8,
			FATNESS_LEVEL_9,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you've become a mountain of fat!</span>",
			9)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_7))
		handle_fatness_trait(
			TRAIT_FATNESS_7,
			TRAIT_FATNESS_6,
			TRAIT_FATNESS_8,
			FATNESS_LEVEL_7,
			FATNESS_LEVEL_8,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel your belly smush against the floor!</span>",
			8)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_6))
		handle_fatness_trait(
			TRAIT_FATNESS_6,
			TRAIT_FATNESS_5,
			TRAIT_FATNESS_7,
			FATNESS_LEVEL_6,
			FATNESS_LEVEL_7,
			"<span class='notice'>You feel less restrained by your fat!</span>",
			"<span class='danger'>You feel like you can barely move!</span>",
			7)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_5))
		handle_fatness_trait(
			TRAIT_FATNESS_5,
			TRAIT_FATNESS_4,
			TRAIT_FATNESS_6,
			FATNESS_LEVEL_5,
			FATNESS_LEVEL_6,
			"<span class='notice'>You feel a bit less fat!</span>",
			"<span class='danger'>You feel your belly rest heavily on your lap!</span>",
			6)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_4))
		handle_fatness_trait(
			TRAIT_FATNESS_4,
			TRAIT_FATNESS_3,
			TRAIT_FATNESS_5,
			FATNESS_LEVEL_4,
			FATNESS_LEVEL_5,
			"<span class='notice'>You feel like you've lost weight!</span>",
			"<span class='danger'>Your thighs begin to rub against each other.</span>",
			5)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_3))
		handle_fatness_trait(
			TRAIT_FATNESS_3,
			TRAIT_FATNESS_2,
			TRAIT_FATNESS_4,
			FATNESS_LEVEL_3,
			FATNESS_LEVEL_4,
			"<span class='notice'>You feel like you've lost weight!</span>",
			"<span class='danger'>You feel like you're starting to get really heavy.</span>",
			4)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_2))
		handle_fatness_trait(
			TRAIT_FATNESS_2,
			TRAIT_FATNESS_1,
			TRAIT_FATNESS_3,
			FATNESS_LEVEL_2,
			FATNESS_LEVEL_3,
			"<span class='notice'>You feel like you've lost weight!</span>",
			"<span class='danger'>Your clothes creak quietly!</span>",
			3)
		return
	if(HAS_TRAIT(H, TRAIT_FATNESS_1))
		handle_fatness_trait(
			TRAIT_FATNESS_1,
			null,
			TRAIT_FATNESS_2,
			FATNESS_LEVEL_1,
			FATNESS_LEVEL_2,
			"<span class='notice'>You feel fit again!</span>",
			"<span class='danger'>You feel even plumper!</span>",
			2)
	else
		handle_fatness_trait(
			null,
			null,
			TRAIT_FATNESS_1,
			0,
			FATNESS_LEVEL_1,
			null,
			"<span class='danger'>You suddenly feel blubbery!</span>",
			1)
