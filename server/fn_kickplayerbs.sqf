// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

params ["_pl", "_pl_name", "_reason"];
private _uid = getPlayerUID _pl;

if (_reason != -1) then {
	private _docschat = true;
	call {
		if (_reason == 2) exitWith {
			diag_log format [localize "STR_DOM_MISSIONSTRING_945", _pl_name, _uid];
			_docschat = false;
		};
		if (_reason == 3) then {
			diag_log format [localize "STR_DOM_MISSIONSTRING_946", _pl_name, _uid];
			_docschat = false;
		};
		if (_reason == 99) then {
			diag_log format [localize "STR_DOM_MISSIONSTRING_2070", _pl_name, _uid];
			playSound "noob";
		};
	};
	_reason remoteExecCall ["d_fnc_emiss", _pl];
	if (_docschat) then {
		[10, _reason, _pl_name] remoteExecCall ["d_fnc_csidechat", [0, -2] select isDedicated];
	};
} else {
	-1 remoteExecCall ["d_fnc_emiss", _pl];
};
