// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_p", "_killer", "_insti"];

if (isNull _insti) exitWith {};

if !(isPlayer [_insti]) then {
	private _lead = leader _insti;
	if (!isNull _lead && {isPlayer [_lead] && {side (group _insti) getFriend d_side_enemy < 0.6}}) then {
		_lead addScore (_this # 0);
	};
};