// Конфигурация магазина техники
vehicleShop_vehicles = [];
vehicleShop_spawnMarker = "vehicle_spawn";
vehicleShop_configLoaded = true;

// Функция кастомных цен
vehicleShop_customPrices = {
    params ["_vehicles"];
    
    {
        _className = _x select 0;
        switch (true) do {
            // RHS
            case (_className == "rhs_t90a_tv"): { _x set [1, 700] };
            case (_className == "rhs_bmp2_msv"): { _x set [1, 150] };
            case (_className find "mi8" != -1):  { _x set [1, (_x select 1) * 1.2] };
            
            // SCAT
            case (_className == "scat_btr80_woodland"): { _x set [1, 220] };
            
            // min RF
            case (_className == "min_rf_sa_22"): { _x set [1, 1200] };
			case (_className == "min_rf_t_14_desert"): { _x set [1, 900] };
			case (_className == "min_rf_t_15_desert"): { _x set [1, 900] };
        };
    } forEach _vehicles;
    
    _vehicles
};

// Основная функция фильтрации
vehicleShop_filterVehicles = {
    params ["_allVehicles"];
    private _filtered = [];
    
    private _allowedMods = ["rhs_", "min_rf_", "scat_"];
    private _allowedCategories = ["Armored", "Car", "Air", "Tank"]; //"Support", 
    private _blacklist = ["rhs_2s3_tv", "rhs_bm21_MSV_01"];
    
    {
        _className = _x;
        _config = configFile >> "CfgVehicles" >> _className;
        
        _modAllowed = false;
        { if (_className find _x == 0) exitWith { _modAllowed = true }; } forEach _allowedMods;
        
        if (
            _modAllowed &&
            getNumber(_config >> "scope") == 2 &&
            {getText(_config >> "vehicleClass") in _allowedCategories} &&
            {!(_className in _blacklist)} &&
            {getText(_config >> "faction") in ["rhs_faction_msv", "rhs_faction_vdv"]}
        ) then {
            _displayName = getText(_config >> "displayName");
            
            // Исправленный расчет стоимости:
            _cost = round (
                (getNumber(_config >> "armor") * 0.8) +
                (getNumber(_config >> "enginePower") * 0.2) +
                (getNumber(_config >> "maximumLoad") * 0.05)
            );
            
            _cost = (_cost max 10) min 2000;
            
            _filtered pushBack [_className, _cost, _displayName];
        };
    } forEach _allVehicles;
    
    _filtered sort true;
    _filtered
};

// Серверная инициализация
if (isServer) then {
    _allVehicleClasses = "(configName _x) isKindOf 'AllVehicles'" configClasses (configFile >> "CfgVehicles") apply {configName _x};
    
    vehicleShop_vehicles = [_allVehicleClasses] call vehicleShop_filterVehicles;
    vehicleShop_vehicles = [vehicleShop_vehicles] call vehicleShop_customPrices;
    
    publicVariable "vehicleShop_vehicles";
    diag_log format ["[VehicleShop] Загружено %1 единиц техники", count vehicleShop_vehicles];
};

// Убедимся, что клиенты получат данные
if (isServer) then {
    [] spawn {
        sleep 1;
        publicVariable "vehicleShop_vehicles";
        publicVariable "vehicleShop_stands";
        diag_log "[VehicleShop] Данные синхронизированы с клиентами";
    };
};