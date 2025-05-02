// Инициализация магазина
[] spawn {
    waitUntil {!isNil "vehicleShop_configLoaded"};
    
    if (count vehicleShop_stands == 0) then {
        diag_log "[VehicleShop] Ошибка: не найдено стоек!";
    } else {
        // Компилируем обработчик UI
        vehicleShop_uiHandler = compile preprocessFileLineNumbers "scripts\vehicleShop\vehicleShop_uiHandler.sqf";
        
        // Добавляем действия к стойкам
        {
            _x addAction [
                "<t color='#00FFFF'>[Магазин техники]</t>",
                {
                    createDialog "VehicleShopDialog";
                    private _dialog = uiNamespace getVariable "VehicleShopDialog";
                    
                    // Заполняем список техники
                    private _vehicleList = _dialog displayCtrl 5001;
                    lbClear _vehicleList;
                    {
                        _x params ["_class","_cost","_name"];
                        private _idx = _vehicleList lbAdd _name;
                        _vehicleList lbSetData [_idx, _class];
                        _vehicleList lbSetValue [_idx, _cost];
                    } forEach vehicleShop_vehicles;
                    
                    // Обновляем очки
                    private _pointsText = _dialog displayCtrl 5003;
                    _pointsText ctrlSetText format ["Очков: %1", [player] call vehicleShop_getPoints];
                    
                    // Выбираем первый элемент
                    _vehicleList lbSetCurSel 0;
                },
                nil,
                1.5,
                true,
                true,
                "",
                "true",
                5
            ];
            
            _x enableSimulation true;
            _x allowDamage false;
        } forEach vehicleShop_stands;
        
        diag_log "[VehicleShop] Магазин успешно инициализирован";
    };
};