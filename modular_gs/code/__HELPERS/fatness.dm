/// WORLD GENESIS - WEIGHT SELECTION EDIT Prompts the user to choose a weight and returns said weight.
/proc/chose_weight(input_text = "Choose a weight.", mob/user)
	var/chosen_weight = FALSE
	var/picked_weight_class = input(user,
		input_text,
		"Character Preference", "None") as null|anything in list(
			"None", "Pudgy", "Paunchy", "Plump", "Slightly Chubby", "Chubby", "Extremely Chubby", "Slightly Overweight", "Overweight", "Extremely Overweight", "Obese", "Extremely Obese", "Morbidly Obese", "Fatty Blob", "Large Fatty Blob", "Super Fatty Blob", "Mega Fatty Blob", "Ultra Fatty Blob", "Nearly Immobile Lardass", "Immobile Lardass", "Other")

	switch(picked_weight_class)
		if("Pudgy")
			chosen_weight = FATNESS_LEVEL_1
		if("Paunchy")
			chosen_weight = FATNESS_LEVEL_2
		if("Plump")
			chosen_weight = FATNESS_LEVEL_3
		if("Slightly Chubby")
			chosen_weight = FATNESS_LEVEL_4
		if("Chubby")
			chosen_weight = FATNESS_LEVEL_5
		if("Extremely Chubby")
			chosen_weight = FATNESS_LEVEL_6
		if("Slightly Overweight")
			chosen_weight = FATNESS_LEVEL_7
		if("Overweight")
			chosen_weight = FATNESS_LEVEL_8
		if("Extremely Overweight")
			chosen_weight = FATNESS_LEVEL_9
		if("Obese")
			chosen_weight = FATNESS_LEVEL_10
		if("Extremely Obese")
			chosen_weight = FATNESS_LEVEL_11
		if("Morbidly Obese")
			chosen_weight = FATNESS_LEVEL_12
		if("Fatty Blob")
			chosen_weight = FATNESS_LEVEL_13
		if("Large Fatty Blob")
			chosen_weight = FATNESS_LEVEL_14
		if("Super Fatty Blob")
			chosen_weight = FATNESS_LEVEL_15
		if("Mega Fatty Blob")
			chosen_weight = FATNESS_LEVEL_16
		if("Ultra Fatty Blob")
			chosen_weight = FATNESS_LEVEL_17
		if("Nearly Immobile Lardass")
			chosen_weight = FATNESS_LEVEL_18
		if("Immobile Lardass")
			chosen_weight = FATNESS_LEVEL_19

	if(picked_weight_class != "Other")
		return chosen_weight

	var/custom_fatness = input(user, "What fatness level (BFI) would you like to use?", "Character Preference")  as null|num
	if(isnull(custom_fatness))
		custom_fatness = FALSE

	return custom_fatness
