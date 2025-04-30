// by Xeno
#include "..\x_setup.sqf"

if (!d_player_canu) exitWith {};

params ["_reason", "_score"];

// reason:
// 1 - здание казармы уничтожено на главной цели
// 2 - здание мобильного штаба уничтожено на главной цели
// 3 - радиовышка уничтожена на главной цели
// 4 - игрок занял блокпост
// 5 - игрок выполнил основную целевую миссию
// 6 - дополнительные очки за захват основной цели
// 7 - очки за оживление другого игрока
// 8 - очки за помощь в решении побочной миссии
// 9 - баллов за ремонт/заправку транспортного средства
// 10 - очков за исцеление другого юнита
// 11 - очков за исцеление другого игрока в пюре игрока
// 12 - очки для другого игрока, появляющегося у лидера отряда
// 13 - очки за перевозку другого игрока в транспортном средстве
// 15 - очки, вычитаемые при убийстве животного, смотрите fn_killedanimal.sqf

private _txt = call {
	if (_reason == 1) exitWith {
		localize "STR_DOM_MISSIONSTRING_1971"
	};
	if (_reason == 2) exitWith {
		localize "STR_DOM_MISSIONSTRING_1972"
	};
	if (_reason == 3) exitWith {
		localize "STR_DOM_MISSIONSTRING_1973"
	};
	if (_reason == 4) exitWith {
		localize "STR_DOM_MISSIONSTRING_1974"
	};
	if (_reason == 5) exitWith {
		localize "STR_DOM_MISSIONSTRING_1975"
	};
	if (_reason == 6) exitWith {
		localize "STR_DOM_MISSIONSTRING_1976"
	};
	if (_reason == 7) exitWith {
		localize "STR_DOM_MISSIONSTRING_1970"
	};
	if (_reason == 8) exitWith {
		localize "STR_DOM_MISSIONSTRING_1977"
	};
	if (_reason == 9) exitWith {
		localize "STR_DOM_MISSIONSTRING_1979"
	};
	if (_reason == 10) exitWith {
		localize "STR_DOM_MISSIONSTRING_1980"
	};
	if (_reason == 11) exitWith {
		localize "STR_DOM_MISSIONSTRING_1987"
	};
	if (_reason == 12) exitWith {
		localize "STR_DOM_MISSIONSTRING_1989"
	};
	if (_reason == 13) exitWith {
		localize "STR_DOM_MISSIONSTRING_2001"
	};
	if (_reason == 14) exitWith {
		localize "STR_DOM_MISSIONSTRING_1856"
	};
	if (_reason == 15) exitWith {
		format [localize "STR_DOM_MISSIONSTRING_2109", localize (_this # 2)]
	};
	""
};

if (_txt isEqualTo "") exitWith {};

d_scoreadd_qeue pushBack [_txt, _score];

if (isNull d_scoreadd_script) then {
	d_scoreadd_script = 0 spawn d_fnc_scoreaddqeue;
};
