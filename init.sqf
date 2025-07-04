// by Xeno
//#define __DEBUG__
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom init.sqf"];

if (productVersion # 2 < 218) exitWith {
	diag_log [diag_frameno, diag_ticktime, time, "You need at least Arma 3 patch 2.18 to run Domination!!!!"];
	endMission "LOSER";
	forceEnd;
};

// Чтобы включить мод спавна техники на вашем сервере, но также получать уведомление, когда пользователи используют его (режим читера)
DCON_Garage_Enabled = 0;
publicVariable "DCON_Garage_Enabled";

if (isMultiplayer && {hasInterface}) then {
	enableRadio true;
	showChat false;
	0 fadeSound 0;
	0 fadeEnvironment 0;
	titleText ["", "BLACK FADED"];
};

enableSaving [false,false];
enableTeamSwitch false;

// Серверная инициализация магазина
if (isServer) then {
    [] execVM "scripts\vehicleShop\vehicleShop_config.sqf";
    waitUntil {!isNil "vehicleShop_configLoaded"};
    
	if (isNil "vehicleShop_vehicles") then {
        vehicleShop_vehicles = [];
        publicVariable "vehicleShop_vehicles";
    };
	
    if (isNil "vehicleShop_loadMode") then {
        vehicleShop_loadMode = 0;
        publicVariable "vehicleShop_loadMode";
    };
    
    [] execVM "scripts\vehicleShop\vehicleShop_init.sqf";
    
    // Создание маркера если не существует
    if (getMarkerColor "vehicle_spawn" == "") then {
        createMarker ["vehicle_spawn", [577.138,12284.1]];
        "vehicle_spawn" setMarkerDir 0;
        "vehicle_spawn" setMarkerType "hd_start";
        "vehicle_spawn" setMarkerColor "ColorGreen";
        publicVariable "vehicle_spawn";
    };
};

if (hasInterface) then {
    player addEventHandler ["Respawn", {
        [] spawn {
            waitUntil {!isNull (findDisplay 5000)};
            ['All'] call vehicleShop_filterByCategory;
        };
    }];
};

// Клиентская инициализация
if (hasInterface) then {
    [] spawn {
        waitUntil {!isNull player && !isNil "vehicleShop_configLoaded"};
        systemChat "Магазин техники готов к использованию";
    };
};

// Банковская система (после инициализации CBA и extDB3)
[] spawn {
    waitUntil {time > 5};
    [] execVM "scripts\bank\bank_init.sqf";
    diag_log "[Init] Банковская система запущена";
};

player exec "scripts\radioru.sqs";

private _year = -1;
#ifdef __IFA3__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 1944..."];
	private _date = date;
	_date set [0, 1944];
	_year = 1944;
	setDate _date;
};
#endif
#ifdef __VN__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 1971..."];
	private _date = date;
	_date set [0, 1971];
	_year = 1971;
	setDate _date;
};
#endif
#ifdef __UNSUNG__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 1971..."];
	private _date = date;
	_date set [0, 1971];
	_year = 1971;
	setDate _date;
};
#endif
#ifdef __SPE__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 1944..."];
	private _date = date;
	_date set [0, 1944];
	_year = 1944;
	setDate _date;
};
#endif
#ifdef __JSDF__
if (isServer) then {
	diag_log ["DOM init.sqf, setting date back to 2022..."];
	private _date = date;
	_date set [0, 2022];
	_year = 2022;
	setDate _date;
};
#endif

_year spawn {
	params ["_year"];
	waitUntil {!isNil "d_use_systemtime"};
	if (d_use_systemtime == 1) then {
		private _st = systemTime;
		if (_year != -1) then {
			_year = _st # 0;
		};
		setDate [_year, _st # 1, _st # 2, _st # 3, _st # 4];
	};
};

diag_log [diag_frameno, diag_ticktime, time, "Dom init.sqf processed"];

