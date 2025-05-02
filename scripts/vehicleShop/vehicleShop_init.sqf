/*
    vehicleShop_init.sqf
    Инициализация магазина техники для миссии Domination
    Версия 2.0 (полностью переработанная)
*/

// Ждем загрузки основных систем миссии
waitUntil {!isNil "d_player_hash" && !isNil "vehicleShop_configLoaded"};

diag_log "[VehicleShop] Начало инициализации магазина техники";

// ====================== ОСНОВНЫЕ ФУНКЦИИ ======================

/* Функция получения текущих очков игрока */
vehicleShop_getPoints = {
    params ["_player"];
    private _uid = getPlayerUID _player;
    private _scoresKey = _uid + "_scores";
    
    if (_scoresKey in d_player_hash) then {
        private _playerData = d_player_hash get _scoresKey;
        if (count _playerData >= 6) then {
            _playerData select 5 // Возвращаем 6-й элемент массива (очки)
        } else {
            0
        };
    } else {
        0
    };
};

/* Функция обновления деталей техники */
vehicleShop_updateDetails = {
    params ["_control", "_selectedIndex"];
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {};
    
    private _detailsCtrl = _dialog displayCtrl 5004;
    private _vehicleData = vehicleShop_vehicles select _selectedIndex;
    
    private _className = _vehicleData select 0;
    private _cost = _vehicleData select 1;
    private _displayName = _vehicleData select 2;
    
    private _config = configFile >> "CfgVehicles" >> _className;
    private _description = getText(_config >> "Library" >> "libTextDesc");
    private _maxSpeed = getNumber(_config >> "maxSpeed");
    private _armor = getNumber(_config >> "armor");
    
    _detailsCtrl ctrlSetStructuredText parseText format [
        "<t font='PuristaMedium' size='0.8'>%1<br/>Цена: %2 очков<br/><br/>Описание: %3<br/>Макс. скорость: %4 км/ч<br/>Броня: %5</t>",
        _displayName, _cost, _description, _maxSpeed, _armor
    ];
};

/* Функция проверки достаточности очков */
vehicleShop_checkPoints = {
    params ["_player", "_cost"];
    private _points = [_player] call vehicleShop_getPoints;
    _points >= _cost
};

/* Функция списания очков (только на сервере) */
vehicleShop_deductPoints = {
    params ["_player", "_cost"];
    
    if (!isServer) exitWith {
        _this remoteExec ["vehicleShop_deductPoints", 2];
    };
    
    private _uid = getPlayerUID _player;
    private _scoresKey = _uid + "_scores";
    
    // Получаем текущие данные
    private _playerData = if (_scoresKey in d_player_hash) then {
        d_player_hash get _scoresKey
    } else {
        [0,0,0,0,0,0] // Значение по умолчанию
    };
    
    // Обновляем очки
    if (count _playerData >= 6) then {
        _playerData set [5, (_playerData select 5) - _cost];
        d_player_hash set [_scoresKey, _playerData];
        
        // Синхронизация
        publicVariable "d_player_hash";
        diag_log format ["[VehicleShop] Списано %1 очков у %2", _cost, name _player];
    };
};

/* Функция получения позиций спавна */
vehicleShop_getSpawnPos = {
    params ["_stand"];
    
    private _spawnPositions = [];
    {
        private _pos = _stand modelToWorld [_x select 0, _x select 1, _x select 2];
        _spawnPositions pushBack [_pos, _x select 3];
    } forEach vehicleShop_spawnOffsets;
    
    _spawnPositions
};

/* Функция обновления интерфейса */
vehicleShop_updateUI = {
    if (!hasInterface) exitWith {};
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {};
    
    // Обновляем список техники
    private _vehicleList = _dialog displayCtrl 5001;
    lbClear _vehicleList;
    
    {
        _x params ["_className", "_cost", "_displayName"];
        private _index = _vehicleList lbAdd _displayName;
        _vehicleList lbSetData [_index, _className];
        _vehicleList lbSetValue [_index, _cost];
    } forEach vehicleShop_vehicles;
    
    // Обновляем очки
    private _pointsText = _dialog displayCtrl 5003;
    private _currentPoints = [player] call vehicleShop_getPoints;
    _pointsText ctrlSetText format ["Очков: %1", _currentPoints];
    
    // Выбираем первый элемент
    if (lbSize _vehicleList > 0) then {
        _vehicleList lbSetCurSel 0;
        [_vehicleList, 0] call vehicleShop_updateDetails;
    };
};

// ====================== ИНИЦИАЛИЗАЦИЯ МАГАЗИНА ======================

// Проверяем наличие стоек
if (isNil "vehicleShop_stands" || {count vehicleShop_stands == 0}) exitWith {
    diag_log "[VehicleShop] Ошибка: не найдено стоек для магазина";
};

diag_log format ["[VehicleShop] Найдено стоек: %1", count vehicleShop_stands];

// Добавляем действия к стойкам
{
    private _stand = _x;
    _stand addAction [
        "<t color='#00FFFF'>[Магазин техники]</t>", 
        {
            if (hasInterface) then {
                [] spawn {
                    // Ждем готовности данных
                    waitUntil {
                        !isNull (findDisplay 46) && 
                        !isNil "vehicleShop_vehicles" && 
                        !isNil "d_player_hash"
                    };
                    
                    // Создаем диалог
                    createDialog "VehicleShopDialog";
                    
                    // Ждем создания диалога
                    waitUntil {!isNull (findDisplay 5000) || time > 5};
                    
                    if (isNull (findDisplay 5000)) exitWith {
                        systemChat "Ошибка открытия меню";
                        diag_log "[VehicleShop] Не удалось создать диалог";
                    };
                    
                    // Обновляем интерфейс
                    [] call vehicleShop_updateUI;
                    
                    // Цикл обновления
                    [] spawn {
                        while {!isNull (findDisplay 5000)} do {
                            [] call vehicleShop_updateUI;
                            sleep 0.5;
                        };
                    };
                };
            };
        },
        nil,
        1.5,
        true,
        true,
        "",
        "true",
        5
    ];
    
    _stand enableSimulation true;
    _stand allowDamage false;
    diag_log format ["[VehicleShop] Действие добавлено к стойке %1", _forEachIndex];
} forEach vehicleShop_stands;

// Синхронизация функций с клиентами
publicVariable "vehicleShop_getPoints";
publicVariable "vehicleShop_updateDetails";
publicVariable "vehicleShop_checkPoints";
publicVariable "vehicleShop_deductPoints";
publicVariable "vehicleShop_getSpawnPos";
publicVariable "vehicleShop_updateUI";

diag_log "[VehicleShop] Инициализация магазина завершена";