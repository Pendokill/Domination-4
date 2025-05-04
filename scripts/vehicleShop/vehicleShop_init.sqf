/*
    vehicleShop_init.sqf
    Финальная версия с исправлениями:
    - Не моргает звание в интерфейсе
    - Цветное выделение сообщений
    - Новые пороги очков для званий
*/

// Ждем загрузки необходимых переменных
waitUntil {!isNil "vehicleShop_configLoaded" && !isNil "vehicleShop_vehicles"};

diag_log "[VehicleShop] Начало инициализации магазина техники";

// Массив названий званий в правильном порядке
vehicleShop_rankNames = ["Рядовой","Ефрейтор","Сержант","Лейтенант","Капитан","Майор","Полковник","Генерал"];

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
            _rankIndex = switch (true) do {
                case (_rankStr == "dom_private"): {0};
                case (_rankStr == "dom_corporal"): {1};
                case (_rankStr == "dom_sergeant"): {2};
                case (_rankStr == "dom_lieutenant"): {3};
                case (_rankStr == "dom_captain"): {4};
                case (_rankStr == "dom_major"): {5};
                case (_rankStr == "dom_colonel"): {6};
                case (_rankStr == "dom_general"): {7};
                default {0};
            };
        } else {
            // 3. Если ничего не найдено, используем score для определения ранга
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
    _rankIndex = (_rankIndex max 0) min 7;
    
    _rankIndex
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
    private _currentRank = [_player] call vehicleShop_getPlayerRank;
    _currentRank >= _requiredRankIndex
};

/*
    Функция обновления деталей техники
*/
vehicleShop_updateDetails = {
    params ["_control", "_selectedIndex"];
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {};
    
    private _detailsCtrl = _dialog displayCtrl 5004;
    private _vehicleData = vehicleShop_vehicles select _selectedIndex;
    
    _vehicleData params ["_className", "_cost", "_displayName", "_requiredRankIndex"];
    
    // Получаем данные из конфига
    private _config = configFile >> "CfgVehicles" >> _className;
    private _maxSpeed = getNumber(_config >> "maxSpeed");
    private _armor = getNumber(_config >> "armor");
    private _crew = getText(_config >> "crew");
    private _picture = getText(_config >> "picture");
    private _desc = getText(_config >> "Library" >> "libTextDesc");
    
    // Проверяем доступность по рангу
    private _rankCheck = [player, _requiredRankIndex] call vehicleShop_checkRank;
    private _requiredRankName = [_requiredRankIndex] call vehicleShop_getRankName;
    private _rankColor = if (_rankCheck) then {"#00FF00"} else {"#FF0000"};
    
    // Формируем текст описания
    _detailsCtrl ctrlSetStructuredText parseText format [
        "<t font='RobotoCondensed' size='1.8'>
        <img image='%5' size='5' align='center'/><br/><br/>
        <t font='RobotoCondensedBold' size='2'>%1</t><br/><br/>
        <t color='#FFD700'>Цена: %2 очков</t><br/>
        <t color='%9'>▸ Требуется звание: %8</t><br/><br/>
        ▸ Скорость: %3 км/ч<br/>
        ▸ Броня: %4<br/>
        ▸ Экипаж: %6<br/><br/>
        %7</t>",
        _displayName, _cost, _maxSpeed, _armor, _picture, _crew, _desc, _requiredRankName, _rankColor
    ];
};

