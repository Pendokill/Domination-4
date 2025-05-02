if (!hasInterface) exitWith {};

disableSerialization;

// Ждем готовности данных
waitUntil {
    !isNull (findDisplay 46) && 
    !isNil "vehicleShop_vehicles" && 
    !isNil "d_player_hash"
};

// Создаем диалог
createDialog "VehicleShopDialog";
private _dialog = findDisplay 5000;

if (isNull _dialog) exitWith {
    systemChat "Ошибка: не удалось создать меню магазина";
    diag_log "[VehicleShop] Ошибка создания диалога";
};

// Функция обновления интерфейса
vehicleShop_updateUI = {
    params ["_dialog"];
    
    // Заполняем список техники
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

// Первоначальное заполнение
[_dialog] call vehicleShop_updateUI;

// Цикл обновления интерфейса
[_dialog] spawn {
    params ["_dialog"];
    while {!isNull _dialog} do {
        [_dialog] call vehicleShop_updateUI;
        sleep 0.5;
    };
};

diag_log "[VehicleShop] Магазин успешно открыт";