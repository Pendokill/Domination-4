/*  
    by Pirat
    vehicleShop_init.sqf
    Полностью исправленная версия
*/

waitUntil {!isNil "vehicleShop_configLoaded" && !isNil "vehicleShop_vehicles"};
diag_log "[VehicleShop] Инициализация интерфейса";

// ====================== ОСНОВНЫЕ ФУНКЦИИ ======================

/*
    Функция получения текущего звания игрока
    с новыми порогами очков
*/
vehicleShop_getPlayerRank = {
    params ["_player"];
    // 1. Проверяем переменную dom_rank_index (основной способ)
    private _rankIndex = _player getVariable ["dom_rank_index", -1];
    
    // 2. Если не найдено, проверяем старую переменную dom_rank
    if (_rankIndex == -1) then {
        private _rankStr = toLower (_player getVariable ["dom_rank", ""]);
        if (_rankStr != "") then {
            _rankIndex = switch (_rankStr) do {
                case "dom_private": {0};
                case "dom_corporal": {1};
                case "dom_sergeant": {2};
                case "dom_lieutenant": {3};
                case "dom_captain": {4};
                case "dom_major": {5};
                case "dom_colonel": {6};
                case "dom_general": {7};
                default {0};
            };
        } else {
            private _score = score _player;
            _rankIndex = switch (true) do {
                case (_score >= 50000): {7}; // Генерал
                case (_score >= 30000): {6}; // Полковник
                case (_score >= 15000): {5}; // Майор
                case (_score >= 9000): {4};  // Капитан
                case (_score >= 5000): {3};  // Лейтенант
                case (_score >= 2000): {2};  // Сержант
                case (_score >= 500): {1};   // Ефрейтор
                default {0};               // Рядовой
            };
        };
    };
    // Ограничиваем диапазон    
    (_rankIndex max 0) min 7
};

/*
    Функция получения названия звания по индексу
*/
vehicleShop_getRankName = {
    params ["_rankIndex"];
    if (_rankIndex < 0 || _rankIndex >= count vehicleShop_rankNames) then {_rankIndex = 0};
    vehicleShop_rankNames select _rankIndex
};

/*
    Функция проверки звания
*/
vehicleShop_checkRank = {
    params ["_player", "_requiredRankIndex"];
    if (isNil "_requiredRankIndex") exitWith { false };
    
    private _currentRank = [_player] call vehicleShop_getPlayerRank;
    _currentRank >= _requiredRankIndex
};

/*
    Функция получения значка мода для техники
    (Добавлена новая функция)
*/
vehicleShop_getModIcon = {
    params ["_className"];
    private _modIcons = [
        ["rhs_", "\rhsafrf\addons\rhs_main\data\rhs_logo_ca.paa"],
        ["min_rf_", "\min_rf\addons\min_rf\data\ui\rf+logo.paa"],
        ["FP_", "\FP_Core\Data\icons\fp_icon_ca.paa"],
        ["CUP_", "\CUP\Vehicles\Data\icon\cup_icon_ca.paa"],
        ["OPTRE_", "\OPTRE_Vehicles_Army\icons\optre_icon_ca.paa"]
    ];
    { if (_className find (_x select 0) == 0) exitWith { _x select 1 }; } forEach _modIcons;
    ""
};