/*
    Функция обновления интерфейса
    с исправлением моргания звания
*/
vehicleShop_updateUI = {
    if (!hasInterface) exitWith {};
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {};
    
    private _vehicleList = _dialog displayCtrl 5001;
    lbClear _vehicleList;
    
    // Получаем актуальные данные игрока один раз
    private _currentPoints = score player;
    private _currentRankIndex = [player] call vehicleShop_getPlayerRank;
    private _currentRankName = [_currentRankIndex] call vehicleShop_getRankName;
    
    // Обновляем отображение очков и звания (один раз)
    private _pointsText = _dialog displayCtrl 5003;
    _pointsText ctrlSetText format ["ОЧКИ: <t color='#FFD700'>%1</t> | ЗВАНИЕ: <t color='#00FF00'>%2</t>", 
        _currentPoints, 
        _currentRankName
    ];
    
    // Заполняем список техники
    {
        _x params ["_className", "_cost", "_displayName", "_requiredRankIndex"];
        private _picture = getText(configFile >> "CfgVehicles" >> _className >> "picture");
        private _index = _vehicleList lbAdd format ["▸ %1", _displayName];
        
        _vehicleList lbSetData [_index, _className];
        _vehicleList lbSetValue [_index, _cost];
        _vehicleList lbSetPicture [_index, _picture];
        
        // Проверяем доступность
        private _rankCheck = [player, _requiredRankIndex] call vehicleShop_checkRank;
        private _pointsCheck = _currentPoints >= _cost;
        
        if (_rankCheck && _pointsCheck) then {
            _vehicleList lbSetColor [_index, [0.8, 1, 0.8, 1]]; // Доступно
        } else {
            _vehicleList lbSetColor [_index, [1, 0.3, 0.3, 0.7]]; // Недоступно
        };
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
        hint "Ошибка: диалог не найден";
    };
    
    private _vehicleList = _dialog displayCtrl 5001;
    private _selectedIndex = lbCurSel _vehicleList;
    
    if (_selectedIndex == -1) exitWith {
        hint "Выберите технику из списка!";
    };
    
    private _className = _vehicleList lbData _selectedIndex;
    private _cost = _vehicleList lbValue _selectedIndex;
    private _currentPoints = score player;
    private _vehicleData = vehicleShop_vehicles select _selectedIndex;
    private _requiredRankIndex = _vehicleData select 3;
    private _requiredRankName = [_requiredRankIndex] call vehicleShop_getRankName;
    private _displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
    
    // Проверка ранга
    private _playerRankIndex = [player] call vehicleShop_getPlayerRank;
    private _rankCheck = [player, _requiredRankIndex] call vehicleShop_checkRank;
    
    if (!_rankCheck) exitWith {
        hint parseText format [
            "Требуется звание: <t color='#00FF00'>%1</t><br/>Ваше звание: <t color='#00FF00'>%2</t><br/>Ваши очки: <t color='#00FF00'>%3</t>",
            _requiredRankName, 
            [_playerRankIndex] call vehicleShop_getRankName,
            _currentPoints
        ];
    };
    
    if (_currentPoints < _cost) exitWith {
        hint parseText format [
            "Недостаточно очков!<br/>Нужно: <t color='#00FF00'>%1</t><br/>У вас: <t color='#00FF00'>%2</t>", 
            _cost, 
            _currentPoints
        ];
    };
    
    [player, _cost, _className] remoteExec ["vehicleShop_serverPurchase", 2];
    hint parseText format ["Техника <t color='#FFD700'>%1</t> успешно куплена!", _displayName];
};

/*
    Функция покупки техники (серверная часть)
    с цветным выделением сообщений
*/
vehicleShop_serverPurchase = {
    params ["_player", "_cost", "_className"];
    
    if (!isServer) exitWith {
        _this remoteExec ["vehicleShop_serverPurchase", 2];
    };
    
    // Находим технику в списке
    private _vehicleIndex = -1;
    {
        if ((_x select 0) == _className) exitWith { _vehicleIndex = _forEachIndex };
    } forEach vehicleShop_vehicles;
    
    if (_vehicleIndex == -1) exitWith {
        ["Ошибка: техника не найдена"] remoteExec ["hint", _player];
    };
    
    // Проверяем ранг на сервере
    private _requiredRankIndex = (vehicleShop_vehicles select _vehicleIndex) select 3;
    private _rankCheck = [_player, _requiredRankIndex] call vehicleShop_checkRank;
    
    if (!_rankCheck) exitWith {
        private _playerRankIndex = [_player] call vehicleShop_getPlayerRank;
        [parseText format [
            "Требуется звание: <t color='#00FF00'>%1</t><br/>Ваше звание: <t color='#00FF00'>%2</t>",
            [_requiredRankIndex] call vehicleShop_getRankName,
            [_playerRankIndex] call vehicleShop_getRankName
        ]] remoteExec ["hint", _player];
    };
    
    // Проверяем очки
    if (score _player < _cost) exitWith {
        [parseText format [
            "Недостаточно очков!<br/>Нужно: <t color='#00FF00'>%1</t><br/>У вас: <t color='#00FF00'>%2</t>",
            _cost,
            score _player
        ]] remoteExec ["hint", _player];
    };
    
    // Списание очков и создание техники
    _player addScore -_cost;
    private _spawnPos = getMarkerPos vehicleShop_spawnMarker;
    private _vehicle = createVehicle [_className, _spawnPos, [], 0, "CAN_COLLIDE"];
    _vehicle setDir (markerDir vehicleShop_spawnMarker);
    
    // Уведомление игрока с цветным выделением
    private _displayName = getText(configFile >> "CfgVehicles" >> _className >> "displayName");
    [parseText format ["Техника <t color='#FFD700'>%1</t> успешно куплена!", _displayName]] remoteExec ["hint", _player];
};

