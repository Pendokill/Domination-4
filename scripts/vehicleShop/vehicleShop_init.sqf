/*
    vehicleShop_init.sqf
    Основной скрипт инициализации магазина техники
    Содержит все основные функции и логику работы
*/

// Ждем загрузки необходимых переменных
waitUntil {!isNil "vehicleShop_configLoaded" && !isNil "vehicleShop_vehicles"};

diag_log "[VehicleShop] Начало инициализации магазина техники";

// ====================== ОСНОВНЫЕ ФУНКЦИИ ======================

/*
    Функция получения текущих очков игрока
    Параметры:
        _player - объект игрока
    Возвращает:
        Количество очков (score)
*/
vehicleShop_getPoints = {
    params ["_player"];
    score _player
};

/*
    Функция обновления деталей техники
    Параметры:
        _control - контрол списка
        _selectedIndex - индекс выбранной техники
*/
vehicleShop_updateDetails = {
    params ["_control", "_selectedIndex"];
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {};
    
    private _detailsCtrl = _dialog displayCtrl 5004;
    private _vehicleData = vehicleShop_vehicles select _selectedIndex;
    
    // Получаем данные о технике
    private _className = _vehicleData select 0;
    private _cost = _vehicleData select 1;
    private _displayName = _vehicleData select 2;
    
    // Получаем параметры из конфига
    private _config = configFile >> "CfgVehicles" >> _className;
    private _maxSpeed = getNumber(_config >> "maxSpeed");
    private _armor = getNumber(_config >> "armor");
    private _crew = getText(_config >> "crew");
    private _picture = getText(_config >> "picture");
    private _desc = getText(_config >> "Library" >> "libTextDesc");
    
    // Форматируем текст описания
    _detailsCtrl ctrlSetStructuredText parseText format [
        "<t font='RobotoCondensed' size='1.8'>
        <img image='%5' size='5' align='center'/><br/><br/>
        <t font='RobotoCondensedBold' size='2'>%1</t><br/><br/>
        <t color='#FFD700'>Цена: %2 очков</t><br/><br/>
        ▸ Скорость: %3 км/ч<br/>
        ▸ Броня: %4<br/>
        ▸ Экипаж: %6<br/><br/>
        %7</t>",
        _displayName, _cost, _maxSpeed, _armor, _picture, _crew, _desc
    ];
};

/*
    Функция покупки техники (клиентская часть)
*/
vehicleShop_purchase = {
    if (!hasInterface) exitWith {}; // Только для клиентов
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {
        hint "Ошибка: диалог не найден";
        diag_log "[VehicleShop] Ошибка покупки: диалог не найден";
    };
    
    private _vehicleList = _dialog displayCtrl 5001;
    private _selectedIndex = lbCurSel _vehicleList;
    
    // Проверка выбора техники
    if (_selectedIndex == -1) exitWith {
        hint "Выберите технику из списка!";
        diag_log "[VehicleShop] Покупка: техника не выбрана";
    };
    
    private _className = _vehicleList lbData _selectedIndex;
    private _cost = _vehicleList lbValue _selectedIndex;
    private _currentPoints = score player;
    
    // Проверка очков
    if (_currentPoints < _cost) exitWith {
        hint format ["Недостаточно очков! Нужно: %1 (У вас: %2)", _cost, _currentPoints];
        diag_log format ["[VehicleShop] Недостаточно очков у %1: нужно %2, есть %3", 
            name player, _cost, _currentPoints];
    };
    
    // Отправка запроса на сервер
    [player, _cost, _className] remoteExec ["vehicleShop_serverPurchase", 2];
    hint "Обработка покупки...";
    diag_log format ["[VehicleShop] Запрос покупки: %1 за %2 очков", _className, _cost];
};

/*
    Функция покупки техники (серверная часть)
*/
vehicleShop_serverPurchase = {
    params ["_player", "_cost", "_className"];
    
    if (!isServer) exitWith {
        _this remoteExec ["vehicleShop_serverPurchase", 2]; // Перенаправляем на сервер
    };

    private _uid = getPlayerUID _player;
    private _currentPoints = score _player;
    
    // Дополнительная проверка очков (защита от читов)
    if (_currentPoints < _cost) exitWith {
        [format ["Недостаточно очков! Нужно: %1 (у вас: %2)", _cost, _currentPoints]] remoteExec ["hint", _player];
        diag_log format ["[VehicleShop] Отказ в покупке: у %1 (%2) недостаточно очей (%3 < %4)", 
            name _player, _uid, _currentPoints, _cost];
    };
    
    // Списание очков
    _player addScore -_cost;
    
    // Спавн техники
    private _spawnPos = getMarkerPos vehicleShop_spawnMarker;
    private _spawnDir = markerDir vehicleShop_spawnMarker;
    private _vehicle = createVehicle [_className, _spawnPos, [], 0, "CAN_COLLIDE"];
    _vehicle setDir _spawnDir;
    _vehicle setPosATL _spawnPos;
    
    // Уведомление игрока
    [format ["Техника %1 успешно куплена!", getText(configFile >> "CfgVehicles" >> _className >> "displayName")]] remoteExec ["hint", _player];
    diag_log format ["[VehicleShop] %1 купил %2 за %3 очков", name _player, _className, _cost];
    
    // Обновление интерфейса у игрока
    [] remoteExec ["vehicleShop_updateUI", _player];
};

