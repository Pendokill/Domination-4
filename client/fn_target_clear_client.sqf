// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE("Start")

if (!hasInterface) exitWith {};

if (!isNil "d_meh_markercreated") then {
	removeMissionEventHandler ["MarkerCreated", d_meh_markercreated];
	d_meh_markercreated = nil;
};

playSound "d_fanfare";

#ifndef __TT__
{
	private _mname = _x getVariable "d_trigmarker";
	if (!isNil "_mname") then {
		deleteMarkerLocal _mname;
	};
	deleteVehicle _x;
} forEach d_mt_marker_triggers;
d_mt_marker_triggers = [];
#endif

if (!isNil "d_client_barmhqtrigs") then {
	deleteVehicle d_client_barmhqtrigs;
	d_client_barmhqtrigs = [];
};

if (!isNil "d_deletecamptrigs") then {
	deleteVehicle d_deletecamptrigs;
	d_deletecamptrigs = [];
};

private _extra_bonusn = _this;

if (!isNil "d_obj00_task") then {
	d_obj00_task = nil;
	["d_obj00", "Succeeded", false] call d_fnc_taskSetState;
};

if (!isNil "d_current_task") then {
	[d_current_task, "Succeeded", true] call d_fnc_taskSetState;
};
sleep 0.472;
playSound "sector_clier";

private _mt_str = format [localize "STR_DOM_MISSIONSTRING_570", d_cur_tgt_name];
if (count d_resolved_targets < d_MainTargets) then {
#ifndef __TT__
	if (_extra_bonusn isNotEqualTo "") then {
		private _bonus_string = format[localize "STR_DOM_MISSIONSTRING_571", [_extra_bonusn, "CfgVehicles"] call d_fnc_GetDisplayName];

		hint composeText[
			parseText format ["<t color='#00ff00' size='1.5'>%1</t>", _mt_str], lineBreak, lineBreak,
			localize "STR_DOM_MISSIONSTRING_572", lineBreak,lineBreak,
			_bonus_string, lineBreak,lineBreak,
			localize "STR_DOM_MISSIONSTRING_573"
		];
	} else {
		hint composeText[
			parseText format ["<t color='#00ff00' size='1.5'>%1</t>", _mt_str], lineBreak, lineBreak,
			localize "STR_DOM_MISSIONSTRING_572", lineBreak,lineBreak,
			localize "STR_DOM_MISSIONSTRING_573"
		];
	};
#else
	private _kill_points_blufor = d_points_array # 2;
	private _kill_points_opfor = d_points_array # 3;
	private _winner_string = switch (d_mt_winner) do {
		case 1: {format [localize "STR_DOM_MISSIONSTRING_575", _kill_points_blufor, _kill_points_opfor, d_tt_points # 0]};
		case 2: {format [localize "STR_DOM_MISSIONSTRING_576", _kill_points_opfor, _kill_points_blufor, d_tt_points # 0]};
		case 3: {format [localize "STR_DOM_MISSIONSTRING_577", _kill_points_opfor, d_tt_points # 1]};
		default {""};
	};

	if (_extra_bonusn # 0 isNotEqualTo "" || {_extra_bonusn # 0 isNotEqualTo ""}) then {
		private _vecnn = switch (d_player_side) do {
			case blufor: {_extra_bonusn # 0};
			case opfor: {_extra_bonusn # 1};
			default {""};
		};

		if (d_mt_winner == 1 && {d_player_side == blufor} || {d_mt_winner == 2 && {d_player_side == opfor} || {d_mt_winner == 3}}) then {
			private _bonus_string = format[localize "STR_DOM_MISSIONSTRING_571", [_vecnn, "CfgVehicles"] call d_fnc_GetDisplayName];
			hint composeText[
				parseText("<t color='#00ff00' size='1.5'>" + _mt_str + "</t>"), lineBreak,lineBreak,
				localize "STR_DOM_MISSIONSTRING_572", lineBreak,lineBreak,
				_bonus_string, lineBreak,lineBreak,
				localize "STR_DOM_MISSIONSTRING_573"
			];
		} else {
			hint composeText[
				parseText("<t color='#00ff00' size='1.5'>" + _mt_str + "</t>"), lineBreak,lineBreak,
				localize "STR_DOM_MISSIONSTRING_573"
			];
		};
	} else {
		hint composeText[
			parseText("<t color='#00ff00' size='1.5'>" + _mt_str + "</t>"), lineBreak,lineBreak,
			localize "STR_DOM_MISSIONSTRING_572", lineBreak,lineBreak,
			localize "STR_DOM_MISSIONSTRING_573"
		];
	};
	"d_tt_winner" cutText [_winner_string, "PLAIN"];
#endif
#ifndef __TT__
	if (d_with_ranked || {d_database_found}) then {
		if (isNil "d_dist_for_points") then {d_dist_for_points = -1};
		private _dist_for_points = if (d_ranked_a # 10 < d_dist_for_points) then {d_dist_for_points} else {d_ranked_a # 10};
		if (player distance2D d_cur_tgt_pos < _dist_for_points) then {
			0 spawn {
				scriptName "spawn_x_target_clear_client_sendscore";
				sleep (0.5 + random 2);
				[player, 6] remoteExecCall ["d_fnc_addscore", 2];
			};
		};
	};
#endif
} else {
	d_mission_is_now_over = true;
#ifndef __TT__
	hint  composeText[
		parseText("<t color='#f02b11ed' size='1'>" + format [localize "STR_DOM_MISSIONSTRING_570", d_cur_tgt_name] + "</t>"), lineBreak, lineBreak,
		localize "STR_DOM_MISSIONSTRING_572"
	];
#else
	private _kill_points_blufor = d_points_array # 2;
	private _kill_points_opfor = d_points_array # 3;
	private _winner_string = switch (d_mt_winner) do {
		case 1: {format [localize "STR_DOM_MISSIONSTRING_575", _kill_points_blufor, _kill_points_opfor, d_tt_points # 0]};
		case 2: {format [localize "STR_DOM_MISSIONSTRING_576", _kill_points_opfor, _kill_points_blufor, d_tt_points # 0]};
		case 3: {format [localize "STR_DOM_MISSIONSTRING_577", _kill_points_opfor, d_tt_points # 1]};
		default {""};
	};
	hint  composeText[
		parseText("<t color='#f02b11ed' size='1'>" + _mt_str + "</t>"), lineBreak,lineBreak,
		localize "STR_DOM_MISSIONSTRING_572"
	];
	"d_tt_winner" cutText [_winner_string, "PLAIN"];
#endif
};
__TRACE("End")
