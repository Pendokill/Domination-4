// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!isServer) exitWith{};

d_vrespawn2_ar = [];
{
	__TRACE_1("","_x")
	_x params ["_vec", "_number_v"];
	if (!isNil "_vec" && {!isNull _vec}) then {
		private _vposp = if (_vec isKindOf "Air") then {
			(getPosATL _vec) vectorAdd [0, 0, 0.1];
		} else {
			getPosATL _vec;
		};
		if (count _x == 2) then {
			d_vrespawn2_ar pushBack [_vec, _number_v, _vposp, getDir _vec, typeOf _vec];
		} else {
			d_vrespawn2_ar pushBack [_vec, _number_v, _vposp, getDir _vec, typeOf _vec, _x # 2];
			_vec setVariable ["d_vec_is_mhq", [_x # 2, _number_v]];
			if (!d_with_ranked) then {
				_vec setVariable ["d_ammobox", true, true];
				_vec setVariable ["d_abox_perc", 100, true];
			};
		};
		
		_vec setVariable ["d_OUT_OF_SPACE", -1];
		_vec setVariable ["d_vec", _number_v, true];
		_vec setVariable ["d_vec_islocked", _vec call d_fnc_isVecLocked];
#ifdef __TT__
		if (_number_v < 1000) then {
			[_vec, 1] call d_fnc_setekmode;
		} else {
			[_vec, 2] call d_fnc_setekmode;
		};
#endif
		[_vec, 9] call d_fnc_setekmode;
		if (_number_v < 100 || {_number_v > 999 && {_number_v < 1100}}) then {
			if (d_NoMHQTeleEnemyNear > 0) then {
				[_vec, 14] call d_fnc_setekmode;
			};
			[_vec, 10] call d_fnc_setekmode;
			_vec addEventHandler ["handleDamage", {call d_fnc_pshootatmhq}];
#ifndef __TT__
			private _flag = call {
			     if (d_own_side == "EAST") exitWith {"pics\flag_odkb.paa"};
			     if (d_own_side == "WEST") exitWith {"pics\flag_nato.paa"};
			     "\a3\data_f\flags\flag_green_co.paa"			
			};
			_vec forceFlagTexture _flag;
#endif
#ifdef __TT__
			if (_number_v < 100) then {
				_vec setVariable ["d_side", blufor];
			} else {
				if (_number_v > 999 && {_number_v < 1100}) then {
					_vec setVariable ["d_side", opfor];
				};
			};
#endif
		};
		if !(_vec isKindOf "Air") then {
			_vec setVariable ["d_liftit", true, true];
		};
		if (unitIsUAV _vec) then {
			_vec allowCrewInImmobile true;
		} else {
			if (d_with_dynsim == 0) then {
				[_vec, 10] spawn d_fnc_enabledynsim;
			};
		};
		if (isNil {_vec getVariable "d_cwcg_inited"}) then {
			if (d_with_ranked) then {
				clearWeaponCargoGlobal _vec;
			};
			clearBackpackCargoGlobal _vec;
		};
		
		if (_vec isKindOf "Boat_F") then {
			_vec remoteExecCall ["d_fnc_addpushaction", [0, -2] select isDedicated];
		};
		if !(_vec isKindOf "Ship") then {
			_vec setVariable ["d_drowned", true];
		};
		_vec setDamage 0;
	};
} forEach _this;

0 spawn d_fnc_vrespawn2;
