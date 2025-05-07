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
// DCON_Garage_Enabled = 0;
// publicVariable "DCON_Garage_Enabled";

// Серверная часть инициализации магазина техники
if (isServer) then {
    [] spawn {
        waitUntil {time > 5}; // Увеличено время ожидания
        execVM "scripts\vehicleShop\vehicleShop_config.sqf";
        waitUntil {!isNil "vehicleShop_configLoaded"};
        diag_log "[VehicleShop] Конфигурация загружена, начинаем инициализацию";
        execVM "scripts\vehicleShop\vehicleShop_init.sqf";
    };
};

// Клиентская часть инициализации
if (hasInterface) then {
    [] spawn {
        waitUntil {!isNull player && time > 10}; // Добавлена проверка времени
        waitUntil {!isNil "vehicleShop_configLoaded" && !isNil "vehicleShop_vehicles"};
        systemChat "Магазин техники инициализирован";
        diag_log "[VehicleShop] Клиентская часть инициализирована";
    };
};

if (isMultiplayer && {hasInterface}) then {
	enableRadio true;
	showChat false;
	0 fadeSound 0;
	0 fadeEnvironment 0;
	titleText ["", "BLACK FADED"];
};

enableSaving [false,false];
enableTeamSwitch false;

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

// Клиентская проверка обновлений магазина
if (hasInterface) then {
    [] spawn {
        waitUntil {!isNull player && !isNil "vehicleShop_vehicles"};
        
        while {true} do {
            if (!isNull (findDisplay 5000)) then {
                private _currentPoints = score player;
                private _dialog = findDisplay 5000;
                private _pointsText = _dialog displayCtrl 5003;
                _pointsText ctrlSetText format ["ОЧКИ: %1", _currentPoints];
                
                // Обновление цветов в списке
                private _vehicleList = _dialog displayCtrl 5001;
                for "_i" from 0 to (lbSize _vehicleList - 1) do {
                    _cost = _vehicleList lbValue _i;
                    _vehicleList lbSetColor [_i, if (_currentPoints >= _cost) then {[1,1,1,1]} else {[1,0.3,0.3,0.7]}];
                };
            };
            sleep 2;
        };
    };
};

diag_log [diag_frameno, diag_ticktime, time, "Dom init.sqf processed"];