/*
    Функция обновления интерфейса
*/
vehicleShop_updateUI = {
    if (!hasInterface) exitWith {}; // Только для клиентов
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {};
    
    private _vehicleList = _dialog displayCtrl 5001;
    lbClear _vehicleList; // Очищаем список
    
    private _currentPoints = score player;
    
    // Заполняем список техники
    {
        _x params ["_className", "_cost", "_displayName"];
        private _picture = getText(configFile >> "CfgVehicles" >> _className >> "picture");
        private _index = _vehicleList lbAdd format ["▸ %1", _displayName];
        
        // Устанавливаем данные
        _vehicleList lbSetData [_index, _className];
        _vehicleList lbSetValue [_index, _cost];
        _vehicleList lbSetPicture [_index, _picture];
        
        // Подсветка в зависимости от доступности
        if (_currentPoints >= _cost) then {
            _vehicleList lbSetColor [_index, [0.8, 1, 0.8, 1]]; // Зеленый - доступно
        } else {
            _vehicleList lbSetColor [_index, [1, 0.3, 0.3, 0.7]]; // Красный - недоступно
            _vehicleList lbSetTooltip [_index, format ["Требуется %1 очей", _cost]];
        };
    } forEach vehicleShop_vehicles;
    
    // Обновляем отображение очков
    private _pointsText = _dialog displayCtrl 5003;
    _pointsText ctrlSetText format ["ВАШ СЧЁТ: %1", _currentPoints];
    
    // Автовыбор первой техники в списке
    if (lbSize _vehicleList > 0) then {
        _vehicleList lbSetCurSel 0;
        [_vehicleList, 0] call vehicleShop_updateDetails;
    };
};

// ====================== ИНИЦИАЛИЗАЦИЯ МАГАЗИНА ======================

// Поиск информационных стоек на карте
if (isNil "vehicleShop_stands") then {
    vehicleShop_stands = allMissionObjects "Land_InfoStand_V2_F";
    diag_log format ["[VehicleShop] Найдено стоек: %1", count vehicleShop_stands];
    
    // Создание резервной стойки если не найдено
    if (count vehicleShop_stands == 0) then {
        private _pos = getPosATL player;
        vehicleShop_stands = [createVehicle ["Land_InfoStand_V2_F", [_pos select 0, _pos select 1, 0], [], 0, "CAN_COLLIDE"]];
        diag_log "[VehicleShop] Создана резервная стойка";
    };
};

// Добавление действия к стойкам
{
    private _stand = _x;
    
    // Удаляем старые действия (если есть)
    _stand call {
        removeAllActions _this;
    };
    
    // Добавляем новое действие
    _stand addAction [
        "<t color='#FF0000'>[Магазин техники]</t>", 
        {
            if (hasInterface) then {
                createDialog "VehicleShopDialog";
                [] call vehicleShop_updateUI;
            };
        },
        nil, // Аргументы
        1.5, // Приоритет
        true, // Показывать в меню
        true, // Показывать на дистанции
        "", // Условие показа (дополнительно проверяем ниже)
        "playerSide == east && (player distance _target) < 3", // Условие стороны и видимости
        5 // Дистанция показа
    ];
    
    // Настройки стойки
    _stand enableSimulation true;
    _stand allowDamage false;
} forEach vehicleShop_stands;

// Публикация функций для сети
publicVariable "vehicleShop_getPoints";
publicVariable "vehicleShop_updateDetails";
publicVariable "vehicleShop_purchase";
publicVariable "vehicleShop_serverPurchase";
publicVariable "vehicleShop_updateUI";

diag_log "[VehicleShop] Инициализация завершена";

// Клиентская часть - автообновление очков
if (hasInterface) then {
    [] spawn {
        waitUntil {!isNull player};
        
        while {true} do {
            if (!isNull (findDisplay 5000)) then {
                private _dialog = findDisplay 5000;
                private _pointsText = _dialog displayCtrl 5003;
                _pointsText ctrlSetText format ["ОЧКИ: %1", score player];
                
                // Обновляем цвета доступности техники
                private _vehicleList = _dialog displayCtrl 5001;
                for "_i" from 0 to (lbSize _vehicleList - 1) do {
                    private _cost = _vehicleList lbValue _i;
                    if (score player >= _cost) then {
                        _vehicleList lbSetColor [_i, [0.8, 1, 0.8, 1]]; // Зеленый
                    } else {
                        _vehicleList lbSetColor [_i, [1, 0.3, 0.3, 0.7]]; // Красный
                    };
                };
            };
            sleep 1; // Проверка каждую секунду
        };
    };
};