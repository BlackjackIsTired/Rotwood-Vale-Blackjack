/datum/job/roguetown/squire
	title = "Squire"
	flag = SQUIRE
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = RACES_SHUNNED_UP
	allowed_ages = list(AGE_ADULT)

	tutorial = "Your Knight, they saw something in you. Whatever it was, they chose you to become their Squire. It's not an opportunity that comes by every day. \
				The potential for elevation, nobility, knighthood... Responsibility... Grow into something worthy of the effort they've been putting in on you all these many years. \
				For when they perish, their blade and position will pass to you as their chosen successor. They trust you. Believe in you. You cannot fail now."

	outfit = /datum/outfit/job/roguetown/squire
	display_order = JDO_SQUIRE
	give_bank_account = TRUE
	min_pq = -5 //squires aren't great but they can do some damage
	max_pq = null

/datum/outfit/job/roguetown/squire/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 1)
		H.change_stat("constitution", 1)
		H.change_stat("speed", 1)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail
		shoes = /obj/item/clothing/shoes/roguetown/armor
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/keyring/servant
		beltr = /obj/item/rogueweapon/sword/short
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		backr = /obj/item/storage/backpack/rogue/satchel
	else
		pants = /obj/item/clothing/under/roguetown/tights
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guard
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail
		shoes = /obj/item/clothing/shoes/roguetown/armor
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/keyring/servant
		beltr = /obj/item/rogueweapon/sword/short
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		backr = /obj/item/storage/backpack/rogue/satchel
