// by Longtime
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface || {isStreamFriendlyUIEnabled}) exitWith {};

params ["_distance_fired"];
private _t = format [localize "STR_DOM_MISSIONSTRING_HEADSHOT_CLIENT", floor _distance_fired];
"d_headshot_txt" cutText [format ["<t color='#ff0000' size='2'>%1</t>", _t], "PLAIN DOWN", 0.3, true, true];