d_sm_fortress = "Land_Cargo_House_V2_F";
d_functionary = "C_Djella_03_lxWS";
d_fuel_station = "Land_FuelStation_Build_F";//Land_FuelStation_Shed_F
d_sm_cargo = switch (d_enemy_side_short) do {
	case "E": {"O_SFIA_Truck_02_box_lxWS"};
	case "W": {"B_Truck_01_box_F"};
	case "G": {"I_Truck_02_box_F"};
};
//d_sm_hangar = "Land_TentHangar_V1_F"; // Land_TentHangar_V1_F creates 3 objects and adding a killed eh makes it useless as the correct object might never get destroyed
d_sm_hangar = "Land_Hangar_F";
d_sm_tent = "Land_TentA_F";

d_sm_land_tankbig = "Land_dp_bigTank_F";
d_sm_land_transformer = "Land_dp_transformer_F";
d_sm_barracks = "Land_i_Barracks_V2_F";
d_sm_land_tanksmall = "Land_dp_smallTank_F";
d_sm_land_factory = "Land_u_Barracks_V2_F";
d_sm_small_radar = "Land_Radar_Small_F";

d_soldier_officer = switch (d_enemy_side_short) do {
	case "E": {"O_SFIA_officer_lxWS"};
	case "W": {"B_Officer_Parade_Veteran_F"};
	case "G": {"I_Officer_Parade_Veteran_F"};
};
d_sniper = switch (d_enemy_side_short) do {
	case "E": {"O_SFIA_sharpshooter_lxWS"};
	case "W": {"B_sniper_F"};
	case "G": {"I_sniper_F"};
};
d_sm_arty = switch (d_enemy_side_short) do {
	case "E": {"O_SFIA_Truck_02_MRL_lxWS"};
	case "W": {"B_MBT_01_arty_F"};
	case "G": {"B_MBT_01_arty_F"}; // no independent arty in Alpha 3
};
d_sm_plane = switch (d_enemy_side_short) do {
	case "E": {"O_Plane_CAS_02_F"};
	case "W": {"B_Plane_CAS_01_F"};
	case "G": {"I_Plane_Fighter_03_CAS_F"};
};
d_sm_tank = switch (d_enemy_side_short) do {
	case "E": {"O_SFIA_MBT_02_cannon_lxWS"};
	case "W": {"B_MBT_01_cannon_F"};
	case "G": {"I_MBT_03_cannon_F"};
};
d_sm_tank_own_side = switch (d_own_side_short) do {
	case "E": {"O_SFIA_MBT_02_cannon_lxWS"};
	case "W": {"B_MBT_01_cannon_F"};
	case "G": {"I_MBT_03_cannon_F"};
};
d_sm_tank_special_own_side = "";
d_sm_HunterGMG = switch (d_enemy_side_short) do {
	case "E": {"O_Tura_Offroad_armor_armed_lxWS"};
	case "W": {"B_MRAP_01_gmg_F"};
	case "G": {"I_MRAP_03_hmg_F"};
};
d_sm_HunterGMG_own_side = switch (d_own_side_short) do {
	case "E": {"O_Tura_Offroad_armor_armed_lxWS"};
	case "W": {"B_MRAP_01_gmg_F"};
	case "G": {"I_MRAP_03_hmg_F"};
};
d_sm_chopper = switch (d_enemy_side_short) do {
	case "E": {"O_SFIA_Heli_Attack_02_dynamicLoadout_lxWS"};
	case "W": {"B_Heli_Attack_01_F"};
	case "G": {"I_Heli_light_03_F"};
};
d_sm_pilottype = switch (d_enemy_side_short) do {
	case "E": {"B_D_HeliPilot_lxWS"};
	case "W": {"O_helipilot_F"};
	case "G": {"I_helipilot_F"};
};
d_sm_wrecktype = switch (d_enemy_side_short) do {
	case "E": {"Land_Wreck_Heli_Attack_01_F"};
	case "W": {"Land_UWreck_Heli_Attack_02_F"};
	case "G": {"Land_Wreck_Heli_Attack_02_F"};
};
d_sm_ammotrucktype = switch (d_enemy_side_short) do {
	case "E": {"O_SFIA_Truck_02_Ammo_lxWS"};
	case "W": {"B_Truck_01_ammo_F"};
	case "G": {"I_Truck_02_ammo_F"};
};
d_sm_ammotrucktype_own_side = switch (d_own_side_short) do {
	case "E": {"O_SFIA_Truck_02_Ammo_lxWS"};
	case "W": {"B_Truck_01_ammo_F"};
	case "G": {"I_Truck_02_ammo_F"};
};
d_sm_apc = switch (d_enemy_side_short) do {
	case "E": {"O_SFIA_APC_Tracked_02_cannon_lxWS"};
	case "W": {["B_APC_Tracked_01_rcws_F","B_T_APC_Tracked_01_rcws_F"] select (d_tanoa || {d_livonia})};
	case "G": {"I_APC_tracked_03_cannon_F"};
};
d_sm_apc_own_side = switch (d_own_side_short) do {
	case "E": {"O_SFIA_APC_Tracked_02_cannon_lxWS"};
	case "W": {["B_APC_Tracked_01_rcws_F","B_T_APC_Tracked_01_rcws_F"] select (d_tanoa || {d_livonia})};
	case "G": {"I_APC_tracked_03_cannon_F"};
};
d_sm_cargotrucktype = switch (d_enemy_side_short) do {
	case "E": {"O_SFIA_Truck_02_covered_lxWS"};
	case "W": {"B_Truck_01_covered_F"};
	case "G": {"I_Truck_02_covered_F"};
};
d_sm_fueltrucktype = switch (d_enemy_side_short) do {
	case "E": {"O_SFIA_Truck_02_fuel_lxWS"};
	case "W": {"B_Truck_01_fuel_F"};
	case "G": {"I_Truck_02_fuel_F"};
};
d_sm_camo_net = call {
   if (d_enemy_side_short == "W") exitWith {"CamoNet_BLUFOR_big_F"};
   if (d_enemy_side_short == "E") exitWith {"CamoNet_OPFOR_big_F"};
   "CamoNet_INDP_big_F"
};
d_sm_medtrucktype = switch (d_enemy_side_short) do {
	case "E": {"O_Truck_02_medical_F"};
	case "W": {"B_Truck_01_medical_F"};
	case "G": {"I_Truck_02_medical_F"};
};
d_sm_deliver_truck = switch (d_enemy_side_short) do {
	case "E": {["B_D_Truck_01_Repair_lxWS", "B_D_Truck_01_ammo_lxWS", "B_D_Truck_01_fuel_lxWS", "B_Truck_01_medical_F"]};
	case "W": {["O_Truck_03_repair_F", "O_Truck_03_ammo_F", "O_Truck_03_fuel_F", "O_Truck_03_medical_F"]};
	case "G": {["I_Truck_03_repair_F", "I_Truck_03_ammo_F", "I_Truck_03_fuel_F", "I_Truck_03_medical_F"]};
};
d_sm_cache = switch (d_enemy_side_short) do {
	case "W": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "E": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
	case "G": {["Box_Syndicate_Ammo_F", "Box_Syndicate_Wps_F", "Box_Syndicate_WpsLaunch_F"]};
};