/*
    Функция обновления деталей техники
*/
vehicleShop_updateDetails = {
    params ["_control", "_selectedIndex"];
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {};
    
    private _detailsCtrl = _dialog displayCtrl 5004;
    if (count vehicleShop_vehicles <= _selectedIndex) exitWith {
        _detailsCtrl ctrlSetText "Ошибка загрузки данных";
    };
    
    private _vehicleData = vehicleShop_vehicles select _selectedIndex;
    if (count _vehicleData < 4) exitWith {
        _detailsCtrl ctrlSetText "Ошибка конфигурации";
    };
    
    _vehicleData params ["_className", "_cost", "_displayName", "_requiredRankIndex"];
    
    // Получаем данные из конфига
    private _config = configFile >> "CfgVehicles" >> _className;
    private _maxSpeed = getNumber(_config >> "maxSpeed");
    private _armor = getNumber(_config >> "armor");
    private _crew = getText(_config >> "crew");
    private _picture = getText(_config >> "picture");
    private _desc = getText(_config >> "Library" >> "libTextDesc");
    private _modIcon = [_className] call vehicleShop_getModIcon;
    // Проверяем доступность по рангу
    private _rankCheck = [player, _requiredRankIndex] call vehicleShop_checkRank;
    private _requiredRankName = [_requiredRankIndex] call vehicleShop_getRankName;
    
    // Формируем текст описания
    _detailsCtrl ctrlSetStructuredText parseText format [
        "<t font='RobotoCondensed' size='1.8'>
        <img image='%5' size='5' align='center'/><br/><br/>
        %10<t font='RobotoCondensedBold' size='2'>%1</t><br/><br/>
        <t color='#FFD700'>Цена: %2 очков</t><br/>
        <t color='%9'>▸ Требуется звание: %8</t><br/><br/>
        ▸ Скорость: %3 км/ч<br/>
        ▸ Броня: %4<br/>
        ▸ Экипаж: %6<br/><br/>
        %7</t>",
        _displayName, _cost, _maxSpeed, _armor, _picture, _crew, _desc, 
        _requiredRankName, if (_rankCheck) then {"#00FF00"} else {"#FF0000"},
        if (_modIcon != "") then {format ["<img image='%1' size='1.5' align='right'/><br/>", _modIcon]} else {""}
    ];
};

vehicleShop_toggleMode = {
    if (!hasInterface) exitWith {};
    
    if !(serverCommandAvailable "#logout" || isServer) exitWith {
        hint parseText "<t color='#FF0000'>Только для администратора!</t>";
        playSound "FD_Start_F";
    };
    
    private _newMode = abs (vehicleShop_loadMode - 1);
    [_newMode] remoteExec ["vehicleShop_setLoadMode", 2];
    
    hint parseText format [
        "<t color='#FFD700'>Режим изменен</t><br/>Теперь: %1", 
        ["Автоматический","Ручной"] select _newMode
    ];
};

vehicleShop_updateUI = {
    if (!hasInterface) exitWith {};
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {};
    
    // Обновляем отображение очков и звания (один раз)
    private _pointsText = _dialog displayCtrl 5003;
    private _currentPoints = score player;
    private _currentRank = [player] call vehicleShop_getPlayerRank;
    _pointsText ctrlSetText format [
        "ОЧКИ: %1 | ЗВАНИЕ: %2", 
        _currentPoints, 
        [_currentRank] call vehicleShop_getRankName
    ];
    
    private _vehicleList = _dialog displayCtrl 5001;
    lbClear _vehicleList;
    
    {
        if (count _x < 4) then { continue };
        
        _x params ["_className", "_cost", "_displayName", "_requiredRankIndex"];
        
        private _index = _vehicleList lbAdd format ["▸ %1", _displayName];
        _vehicleList lbSetData [_index, _className];
        _vehicleList lbSetValue [_index, _cost];
        
        // Исправление: установка белого цвета для иконок
        private _icon = getText(configFile >> "CfgVehicles" >> _className >> "picture");
        _vehicleList lbSetPicture [_index, _icon];
        _vehicleList lbSetPictureColor [_index, [1, 1, 1, 1]];
        _vehicleList lbSetPictureColorSelected [_index, [1, 1, 1, 1]];
        private _rankCheck = [player, _requiredRankIndex] call vehicleShop_checkRank;
        private _pointsCheck = _currentPoints >= _cost;
        
        _vehicleList lbSetColor [_index, 
            if (_rankCheck && _pointsCheck) then {[0.8,1,0.8,1]} else {[1,0.3,0.3,0.7]} // Доступно - Недоступно
        ];
    } forEach vehicleShop_vehicles;
    
    // Автовыбор первой техники
    if (lbSize _vehicleList > 0) then {
        _vehicleList lbSetCurSel 0;
        [_vehicleList, 0] call vehicleShop_updateDetails;
    };
};

