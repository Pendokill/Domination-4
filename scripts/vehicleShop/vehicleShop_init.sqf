waitUntil {!isNil "vehicleShop_configLoaded" && !isNil "vehicleShop_vehicles"};

diag_log "[VehicleShop] Начало инициализации магазина техники";

// Определяем функцию обновления UI
vehicleShop_updateUI = {
    if (!hasInterface) exitWith {};
    
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith {
        diag_log "[VehicleShop] Ошибка: диалог не найден для обновления UI";
    };
    
    private _vehicleList = _dialog displayCtrl 5001;
    lbClear _vehicleList;
    
    {
        _x params ["_className", "_cost", "_displayName"];
        private _picture = getText(configFile >> "CfgVehicles" >> _className >> "picture");
        private _index = _vehicleList lbAdd format ["▸ %1", _displayName];
        _vehicleList lbSetData [_index, _className];
        _vehicleList lbSetValue [_index, _cost];
        _vehicleList lbSetPicture [_index, _picture];
        _vehicleList lbSetColor [_index, if (score player >= _cost) then {[1,1,1,1]} else {[1,0.3,0.3,0.7]}];
    } forEach vehicleShop_vehicles;
    
    private _pointsText = _dialog displayCtrl 5003;
    _pointsText ctrlSetText format ["ОЧКИ: %1", score player];
    
    if (lbSize _vehicleList > 0) then {
        _vehicleList lbSetCurSel 0;
        [_vehicleList, 0] call vehicleShop_updateDetails;
    };
    
    diag_log "[VehicleShop] UI успешно обновлен";
};

// Функция обновления деталей
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
    private _maxSpeed = getNumber(_config >> "maxSpeed");
    private _armor = getNumber(_config >> "armor");
    private _crew = getText(_config >> "crew");
    private _picture = getText(_config >> "picture");
    private _desc = getText(_config >> "Library" >> "libTextDesc");
    
    _detailsCtrl ctrlSetStructuredText parseText format [
        "<t font='RobotoCondensed' size='1.8'><img image='%5' size='6' align='center'/><br/><br/>" +
        "<t font='RobotoCondensedBold' size='2'>%1</t><br/>" +
        "<t color='#FFD700'>Цена: %2 очей</t><br/><br/>" +
        "▸ Скорость: %3 км/ч<br/>" +
        "▸ Броня: %4<br/>" +
        "▸ Экипаж: %6<br/><br/>" +
        "%7</t>",
        _displayName, _cost, _maxSpeed, _armor, _picture, _crew, _desc
    ];
};

// Проверяем наличие стоек
if (isNil "vehicleShop_stands") then {
    vehicleShop_stands = allMissionObjects "Land_InfoStand_V2_F";
    diag_log format ["[VehicleShop] Найдено стоек: %1", count vehicleShop_stands];
    
    if (count vehicleShop_stands == 0) then {
        private _pos = getPosATL player;
        _pos = [_pos select 0, _pos select 1, 0];
        vehicleShop_stands = [createVehicle ["Land_InfoStand_V2_F", _pos, [], 0, "CAN_COLLIDE"]];
        diag_log "[VehicleShop] Создана резервная стойка";
        publicVariable "vehicleShop_stands";
    };
};

// Функция открытия магазина
vehicleShop_openMenu = {
    if (!hasInterface) exitWith {};
    
    diag_log "[VehicleShop] Попытка открытия меню";
    
    waitUntil {!isNull (findDisplay 46)};
    createDialog "VehicleShopDialog";
    
    if (isNull (findDisplay 5000)) then {
        diag_log "[VehicleShop] Ошибка: не удалось создать диалог";
        systemChat "Ошибка открытия меню магазина";
    } else {
        diag_log "[VehicleShop] Меню успешно открыто";
        [] call vehicleShop_updateUI;
    };
};

// Добавляем действие к стойкам
{
    private _stand = _x;
    diag_log format ["[VehicleShop] Добавление действия к стойке %1", _stand];
    
    // Удаляем старые действия перед добавлением новых
    _stand call {
        removeAllActions _this;
    };
    
    _stand addAction [
        "<t color='#FF0000'>[Магазин техники]</t>", 
        {
            [] spawn vehicleShop_openMenu;
        },
        nil, 1.5, true, true, "", 
        "playerSide == east && (player distance _target) < 3",
        5
    ];
    
    _stand enableSimulation true;
    _stand allowDamage false;
} forEach vehicleShop_stands;

// Публикация функций
publicVariable "vehicleShop_updateUI";
publicVariable "vehicleShop_updateDetails";
publicVariable "vehicleShop_openMenu";

diag_log format ["[VehicleShop] Инициализация завершена. Стоек: %1", count vehicleShop_stands];