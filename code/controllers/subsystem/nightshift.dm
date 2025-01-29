GLOBAL_LIST_EMPTY(TodUpdate)

SUBSYSTEM_DEF(nightshift)
	name = "Night Shift"
	wait = 10 SECONDS
	flags = SS_NO_TICK_CHECK
	priority = 1
	var/current_tod = null

	var/nightshift_active = FALSE
	var/nightshift_start_time = 576000	//4pm	//702000=7:30 PM, station time
	var/nightshift_end_time = 360000	//10am	//270000=7:30 AM, station time
	var/nightshift_dawn_start = 288000		//198000=530am
	var/nightshift_day_start = 360000		//270000=730am
	var/nightshift_dusk_start = 504000		//630000=530pm

	//1hr = 36000
	//30m = 18000

	var/nightshift_first_check = 2 SECONDS

	var/high_security_mode = FALSE

proc/is_nighttime()
	if(GLOB.tod == "night")  
		return TRUE
	return FALSE

/mob/living/carbon
	var/next_sleep_time = 0
	var/first_sleep = 432000
	var/sleep_interval = 864000

/datum/controller/subsystem/personal_sleep
	name = "Personal Sleep"
	wait = 10 SECONDS

/proc/check_personal_sleep()
	var/day_length = 864000
	for(var/mob/living/carbon/M in GLOB.mob_list)
		if(M)
			if(M.next_sleep_time == 0)
				M.next_sleep_time = (station_time() + M.first_sleep) % day_length
			else
				if(!HAS_TRAIT(M, TRAIT_NOSLEEP) && !HAS_TRAIT(M, TRAIT_NOSTAMINA))
					if(station_time() >= M.next_sleep_time)
						if(!(HAS_TRAIT(M, TRAIT_NIGHT_OWL) && is_nighttime()))
							M.ForceSleepyTime()
							M.next_sleep_time = (station_time() + M.sleep_interval) % day_length
						else
							M.next_sleep_time = (station_time() + 36000) % day_length


/datum/controller/subsystem/personal_sleep/fire(resumed = FALSE)
	check_personal_sleep()

/mob/living/carbon/proc/ForceSleepyTime()
	apply_status_effect(/datum/status_effect/debuff/sleepytime)
	add_stress(/datum/stressevent/sleepytime)

/datum/controller/subsystem/nightshift/Initialize()
	if(!CONFIG_GET(flag/enable_night_shifts))
		can_fire = FALSE
	current_tod = settod()
	return ..()

/datum/controller/subsystem/nightshift/fire(resumed = FALSE)
	if(world.time - SSticker.round_start_time < nightshift_first_check)
		return
	check_nightshift()

/datum/controller/subsystem/nightshift/proc/announce(message)
	priority_announce(message, sound='sound/misc/bell.ogg', sender_override="Automated Lighting System Announcement")

/datum/controller/subsystem/nightshift/proc/check_nightshift()
//	var/emergency = GLOB.security_level >= SEC_LEVEL_RED
//	var/announcing = FALSE
//	var/time = station_time()
/*	var/night_time = (time < nightshift_day_start) || (time > nightshift_dusk_start) || (settod() in list("night", "dawn", "dusk"))
	if(high_security_mode != emergency)
		high_security_mode = emergency
		if(night_time)
			announcing = FALSE
			if(!emergency)
				announce("Restoring night lighting configuration to normal operation.")
			else
				announce("Disabling night lighting: Station is in a state of emergency.")
	if(emergency)
		night_time = FALSE
	if(nightshift_active != night_time)
		update_nightshift(night_time, announcing)*/
	var/curtod = settod()
	if(current_tod != curtod)
		testing("curtod [curtod] current_tod [current_tod] globtod [GLOB.tod]")
		current_tod = GLOB.tod
		update_nightshift()

/datum/controller/subsystem/nightshift/proc/update_nightshift()
	set waitfor = FALSE
	for(var/obj/A in GLOB.TodUpdate)
		A.update_tod(GLOB.tod)
	for(var/mob/living/M in GLOB.mob_list)
		M.update_tod(GLOB.tod)

/obj/proc/update_tod(todd)
	return

/mob/living/proc/update_tod(todd)
	return

/mob/living/carbon/human/update_tod(todd)

	if(client)
		var/area/areal = get_area(src)
		if(!cmode)
			SSdroning.play_area_sound(areal, src.client)
		SSdroning.play_loop(areal, src.client)
	if(todd == "day")
		if(HAS_TRAIT(src, TRAIT_DARKLING) && !HAS_TRAIT(src, TRAIT_NOSTAMINA) && !HAS_TRAIT(src, TRAIT_NOSLEEP))
			apply_status_effect(/datum/status_effect/debuff/sleepytime)
			add_stress(/datum/stressevent/sleepytime)
	if(todd == "dawn")
		try_grow_beard()
		if(HAS_TRAIT(src, TRAIT_VAMP_DREAMS))
			apply_status_effect(/datum/status_effect/debuff/vamp_dreams)
		if(HAS_TRAIT(src, TRAIT_DARKLING) && !HAS_TRAIT(src, TRAIT_NOSTAMINA) && !HAS_TRAIT(src, TRAIT_NOSLEEP))
			add_stress(/datum/stressevent/sleepytime)

	if(todd == "night")
		if(HAS_TRAIT(src, TRAIT_DARKLING))
			return ..()
		if(HAS_TRAIT(src, TRAIT_NOSTAMINA))
			return ..()
		if(HAS_TRAIT(src, TRAIT_NOSLEEP))
			return ..()
		if(HAS_TRAIT(src, TRAIT_NIGHT_OWL))
			add_stress(/datum/stressevent/night_owl)