// ====================== ИНИЦИАЛИЗАЦИЯ МАГАЗИНА ======================

// Поиск информационных стоек на карте
if (isNil "vehicleShop_stands") then {
    vehicleShop_stands = allMissionObjects "Land_InfoStand_V2_F";
    
    if (count vehicleShop_stands == 0) then {
        private _pos = getPosATL player;
        vehicleShop_stands = [createVehicle ["Land_InfoStand_V2_F", [_pos select 0, _pos select 1, 0], [], 0, "CAN_COLLIDE"]];
    };
};

// Добавление действия к стойкам
{
    private _stand = _x;
    _stand call { removeAllActions _this; };
    
    _stand addAction [
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
    
    _stand enableSimulation true;
    _stand allowDamage false;
} forEach vehicleShop_stands;

// Публикация функций для сети
publicVariable "vehicleShop_getPlayerRank";
publicVariable "vehicleShop_getRankName";
publicVariable "vehicleShop_checkRank";
publicVariable "vehicleShop_updateDetails";
publicVariable "vehicleShop_updateUI";
publicVariable "vehicleShop_purchase";
publicVariable "vehicleShop_serverPurchase";

diag_log "[VehicleShop] Инициализация завершена";

// Клиентская часть - автообновление (исправлено моргание)
if (hasInterface) then {
    [] spawn {
        waitUntil {!isNull player};
        
        // Кэшируем предыдущие значения
        private _lastPoints = -1;
        private _lastRank = -1;
        
        while {true} do {
            if (!isNull (findDisplay 5000)) then {
                private _dialog = findDisplay 5000;
                private _currentPoints = score player;
                private _currentRankIndex = [player] call vehicleShop_getPlayerRank;
                
                // Обновляем только если значения изменились
                if (_currentPoints != _lastPoints || _currentRankIndex != _lastRank) then {
                    private _pointsText = _dialog displayCtrl 5003;
                    private _currentRankName = [_currentRankIndex] call vehicleShop_getRankName;
                    
                    _pointsText ctrlSetText format ["ОЧКИ: <t color='#FFD700'>%1</t> | ЗВАНИЕ: <t color='#00FF00'>%2</t>", 
                        _currentPoints, 
                        _currentRankName
                    ];
                    
                    _lastPoints = _currentPoints;
                    _lastRank = _currentRankIndex;
                };
                
                // Обновляем цвета доступности
                private _vehicleList = _dialog displayCtrl 5001;
                for "_i" from 0 to (lbSize _vehicleList - 1) do {
                    private _cost = _vehicleList lbValue _i;
                    private _vehicleData = vehicleShop_vehicles select _i;
                    private _requiredRankIndex = _vehicleData select 3;
                    
                    private _rankCheck = [player, _requiredRankIndex] call vehicleShop_checkRank;
                    private _pointsCheck = score player >= _cost;
                    
                    if (_rankCheck && _pointsCheck) then {
                        _vehicleList lbSetColor [_i, [0.8, 1, 0.8, 1]];
                    } else {
                        _vehicleList lbSetColor [_i, [1, 0.3, 0.3, 0.7]];
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