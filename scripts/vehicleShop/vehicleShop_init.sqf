waitUntil {!isNil "vehicleShop_configReady"};

// Функция для отладки
vehicleShop_logError = {
    params ["_message"];
    diag_log _message;
    systemChat _message;
};

// Проверка загрузки данных
if (isNil "vehicleShop_vehicles" || {count vehicleShop_vehicles == 0}) then {
    ["[VehicleShop] Ошибка: массив техники не загружен!"] call vehicleShop_logError;
    vehicleShop_vehicles = [
        ["B_MRAP_01_F", 50, "HMMWV (аварийный режим)"],
        ["B_Truck_01_transport_F", 75, "Грузовик (аварийный режим)"]
    ];
};

// Основная функция открытия магазина
vehicleShop_open = {
    if (!hasInterface) exitWith {};
    
    createDialog "VehicleShopDialog";
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {
        ["[VehicleShop] Не удалось создать диалог"] call vehicleShop_logError;
    };
    
    private _vehicleList = _dialog displayCtrl 5001;
    lbClear _vehicleList;
    
    // Принудительное заполнение списка
    {
        _x params ["_class","_cost","_name"];
        private _index = _vehicleList lbAdd _name;
        _vehicleList lbSetData [_index, _class];
        _vehicleList lbSetValue [_index, _cost];
        diag_log format ["[VehicleShop] Добавлено: %1", _name];
    } forEach vehicleShop_vehicles;
    
    // Принудительный выбор первого элемента
    if (lbSize _vehicleList > 0) then {
        _vehicleList lbSetCurSel 0;
    } else {
        ["[VehicleShop] Список техники пуст!"] call vehicleShop_logError;
    };
};

// Остальные функции остаются без изменений
vehicleShop_purchase = { /* ... */ };
vehicleShop_updateDetails = { /* ... */ };

// Добавление действий к стойкам
{
    _x addAction [
        "<t color='#00FF00'>[Магазин техники]</t>", 
        { [] call vehicleShop_open; },
        nil,
        1.5,
        true,
        true,
        "",
        "true",
        5
    ];
} forEach vehicleShop_stands;

["[VehicleShop] Инициализация завершена"] call vehicleShop_logError;