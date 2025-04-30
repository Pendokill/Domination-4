// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom initcommon.sqf"];

if (isNil "paramsArray") then {
	if (isClass (getMissionConfig "Params")) then {
		private _conf = getMissionConfig "Params";
		private ["_paramName", "_paramval", "_tidx"];
		for "_i" from 0 to (count _conf - 1) do {
			_paramName = configName (_conf select _i);
			_paramval = getNumber (_conf>>_paramName>>"default");
			if (_paramval != -66) then {
				missionNamespace setVariable [_paramName, _paramval];
#ifndef __SPE__
				_tidx = getArray (_conf>>_paramName>>"values") find _paramval;
				diag_log ["Mission parameter: ", getText (_conf>>_paramName>>"title"), _paramName, " Value: ", getArray (_conf>>_paramName>>"texts") # _tidx, " Index: ", _paramval];
#endif
			} else {
#ifndef __SPE__
				diag_log ["Mission parameter: ", getText (_conf>>_paramName>>"title")];
#endif
			};
		};
	};
} else {
	private _conf = getMissionConfig "Params";
	private ["_paramName", "_paramval", "_tidx"];
	for "_i" from 0 to (count paramsArray - 1) do {
		_paramName = configName (_conf select _i);
		_paramval = paramsArray select _i;
		if (_paramval != -66) then {
			missionNamespace setVariable [configName (_conf select _i), _paramval];
#ifndef __SPE__
			_tidx = getArray (_conf>>_paramName>>"values") find _paramval;
			diag_log ["Mission parameter: ", getText (_conf>>_paramName>>"title"), _paramName, " Value: ", getArray (_conf>>_paramName>>"texts") # _tidx, " Index: ", _paramval];
#endif
		} else {
#ifndef __SPE__
			diag_log ["Mission parameter: ", getText (_conf>>_paramName>>"title")];
#endif
		};
	};
};

d_no_ranked_weapons = d_with_ranked == 2;
d_with_ranked = d_with_ranked == 0 || {d_with_ranked == 2};
#ifndef __TT__
d_ai_no_statics = d_with_ai == 2 || {d_with_ai == 4};
d_ai_dyn_recruit = d_with_ai == 3 || {d_with_ai == 4};
d_with_ai = d_with_ai == 0 || {d_with_ai > 1};
#else
d_with_ai = false;
d_with_ai_features = 1;
d_WithJumpFlags = 1;
d_MaxNumAmmoboxes = d_MaxNumAmmoboxes * 2;
d_pilots_only = 1;
#endif
d_no_ai = !d_with_ai && {d_with_ai_features == 1};
d_enemy_mode_current_maintarget = nil; // nil unless d_WithLessArmor is set to random

if (d_with_ace && {d_ACEMedicalR == 1}) then {
	d_WithRevive = 1;
	ace_medical_enableRevive = 1;
	ace_medical_maxReviveTime = 300;
	ace_medical_amountOfReviveLives = -1;
};

if (d_WithRevive == 0 && {hasInterface}) then {
	xr_pl_can_revive = true;
	xr_uncon_units = [];
};

if (d_sub_kill_points != 0 && {d_sub_kill_points > 0}) then {
	d_sub_kill_points = d_sub_kill_points * -1;
};

if (d_with_ace) then {
	d_pylon_lodout = 1;
};

#ifdef __TT__
if (isNil "d_tt_points") then {
	d_tt_points = [
		35, // очков для основной цели команды-победителя
		7, // очков в случае ничьей (основная цель)
		15, // очки за уничтожение основной целевой радиовышки
		5, // баллов за основную целевую миссию
		15, // баллы за допмиссию
		5, // очков за захват казармы (основная цель)
		10, // очков, которые вычитаются при повторной потере блокпоста mt
		4, // очки за уничтожение транспортного средства другой команды
		2 // очки за убийство члена другой команды
	];
};
#endif

if (isNil "d_cas_available_time") then {
	d_cas_available_time = 600; // time till CAS is available again!
};

if (isNil "d_cas_available_time_low") then {
	d_cas_available_time_low = 100; // time CAS low cooldown setting
};

if (isServer) then {
	skipTime d_TimeOfDay;

#ifdef __UNSUNG__
	d_WithLessArmor = 1;
	d_WithLessArmor_side = 1;
#endif
#ifdef __VN__
	d_WithLessArmor = 1;
	d_WithLessArmor_side = 1;
#endif

	// set enemy mode
	d_WithLessArmor call d_fnc_setenemymode;

	// enemy ai skill: [base skill, random value (random 0.3) that gets added to the base skill]
	d_skill_array = [[0.1,0.05], [0.2,0.1], [0.4,0.2], [0.6,0.3], [0.65,0.3]] select d_EnemySkill;
	
	if (isNil "d_addscore_a") then {
		d_addscore_a = [
			5, // 1 - здание казармы разрушено на основной цели
			5, // 2 - здание мобильного штаба уничтожено на основной цели
			15, // 3 - радиовышка уничтожена у основной цели
			5, // 4 - игрок взял блокпост
			5, // 5 - игрок выполнил основную целевую миссию
			30, // 6 - дополнительные очки при захвате основной цели
			3, // 7 - очки за оживление другого игрока
			10, // 8 - баллы за помощь в решении допмиссии
			[3,2,1,0], // 9 - баллы за ремонт/заправку транспортного средства
			3, // 10 - очки за исцеление другого юнита
			5, // 11 - очки за исцеление другого игрока в Госпитале
			2, // 12 - очки для другого игрока, появляющегося у лидера отряда
			2, // 13 - очки за перевозку другого игрока в транспортном средстве
			50 // 14 - очки за доставку уничтоженной техники на точку ремонта
		];
	};
};

if (isNil "d_ranked_a") then {
	d_ranked_a = [
		20, // очки, которые инженер должен иметь для ремонта/заправки транспортного средства
		[3,2,1,0], // баллы инженеры получают за ремонт воздушного судна, танка, автомобиля, другого
		25, // очков, необходимых артиллеристу для нанесения удара
		30, // очки в AI версии за вербовку одного солдата
		20, // очков, необходимых игроку для десантирования
		25, // баллы, которые вычитаются за создание транспортного средства в КШМ
		25, // баллов, необходимых для создания транспортного средства в КШМ
		10, // баллы, которые получает медик, если кто-то лечится у него в Госпитале
		["Corporal","Sergeant","Lieutenant","Lieutenant","Sergeant","Corporal"], // Звания, необходимые для управления различными транспортными средствами, начиная с: колесного бтр, типов танка, типов вертолета (за исключением начальных 4), Plane, Ships/Boats, StaticWeapon
		30, // очков, которые добавляются, если игрок находится на расстоянии xxx м от основной цели, когда она зачищена
		350, // дальность действия, в которой должен находиться игрок, чтобы получить дополнительные очки основной цели
		10, // очки, которые добавляются, если игрок находится на расстоянии xxx м от зоны допзадания, когда допка выполнена
		150, // дальность действия, в которой должен находиться игрок, чтобы получить дополнительные очки с допзадания
		20, // очков, необходимых инженеру для восстановления служебных зданий на базе
		10, // больше не используется !!! Были нужны очки, чтобы построить гнездо MG раньше
		10, // баллов, необходимых в AI ранге для вызова Эвакуатора
		100, // очков, необходимых для вызова воздушного сброса
		5, // очки, которые получает медик, когда он лечит других бойцов
		2, // очки, которые игрок получает при транспортировке других
		20, // очки, необходимые для активации спутникового наблюдения
		20, // очков, необходимых для создания ПРП (FARP) (инженер)
		3, // очков игрок получает за оживление другого игрока
		25, // очков, необходимых командиру отряда для Авиаудара (CAS)
		50, // очков игрок получает за то, что доставляет обломки техники к месту ремонта
		30 // очки, необходимые игроку для боевого беспилотника UAV
	];
} else {
	if (count d_ranked_a < 25) then {
		if (count d_ranked_a == 22) then {
			d_ranked_a append [20, 20, 30];
		};
		if (count d_ranked_a == 23) then {
			d_ranked_a append [20, 30];
		};
		if (count d_ranked_a == 24) then {
			d_ranked_a append [30];
		};
	};
};

if (isServer) then {
	d_sc_hash = createHashMapFromArray [
		[0, (d_ranked_a # 3) * -1],
		[1, (d_ranked_a # 2) * -1],
		[2, (d_ranked_a # 15) * -1],
		[3, (d_ranked_a # 5) * -1],
		[4, (d_ranked_a # 16) * -1],
		[5, d_ranked_a # 17],
		[6, (d_ranked_a # 19) * -1],
		[7, d_ranked_a # 17],
		[8, (d_ranked_a # 4) * -1],
		[9, (d_ranked_a # 19) * -1],
		[10, (d_ranked_a # 20) * -1],
		[11, (d_ranked_a # 24) * -1]
	];
};

// chopper varname, type (0 = lift chopper, 1 = wreck lift chopper, 2 = normal chopper), marker name, unique number (same as in d_init.sqf), marker type, marker color, marker text, chopper string name
#ifndef __TT__
d_choppers = [
	["D_HR1",0,"d_chopper1",3001,"o_air","ColorWhite","Буксир", localize "STR_DOM_MISSIONSTRING_7"], ["D_HR2",2,"d_chopper2",3002,"o_air","ColorWhite","2",""],
	["D_HR3",2,"d_chopper3",3003,"o_air","ColorWhite","3",""], ["D_HR4",1,"d_chopper4",3004,"o_air","ColorWhite","Ремка", localize "STR_DOM_MISSIONSTRING_10"],
	["D_HR5",2,"d_chopper5",3005,"o_air","ColorWhite","5",""], ["D_HR6",2,"d_chopper6",3006,"o_air","ColorWhite","6",""]
];
#else
d_choppers_blufor = [
	["D_HR1",0,"d_chopper1",3001,"n_air","ColorWhite","1", localize "STR_DOM_MISSIONSTRING_7"], ["D_HR2",2,"d_chopper2",3002,"n_air","ColorWhite","2",""],
	["D_HR3",2,"d_chopper3",3003,"n_air","ColorWhite","3",""], ["D_HR4",1,"d_chopper4",3004,"n_air","ColorWhite","W", localize "STR_DOM_MISSIONSTRING_10"],
	["D_HR5",2,"d_chopper5",3005,"n_air","ColorWhite","5",""], ["D_HR6",2,"d_chopper6",3006,"n_air","ColorWhite","6",""]
];
d_choppers_opfor = [
	["D_HRO1",0,"d_choppero1",4001,"o_air","ColorWhite","Буксир", localize "STR_DOM_MISSIONSTRING_7"], ["D_HRO2",2,"d_choppero2",4002,"o_air","ColorWhite","2",""],
	["D_HRO3",2,"d_choppero3",4003,"o_air","ColorWhite","3",""], ["D_HRO4",1,"d_choppero4",4004,"o_air","ColorWhite","Ремка", localize "STR_DOM_MISSIONSTRING_10"],
	["D_HRO5",2,"d_choppero5",4005,"o_air","ColorWhite","5",""], ["D_HRO6",2,"d_choppero6",4006,"o_air","ColorWhite","6",""]
];
#endif

// vehicle varname, unique number (same as in d_init.sqf), marker name, marker type, marker color, marker text, vehicle string name
#ifndef __TT__
d_p_vecs = [
	["D_MRR1",0,"d_mobilerespawn1","b_hq","ColorYellow","1",localize "STR_DOM_MISSIONSTRING_12"],["D_MRR2",1,"d_mobilerespawn2","b_hq","ColorYellow","2",localize "STR_DOM_MISSIONSTRING_13"],
	["D_MEDVEC",100,"d_medvec","n_med","ColorGreen","M",""],["D_TR1",200,"d_truck1","n_maint","ColorGreen","Рем 1",""],
	["D_TR2",201,"d_truck2","n_antiair","ColorCIV","ЗУ",""],["D_TR3",202,"d_truck3","n_support","ColorGreen","БК 1",""],
	["D_TR6",203,"d_truck4","n_maint","ColorGreen","Рем 2",""],["D_TR5",204,"d_truck5","n_support","ColorGreen","ГСМ",""],
	["D_TR4",205,"d_truck6","n_support","ColorGreen","БК 2",""],["D_TR7",300,"d_truck7","n_service","ColorOrange","Ин 1",""],
	["D_TR8",301,"d_truck8","n_service","ColorOrange","Ин 2",""],["D_TR9",400,"d_truck9","n_support","ColorEAST","T2",""],
	["D_TR10",401,"d_truck10","n_support","ColorEAST","T1",""]
];
if (d_ifa3 || {d_spe}) then {
	d_p_vecs pushBack ["D_TR11",500,"d_truck11","n_support","ColorGreen","W1",""];
};
if (d_gmcwg) then {
	d_p_vecs append [
		["D_TR11",500,"d_truck11","n_support","ColorGreen","W1",""],
		["D_TR12",501,"d_truck11","n_support","ColorGreen","W2",""],
		["D_TR13",502,"d_truck12","n_support","ColorGreen","W3",""],
		["D_TR14",503,"d_truck13","n_support","ColorGreen","W4",""],
		["D_TR15",504,"d_truck14","n_support","ColorGreen","W5",""],
		["D_TR16",505,"d_truck15","n_support","ColorGreen","W6",""],
		["D_TR17",506,"d_truck16","n_support","ColorGreen","W7",""]
	];
};
#else
d_p_vecs_blufor = [
	["D_MRR1",0,"d_mobilerespawn1","b_hq","ColorYellow","1",localize "STR_DOM_MISSIONSTRING_12"],["D_MRR2",1,"d_mobilerespawn2","b_hq","ColorYellow","2",localize "STR_DOM_MISSIONSTRING_13"],
	["D_MEDVEC",100,"d_medvec","n_med","ColorGreen","M",""],["D_TR1",200,"d_truck1","n_maint","ColorGreen","R1",""],
	["D_TR2",201,"d_truck2","n_support","ColorGreen","F1",""],["D_TR3",202,"d_truck3","n_support","ColorGreen","A1",""],
	["D_TR6",203,"d_truck4","n_maint","ColorGreen","R2",""],["D_TR5",204,"d_truck5","n_support","ColorGreen","F2",""],
	["D_TR4",205,"d_truck6","n_support","ColorGreen","A2",""],["D_TR7",300,"d_truck7","n_service","ColorGreen","E1",""],
	["D_TR8",301,"d_truck8","n_service","ColorGreen","E2",""],["D_TR9",400,"d_truck9","n_support","ColorGreen","T2",""],
	["D_TR10",401,"d_truck10","n_support","ColorGreen","T1",""]
];
d_p_vecs_opfor = [
	["D_MRRO1",1000,"d_mobilerespawno1","o_hq","ColorYellow","1",localize "STR_DOM_MISSIONSTRING_12"],["D_MRRO2",1001,"d_mobilerespawno2","o_hq","ColorYellow","2",localize "STR_DOM_MISSIONSTRING_13"],
	["D_MEDVECO",1100,"d_medveco","n_med","ColorGreen","M",""],["D_TRO1",1200,"d_trucko1","n_maint","ColorGreen","Рем 1",""],
	["D_TRO2",1201,"d_trucko2","n_antiair","ColorCIV","РСЗО",""],["D_TRO3",1202,"d_trucko3","n_support","ColorGreen","БК 1",""],
	["D_TRO6",1203,"d_trucko4","n_maint","ColorGreen","Рем 2",""],["D_TRO5",1204,"d_trucko5","n_support","ColorGreen","ГСМ",""],
	["D_TRO4",1205,"d_trucko6","n_support","ColorGreen","БК 2",""],["D_TRO7",1300,"d_trucko7","n_service","ColorOrange","Ин 1",""],
	["D_TRO8",1301,"d_trucko8","n_service","ColorOrange","Ин 2",""],["D_TRO9",1400,"d_trucko9","n_support","ColorEAST","T2",""],
	["D_TRO10",1401,"d_trucko10","n_support","ColorEAST","T1",""]
];
#endif


if (hasInterface) then {
	if (d_weather == 1) then {
		0 setOvercast 0;
	};
	
	if (d_with_ai) then {d_current_ai_num = 0};

	// расстояние, на которое игрок должен транспортировать других, чтобы получить очки
	d_transport_distance = 500;

	// ранг, необходимый для управления вертолетом для подъема обломков
	d_wreck_lift_rank = "CORPORAL";

	d_disable_viewdistance = d_ViewdistanceChange == 1;
	
	d_mob_respawns = [];
#ifndef __TT__
	{
		d_mob_respawns pushBack [_x # 0, _x # 6];
	} forEach (d_p_vecs select {_x # 1 < 100});
#else
	d_mob_respawns_blufor = [];
	{
		d_mob_respawns_blufor pushBack [_x # 0, _x # 6];
	} forEach (d_p_vecs_blufor select {_x # 1 < 100});
	d_mob_respawns_opfor = [];
	{
		d_mob_respawns_opfor pushBack [_x # 0, _x # 6];
	} forEach (d_p_vecs_opfor select {_x # 1 < 1100});
#endif

	if (d_with_ai) then {
		// additional AI recruit buildings
		// these have to be placed in the editor, give them a var name in the editor
		// only client handling means, no damage handling done for those buildings (contrary to the standard AI hut)
		// example:
		// d_additional_recruit_buildings = [my_ai_building1, my_ai_building2];
		d_additional_recruit_buildings = [];
	};
	
	// d_reserved_slot дает вам возможность добавлять зарезервированные слоты для администраторов, 
        // если вы не войдете в систему после выбора слота, вас выгонят через ~ 20 секунд после завершения ввода, 
        // по умолчанию флажок отсутствует, например: d_reserved_slot = ["d_artop_1"];
	if (isNil "d_reserved_slot") then {
		d_reserved_slot = [];
	};

	// d_uid_reserved_slots and d_uids_for_reserved_slots gives you the possibility to limit a slot
	// you have to add the var names of the units to d_uid_reserved_slots and in d_uids_for_reserved_slots the UIDs of valid players
	// d_uid_reserved_slots = ["d_alpha_1", "d_bravo_3"];
	// d_uids_for_reserved_slots = ["1234567", "7654321"];
	if (isNil "d_uid_reserved_slots") then {
		d_uid_reserved_slots = [];
		d_uids_for_reserved_slots = [];
	};
	
	if (isNil "d_uids_def_choppers") then {
		// Если d_uids_initial_vecs заполнен идентификаторами игроков в виде строк, UID игроков, которых нет в массиве, 
		// будут удалены из изначально размещенных разделителей и MHQ на базе
		// d_uids_initial_vecs = ["1234567", "7654321"];
		d_uids_def_choppers = [];
	};
	
	// очки, необходимые для получения определенного ранга
        // даже используются в версиях без рангов
#ifndef __TT__
	if (isNil "d_points_needed") then {
		d_points_needed = [
			20, // Corporal
			50, // Sergeant
			100, // Lieutenant
			200, // Captain
			350, // Major
			500, // Colonel
			1000 // General
		];
	};

	if (isNil "d_points_needed_db") then {
		d_points_needed_db = [
			500, // Corporal
			2000, // Sergeant
			5000, // Lieutenant
			9000, // Captain
			14000, // Major
			30000, // Colonel
			50000 // General
		];
	};
#else
	if (isNil "d_points_needed") then {
		d_points_needed = [
			100, // Corporal
			400, // Sergeant
			800, // Lieutenant
			1600, // Captain
			3000, // Major
			5000, // Colonel
			8000 // General
		];
	};

	if (isNil "d_points_needed_db") then {
		d_points_needed_db = [
			500, // Corporal
			2000, // Sergeant
			5000, // Lieutenant
			9000, // Captain
			14000, // Major
			30000, // Colonel
			50000 // General
		];
	};
#endif
	// array now so players can select different air taxi types
	if (d_with_airtaxi == 0) then {
		d_taxi_aircrafts =
#ifdef __OWN_SIDE_INDEPENDENT__
			call {
				if (d_pracs) exitWith {
					["PRACS_UH1H","PRACS_CH53","PRACS_Sa330_Puma"]
				};
				if (d_spe) exitWith {
					[]
				};
				["I_Heli_Transport_02_F"]
			};
#endif
#ifdef __OWN_SIDE_BLUFOR__
			call {
				if (d_cup) exitWith {
					["CUP_B_UH60M_US", "CUP_B_MH6J_USA", "CUP_B_CH47F_USA"]
				};
				if (d_gmcwg) exitWith {
					if (d_gmcwgwinter) exitWith {
						["gm_ge_army_ch53g_un"]
					};
					["gm_ge_army_ch53g"]
				};
				if (d_rhs) exitWith {
					["RHS_UH60M2"]
				};
				if (d_unsung) exitWith {
					["uns_UH1H_m60"]
				};
				if (d_vn) exitWith {
					["vn_b_air_uh1c_07_04"]
				};
				if (d_spe) exitWith {
					[]
				};
				["B_T_VTOL_01_infantry_F", "B_Heli_Transport_03_unarmed_F", "B_Heli_Light_01_F", "B_Heli_Transport_01_F"]
			};
#endif
#ifdef __OWN_SIDE_OPFOR__
			call {
				if (d_rhs) exitWith {
					["rhsgref_un_Mi24V", "RHS_MELB_MH6M"]
				};
				if (d_csla) exitWith {
					["CSLA_Mi17"]
				};
				if (d_pracs) exitWith {
					["PRACS_SLA_Mi8amt"]
				};
				["O_T_VTOL_02_infantry_dynamicLoadout_F"]
			};
#endif
#ifdef __TT__
			["O_Heli_Light_02_unarmed_F"];
#endif
	} else {
		d_taxi_aircrafts = [];
	};

	if (isNil "d_launcher_cooldown") then {
		// player AT launcher cooldown time, means, a player can't use a guided launcher like the Titan for 60
		// The projectile gets deleted and a magazine added again to the player inventory
		// can be changed in the database dom_settings table too
		d_launcher_cooldown = d_launcher_cooldownp;
	};
	
	if (d_no_mortar_ar == 1) then {
		(d_remove_from_arsenal # 5) append [{_this isKindOf "Weapon_Bag_Base" || {_this isKindOf "B_Mortar_01_support_F"}}];
	};
};

diag_log [diag_frameno, diag_ticktime, time, "Dom initcommon.sqf processed"];