/*
    Функция покупки техники
    с цветным выделением сообщений
*/
vehicleShop_purchase = {
    if (!hasInterface) exitWith {};
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {
        hint parseText "<t color='#FF0000'>Ошибка: диалог не найден</t>";
    };
    
    private _vehicleList = _dialog displayCtrl 5001;
    private _selectedIndex = lbCurSel _vehicleList;
    
    if (_selectedIndex == -1) exitWith {
        hint parseText "<t color='#FFD700'>Выберите технику!</t>";
    };
    
    if (count vehicleShop_vehicles <= _selectedIndex) exitWith {
        hint parseText "<t color='#FF0000'>Ошибка данных</t>";
    };
    
    private _vehicleData = vehicleShop_vehicles select _selectedIndex;
    if (count _vehicleData < 4) exitWith {
        hint parseText "<t color='#FF0000'>Ошибка конфигурации</t>";
    };
    
    _vehicleData params ["_className", "_cost", "_displayName", "_requiredRankIndex"];
    
    if !([player, _requiredRankIndex] call vehicleShop_checkRank) exitWith {
        hint parseText format [
            "<t color='#FF0000'>Недостаточно звания!</t><br/>Требуется: <t color='#00FF00'>%1</t>",
            [_requiredRankIndex] call vehicleShop_getRankName
        ];
    };
    
    if (score player < _cost) exitWith {
        hint parseText format [
            "<t color='#FF0000'>Недостаточно очков!</t><br/>Нужно: %1 | У вас: %2",
            _cost, score player
        ];
    };
    
    [player, _cost, _className] remoteExec ["vehicleShop_serverPurchase", 2];
    hint parseText format ["<t color='#00FF00'>Куплено:</t> %1", _displayName];
};

/*
    Функция покупки техники (серверная часть)
    с цветным выделением сообщений
*/
/*  
    Полная система магазина техники
    Включает:
    - Умный спавн без наложений
    - Маркеры с динамическим отображением
    - Систему блокировки для владельца
    - Интеграцию с системой подцепки
*/

