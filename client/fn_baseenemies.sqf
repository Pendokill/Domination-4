// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (!hasInterface) exitWith {};

if (d_force_isstreamfriendlyui == 1 || {isStreamFriendlyUIEnabled}) exitWith {};

if (_this # 0 == 0) exitWith {
	hint composeText[
		parseText format ["<t color='#e54934' size='2'>%1</t>", localize "STR_DOM_MISSIONSTRING_676"], lineBreak,
		parseText format ["<t size='1'>%1</t>", localize "STR_DOM_MISSIONSTRING_677"]
	];
};
hint composeText[
	parseText format ["<t color='#33ffba' size='2'>%1</t>", localize "STR_DOM_MISSIONSTRING_678"], lineBreak,		
	parseText format ["<t size='1'>%1</t>", localize "STR_DOM_MISSIONSTRING_679"]
];
