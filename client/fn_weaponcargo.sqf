// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

__TRACE_1("","_this")

params ["_vec"];

_vec setVariable ["d_player_ammobox", true];

#ifdef __TT__
private _p2 = _this # 1;
if (isNil "_p2" || {d_player_side == _p2}) then {
#endif
if (!isStreamFriendlyUIEnabled && {d_force_isstreamfriendlyui != 1}) then {
	d_all_p_a_boxes pushBack [_vec, [1, 1, 0, 0], localize "STR_DOM_MISSIONSTRING_1585"]; // yellow, Text "Virtual Arsenal"
} else {
	d_all_p_a_boxes pushBack [_vec, [1, 1, 0, 0], ""]; // no text
};
__TRACE_1("","d_all_p_a_boxes")
#ifdef __TT__
};
#endif

__TRACE_1("","_vec")
