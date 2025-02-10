/datum/job/roguetown/councillor
	title = "Councillor"
	flag = COUNCILLOR
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_ages = ALL_AGES_LIST
	allowed_races = RACES_TOLERATED_UP
	display_order = JDO_COUNCILLOR
	tutorial = "It wasn't easy to climb this far, even as an aristocrat. \
				Whether through influence, guile or manipulation, you manuevered your way here. \
				An influential Lord holding the esteemed position of Councillor in the Duke's Court. A position you've successfully held for many years. \
				You are the Hand's Assistant, it's your responsibility to assist them with their goals, for better or worse. \
				After all, you wouldn't have come this far without them... They trust you. But it's easy to fall, no matter how high your seat. \
				Without the Hand's Authority, you lack their influence within the Keep. Ensure none look down upon you, your position is one worthy of respect. \
				After all... If one man is allowed to get away with disrespecting you... They all will..."
	whitelist_req = FALSE
	outfit = /datum/outfit/job/roguetown/councillor
	
	give_bank_account = 40
	min_pq = 6
	max_pq = null

/datum/outfit/job/roguetown/councillor/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/councillor
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/tights/black
	shoes = /obj/item/clothing/shoes/roguetown/armor
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/keyring/councillor
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 1)
		H.change_stat("fortune", 1)
	
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	H.verbs |= list(/mob/living/carbon/human/proc/request_outlaw)
