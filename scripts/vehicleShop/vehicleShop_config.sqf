/*
    vehicleShop_config.sqf
    Конфигурация магазина техники
    Автоматическая загрузка техники с сервера
*/

// Основные переменные магазина
vehicleShop_vehicles = []; // Массив техники (будет заполнен автоматически)
vehicleShop_spawnMarker = "vehicle_spawn"; // Маркер для спавна техники
vehicleShop_configLoaded = true; // Флаг загрузки конфига

// Функция кастомных цен (должна быть объявлена ДО вызова)
vehicleShop_customPrices = {
    params ["_vehicles"];
    
    {
        _x params ["_className", "_cost", "_displayName"];
        
        // Примеры переопределения цен:
        switch (true) do {
            // RHS техника
            case (_className == "rhs_t72ba_tv"): { _x set [1, 350] }; // Т-72БА
            case (_className == "rhs_bmp2_msv"): { _x set [1, 180] }; // БМП-2
			case (_className == "rhs_t90sm_tv"): { _x set [1, 700] }; // Т-90
            case (_className == "rhs_t90am_tv"): { _x set [1, 700] }; // Т-90
			case (_className == "min_rf_sa_22"): { _x set [1, 1200] }; // Панцирь-С1
            case (_className == "min_rf_sa_22_desert"): { _x set [1, 1200] }; // Панцирь-С1
			case (_className == "min_rf_sa_22_winter"): { _x set [1, 1200] }; // Панцирь-С1
            case (_className == "min_rf_t_15"): { _x set [1, 950] }; // Т-15 Армата
			case (_className == "min_rf_t_15_desert"): { _x set [1, 950] }; // Т-15 Армата
            case (_className == "min_rf_t_15_winter"): { _x set [1, 950] }; // Т-15 Армата
            case (_className find "mi8" != -1): { _x set [1, (_x select 1) * 1.5] }; // Вертолеты +50%
            
            // SCAT техника
            case (_className == "scat_btr80_woodland"): { _x set [1, 120] };
            
            // CUP техника
            case (_className == "CUP_O_BMP2_RU"): { _x set [1, 200] };
            
            // Общее правило для танков
            case (getText(configFile >> "CfgVehicles" >> _className >> "vehicleClass") == "Tank"): {
                _x set [1, (_x select 1) * 1.2] // +20% к стоимости танков
            };
        };
    } forEach _vehicles;
    
    _vehicles
};

// Функция фильтрации техники
vehicleShop_filterVehicles = {
    params ["_allVehicleClasses"]; // Получаем все классы техники    
    private _filtered = []; // Отфильтрованный массив
    
    // Настройки фильтрации:
    private _allowedMods = ["rhsafrf_", "rhsusf_", "F_", "scat_", "min_rf_"]; // Разрешенные префиксы модов
    private _allowedCategories = ["Armored","Car","Air","Support","Tank"]; // Разрешенные категории
    private _blacklist = ["rhs_2s3_tv", "rhs_bm21_MSV_01"]; // Запрещенная техника
    
    // Фильтрация каждого класса техники
    {
        private _className = _x;
        private _config = configFile >> "CfgVehicles" >> _className;
        
        // Проверка принадлежности к разрешенным модам
        private _modAllowed = false;
        {
            if (_className find _x == 0) exitWith { _modAllowed = true; };
        } forEach _allowedMods;
        
        // Основные критерии отбора:
        if (
            _modAllowed && // Принадлежит разрешенным модам
            {getNumber(_config >> "scope") == 2} && // Доступен в игре
            {getText(_config >> "vehicleClass") in _allowedCategories} && // Подходящая категория
            {!(_className in _blacklist)} && // Не в черном списке
            {getText(_config >> "displayName") != ""} // Имеет название
        ) then {
            // Расчет стоимости на основе характеристик
            private _cost = round (
                (getNumber(_config >> "armor") * 0.8) +
                (getNumber(_config >> "enginePower") * 0.2) +
                (getNumber(_config >> "maximumLoad") * 0.05)
            );
            
            // Ограничение стоимости
            _cost = (_cost max 10) min 2000;
            
            // Добавляем в отфильтрованный массив
            _filtered pushBack [
                _className,
                _cost,
                getText(_config >> "displayName")
            ];
        };
    } forEach _allVehicleClasses;
    
    // Сортировка по цене (от дешевых к дорогим)
    _filtered sort true;
    
    _filtered // Возвращаем результат
};

// Серверная инициализация
if (isServer) then {
    private _allVehicleClasses = "(configName _x) isKindOf 'AllVehicles'" configClasses (configFile >> "CfgVehicles") apply {configName _x};
    
    // 1. Стандартная фильтрация
    vehicleShop_vehicles = [_allVehicleClasses] call vehicleShop_filterVehicles;
    
    // 2. Применение кастомных цен (ВАЖНО: после фильтрации!)
    vehicleShop_vehicles = [vehicleShop_vehicles] call vehicleShop_customPrices;
    
    // 3. Синхронизация
    publicVariable "vehicleShop_vehicles";
    diag_log format ["[VehicleShop] Загружено %1 единиц техники", count vehicleShop_vehicles];
    diag_log format ["[VehicleShop] Пример техники: %1", vehicleShop_vehicles select 0];
};