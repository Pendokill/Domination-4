//#include "..\x_macros.sqf"

if (!hasInterface) exitWith {};

private _dragee	= (_this # 3) # 0;

if (xr_dropAction != -3333) then {
	player removeAction xr_dropAction;
	xr_dropAction = -3333;
};
if (!isNil "xr_xr_carryAction" && {xr_carryAction != -3333}) then {
	player removeAction xr_carryAction;
	xr_carryAction = -3333;
};
xr_drag = false;
xr_carry = false;

detach player;
detach _dragee;

[_dragee, 101] remoteExecCall ["xr_fnc_handlenet"];
if ((_this # 3) # 1 == 0) then {
	[player, 3] remoteExecCall ["d_fnc_swm"];
};
