// by Xeno
//#define __DEBUG__
//#include "..\x_setup.sqf"

params ["_list", "_trig"];

if (_list isEqualTo []) exitWith {false};

if ("Helicopter" countType _list == 0) exitWith {
	//__TRACE("No heli inside trigger")
	false
};
if (!isTouchingGround (_list # 0)) exitWith {
	//__TRACE("Heli is not touching ground")
	false
};

_trig setVariable ["d_list", _list];

//__TRACE("true")
true
