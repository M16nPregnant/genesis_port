/// Handles weight gain from digesting food/stomach contents
/obj/item/organ/stomach/proc/handle_weight_gain(mob/living/carbon/human/fatty)
	fatty.handle_fatness()
	fatty.handle_helplessness()
	fatty.handle_modular_items()

	/* Do this later.
	switch(fatty.fullness)
		if(0 to FULLNESS_LEVEL_BLOATED)
			fatty.clear_alert("fullness")
		if(FULLNESS_LEVEL_BLOATED to FULLNESS_LEVEL_BEEG)
			fatty.throw_alert("fullness", /atom/movable/screen/alert/gs13/bloated)
		if(FULLNESS_LEVEL_BEEG to FULLNESS_LEVEL_NOMOREPLZ)
			fatty.throw_alert("fullness", /atom/movable/screen/alert/gs13/stuffed)
		if(FULLNESS_LEVEL_NOMOREPLZ to INFINITY)
			fatty.throw_alert("fullness", /atom/movable/screen/alert/gs13/beegbelly)


	var/obj/item/organ/genital/external/belly/B = fatty.getorganslot("belly")
	if(!isnull(B) && istype(B))
		B.update()
	*/

	//WORLD GENESIS EDIT - FATNESS ALERTS
	switch(fatty.fatness)
		if(FATNESS_LEVEL_19 to INFINITY)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_19)

		if(FATNESS_LEVEL_18 to FATNESS_LEVEL_19)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_18)

		if(FATNESS_LEVEL_17 to FATNESS_LEVEL_18)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_17)

		if(FATNESS_LEVEL_16 to FATNESS_LEVEL_17)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_16)

		if(FATNESS_LEVEL_15 to FATNESS_LEVEL_16)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_15)

		if(FATNESS_LEVEL_14 to FATNESS_LEVEL_15)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_14)

		if(FATNESS_LEVEL_13 to FATNESS_LEVEL_14)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_13)

		if(FATNESS_LEVEL_12 to FATNESS_LEVEL_13)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_12)

		if(FATNESS_LEVEL_11 to FATNESS_LEVEL_12)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_11)

		if(FATNESS_LEVEL_10 to FATNESS_LEVEL_11)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_10)

		if(FATNESS_LEVEL_9 to FATNESS_LEVEL_10)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_9)

		if(FATNESS_LEVEL_8 to FATNESS_LEVEL_9)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_8)

		if(FATNESS_LEVEL_7 to FATNESS_LEVEL_8)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_7)

		if(FATNESS_LEVEL_6 to FATNESS_LEVEL_7)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_6)

		if(FATNESS_LEVEL_5 to FATNESS_LEVEL_6)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_5)

		if(FATNESS_LEVEL_4 to FATNESS_LEVEL_5)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_4)

		if(FATNESS_LEVEL_3 to FATNESS_LEVEL_4)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_3)

		if(FATNESS_LEVEL_2 to FATNESS_LEVEL_3)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_2)

		if(FATNESS_LEVEL_1 to FATNESS_LEVEL_2)
			fatty.throw_alert("fatness", /atom/movable/screen/alert/gs13/fatness_1)

		if(0 to FATNESS_LEVEL_1)
			fatty.clear_alert("fatness")