vehicleShop_serverPurchase = {
    params ["_player", "_cost", "_className"];
    
    if (!isServer) exitWith {
        _this remoteExec ["vehicleShop_serverPurchase", 2];
    };
    
    // =============================================
    // 1. ПОИСК ТЕХНИКИ В МАГАЗИНЕ
    // =============================================
    private _vehicleIndex = -1;
    {
        if ((_x select 0) == _className) exitWith { _vehicleIndex = _forEachIndex };
    } forEach vehicleShop_vehicles;
    
    if (_vehicleIndex == -1) exitWith {
        ["Техника не найдена"] remoteExec ["hint", _player];
        diag_log format ["[VehicleShop] Ошибка: класс %1 не найден", _className];
    };
    
    private _vehicleData = vehicleShop_vehicles select _vehicleIndex;
    private _displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");

    // =============================================
    // 2. СПАВН ТЕХНИКИ С КОНТРОЛЕМ КОЛЛИЗИЙ
    // =============================================
    private _spawnPos = getMarkerPos vehicleShop_spawnMarker;
    private _spawnDir = markerDir vehicleShop_spawnMarker;
    
    private _safePos = [_spawnPos, 0, 30, 7, 0, 0.7, 0, [], [_spawnPos, _spawnPos]] call BIS_fnc_findSafePos;
    
    if (_safePos isEqualTo [] || {_safePos distance _spawnPos > 50}) then {
        _safePos = _spawnPos;
        ["Не удалось найти свободное место"] remoteExec ["systemChat", _player];
    };
    
    private _veh = createVehicle [_className, _safePos, [], 0, "CAN_COLLIDE"];
    _veh setDir _spawnDir;
    _veh setPosATL [_safePos select 0, _safePos select 1, 0];

    // =============================================
    // 3. СИСТЕМА МАРКЕРОВ (ПОЛНАЯ ВЕРСИЯ)
    // =============================================
    private _playerName = name _player;
    private _markerName = format ["shop_veh_%1_%2", _playerName, round (random 10000)];
    
    createMarker [_markerName, _safePos];
    _markerName setMarkerType "mil_box";
    _markerName setMarkerColor "ColorRed";
    _markerName setMarkerText format ["%1 (%2)", _displayName, _playerName];
    _markerName setMarkerSize [0.7, 0.7];
    
    _veh setVariable ["d_shop_marker", _markerName, true];
    _veh setVariable ["d_shop_owner", _playerName, true];
    _veh setVariable ["d_is_destroyed", false, true];
    _veh setVariable ["d_has_crew", false, true];

    // --------------------------------------------
    // 3.1 ОБРАБОТЧИКИ СОСТОЯНИЯ
    // --------------------------------------------
    _veh addEventHandler ["GetIn", {
        params ["_veh"];
        _veh setVariable ["d_has_crew", true, true];
        private _markerName = _veh getVariable "d_shop_marker";
        if (!isNil "_markerName") then {
            _markerName setMarkerAlpha 0;
        };
    }];
    
    _veh addEventHandler ["GetOut", {
        params ["_veh"];
        _veh setVariable ["d_has_crew", false, true];
        private _markerName = _veh getVariable "d_shop_marker";
        if (!isNil "_markerName" && {damage _veh < 0.9}) then {
            _markerName setMarkerAlpha 1;
        };
    }];

    _veh addEventHandler ["Killed", {
        params ["_veh"];
        private _markerName = _veh getVariable "d_shop_marker";
        private _playerName = _veh getVariable "d_shop_owner";
        
        if (!isNil "_markerName") then {
            _markerName setMarkerColor "ColorBlack";
            _markerName setMarkerText format ["Разбитый %1 (%2)", 
                getText(configFile >> "CfgVehicles" >> typeOf _veh >> "displayName"),
                _playerName
            ];
            _markerName setMarkerAlpha 1;
            _veh setVariable ["d_is_destroyed", true, true];
        };
    }];

    // --------------------------------------------
    // 3.2 ОБРАБОТЧИК РЕМОНТА (ВАЖНО!)
    // --------------------------------------------
    _veh addEventHandler ["HandleDamage", {
        params ["_veh", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
        
        // Если техника была разбита и теперь ремонтируется
        if (_veh getVariable ["d_is_destroyed", false] && {_damage < 0.9}) then {
            private _markerName = _veh getVariable "d_shop_marker";
            private _playerName = _veh getVariable "d_shop_owner";
            
            if (!isNil "_markerName") then {
                _markerName setMarkerColor "ColorRed";
                _markerName setMarkerText format ["%1 (%2)", 
                    getText(configFile >> "CfgVehicles" >> typeOf _veh >> "displayName"),
                    _playerName
                ];
                _veh setVariable ["d_is_destroyed", false, true];
                diag_log format ["[VehicleShop] Техника %1 восстановлена после ремонта", typeOf _veh];
            };
        };
        
        _damage // Возвращаем стандартную обработку повреждений
    }];

    // =============================================
    // 4. СИСТЕМА БЛОКИРОВКИ (ПОЛНАЯ ВЕРСИЯ)
    // =============================================
    private _playerUID = getPlayerUID _player;
    _veh setVariable ["vehicle_owner", _playerUID, true];
    _veh setVariable ["vehicle_locked", false, true];
    
    // Функция добавления действия блокировки
    private _addLockAction = {
        params ["_veh"];
        
        _veh addAction [
            "<t color='#FFA500'>[Замок]</t> Открыть/Закрыть технику",
            {
                params ["_target", "_caller"];
                private _locked = _target getVariable ["vehicle_locked", false];
                private _owner = _target getVariable "vehicle_owner";
                
                if (getPlayerUID _caller == _owner) then {
                    _target setVariable ["vehicle_locked", !_locked, true];
                    _target lock _locked;
                    
                    hint parseText format [
                        "<t color='%1'>Техника %2</t>",
                        if (_locked) then {"#FF0000"} else {"#00FF00"},
                        if (_locked) then {"заблокирована"} else {"разблокирована"}
                    ];
                } else {
                    hint "Ключ от замка у хозяина техники!";
                };
            },
            nil,
            1.5,
            true,
            true,
            "",
            "alive _target && {player distance _target < 5}",
            5
        ];
    };
    
    // Добавляем действие сразу
    [_veh] call _addLockAction;
    
    // Восстановление действия после ремонта
    _veh addEventHandler ["HandleDamage", {
        params ["_veh", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
        
        if (_damage < 0.9 && {_veh getVariable ["d_is_destroyed", false]}) then {
            // Удаляем старые действия
            private _actions = _veh getVariable ["BIS_fnc_holdActionAdd", []];
            { _veh removeAction _x } forEach _actions;
            
            // Добавляем заново
            [_veh] call (_veh getVariable ["d_lock_action_fn", {}]);
            
            diag_log "[VehicleShop] Действие блокировки восстановлено после ремонта";
        };
        
        _damage
    }];
    
    // Сохраняем функцию для восстановления
    _veh setVariable ["d_lock_action_fn", _addLockAction];

    // =============================================
    // 5. СИСТЕМА ОБНОВЛЕНИЯ ПОЗИЦИИ МАРКЕРА
    // =============================================
    [_veh, _markerName] spawn {
        params ["_veh", "_markerName"];
        
        while {alive _veh || {!isNull _veh && {_veh getVariable ["d_is_destroyed", false]}}} do {
            if (!isNull _veh && {!(_veh getVariable ["d_has_crew", false])}) then {
                _markerName setMarkerPos (getPos _veh);
            };
            sleep 0.3;
        };
        
        if (markerType _markerName != "") then {
            deleteMarker _markerName;
        };
    };

    // =============================================
    // 6. ИНТЕГРАЦИЯ С СИСТЕМОЙ ПОДЦЕПКИ
    // =============================================
    _veh setVariable ["d_canbewlifted", true, true];
    _veh setVariable ["d_isspecialvec", true, true];
    
    // =============================================
    // 7. ФИНАЛЬНЫЕ ОПЕРАЦИИ
    // =============================================
    _player addScore -_cost;
    [parseText format ["<t color='#00FF00'>%1</t> создана", _displayName]] remoteExec ["hint", _player];
    
    diag_log format [
        "[VehicleShop] Игрок %1 (%2) купил %3 за %4 очков",
        _playerName,
        _playerUID,
        _className,
        _cost
    ];
};

// ====================== ИНИЦИАЛИЗАЦИЯ ИНТЕРФЕЙСА ======================

// Поиск информационных стоек на карте
if (isNil "vehicleShop_stands") then {
    vehicleShop_stands = allMissionObjects "Land_InfoStand_V2_F";
    if (count vehicleShop_stands == 0) then {
        vehicleShop_stands = [createVehicle ["Land_InfoStand_V2_F", getPosATL player, [], 0, "CAN_COLLIDE"]];
    };
};
// Добавление действия к стойкам
{
    _x call { removeAllActions _this; };
    _x addAction [
        "<t color='#FF0000'>[Магазин техники]</t>", 
        {
            if (hasInterface) then {
                createDialog "VehicleShopDialog";
                [] call vehicleShop_updateUI;
            };
        },
        nil, 1.5, true, true, "",
        "playerSide == east && (player distance _target) < 3", 5
    ];
    _x enableSimulation true;
    _x allowDamage false;
} forEach vehicleShop_stands;

// Публикация функций для сети
publicVariable "vehicleShop_getPlayerRank";
publicVariable "vehicleShop_getRankName";
publicVariable "vehicleShop_checkRank";
publicVariable "vehicleShop_updateDetails";
publicVariable "vehicleShop_updateUI";
publicVariable "vehicleShop_purchase";
publicVariable "vehicleShop_serverPurchase";
publicVariable "vehicleShop_toggleMode";
publicVariable "vehicleShop_getModIcon";

diag_log "[VehicleShop] Интерфейс готов";
// Клиентская часть - автообновление (исправлено моргание)
if (hasInterface) then {
    [] spawn {
        waitUntil {!isNull player};
        
        private _lastPoints = -1;
        private _lastRank = -1;
        
        while {true} do {
            if (!isNull (findDisplay 5000)) then {
                private _dialog = findDisplay 5000;
                private _currentPoints = score player;
                private _currentRank = [player] call vehicleShop_getPlayerRank;
                // Обновляем только если значения изменились
                if (_currentPoints != _lastPoints || _currentRank != _lastRank) then {
                    private _pointsText = _dialog displayCtrl 5003;
                    _pointsText ctrlSetText format [
                        "ОЧКИ: %1 | ЗВАНИЕ: %2", 
                        _currentPoints, 
                        [_currentRank] call vehicleShop_getRankName
                    ];
                    
                    _lastPoints = _currentPoints;
                    _lastRank = _currentRank;
                    
                // Обновляем цвета доступности
                    private _vehicleList = _dialog displayCtrl 5001;
                    for "_i" from 0 to (lbSize _vehicleList - 1) do {
                        private _cost = _vehicleList lbValue _i;
                        private _vehicleData = vehicleShop_vehicles select _i;
                        
                        if (count _vehicleData >= 4) then {
                            private _requiredRank = _vehicleData select 3;
                            private _available = [player, _requiredRank] call vehicleShop_checkRank && (_currentPoints >= _cost);
                            _vehicleList lbSetColor [_i, if (_available) then {[0.8,1,0.8,1]} else {[1,0.3,0.3,0.7]}];
                        };
                    };
                };
            } else {
                // Сбрасываем кэш при закрытии диалога
                _lastPoints = -1;
                _lastRank = -1;
            };
            sleep 0.5; // Увеличили интервал проверки
        };
    };
};