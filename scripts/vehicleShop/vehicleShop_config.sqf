/*
    vehicleShop_config.sqf
    Конфигурация с индексами званий 0-7
    Автоматическая загрузка техники с сервера
*/

// Основные переменные магазина
vehicleShop_vehicles = []; // Массив техники (будет заполнен автоматически)
vehicleShop_spawnMarker = "vehicle_spawn"; // Маркер для спавна техники
vehicleShop_configLoaded = true; // Флаг загрузки конфига

// Функция определения ранга для техники (возвращает индекс 0-7)
vehicleShop_getVehicleRank = {
    params ["_className", "_cost"];
    
    private _vehicleClass = getText(configFile >> "CfgVehicles" >> _className >> "vehicleClass");
    private _armor = getNumber(configFile >> "CfgVehicles" >> _className >> "armor");
    
        // Примеры переопределения звания:
    switch (true) do {
        // Легкая техника - Рядовой (0)
        case (_vehicleClass in ["Car"]): {0};
        // БТРы - Ефрейтор (1)
        case (_vehicleClass in ["Armored"] && _armor < 500): {1};
        // Тяжелая техника - Сержант (2)
        case (_vehicleClass in ["Armored"] && _armor >= 500): {2};
        // Танки - от Сержанта (2) до Лейтенанта (3)
        case (_vehicleClass == "Tank" && _cost < 500): {2};
        case (_vehicleClass == "Tank" && _cost >= 500): {3};
        // ПВО - Капитан (4)
        case (_className find "sa_" != -1): {4};
        // Вертолеты - от Ефрейтора (1) до Лейтенанта (3)
        case (_vehicleClass == "Air" && _className find "mi24" != -1): {3};
        case (_vehicleClass == "Air" && _className find "mi8" != -1): {1};
        // Самолеты - Капитан (4)
        case (_vehicleClass == "Plane"): {4};
        // По умолчанию - Рядовой (0)
        default {0};
    }
};

// Функция кастомных цен и рангов
vehicleShop_customPrices = {
    params ["_vehicles"];
    
    {
        _x params ["_className", "_cost", "_displayName"];
        
        // Автоматически определяем ранг
        private _requiredRankIndex = [_className, _cost] call vehicleShop_getVehicleRank;
        
        // Добавляем ранг в массив данных
        if (count _x < 4) then {
            _x pushBack _requiredRankIndex;
        } else {
            _x set [3, _requiredRankIndex];
        };
        
        // Примеры ручного переопределения звания
        switch (true) do {
            case (_className == "min_rf_sa_22"): { _x set [3, 6] }; // Полковник
			case (_className == "min_rf_sa_22_desert"): { _x set [3, 6] }; // Полковник
			case (_className == "min_rf_sa_22_winter"): { _x set [3, 6] }; // Полковник
			case (_className == "min_rf_2b26"): { _x set [3, 6] }; // Полковник
			case (_className == "min_rf_2b26_desert"): { _x set [3, 6] }; // Полковник
			case (_className == "min_rf_2b26_winter"): { _x set [3, 6] }; // Полковник
            case (_className == "min_rf_t_15"): { _x set [3, 5] }; // Майор
			case (_className == "min_rf_t_15_desert"): { _x set [3, 5] }; // Майор
			case (_className == "min_rf_t_15_winter"): { _x set [3, 5] }; // Майор
			case (_className == "rhs_t15_tv"): { _x set [3, 3] }; // Лейтенант
			case (_className == "min_rf_t_14"): { _x set [3, 4] }; // Капитан
			case (_className == "min_rf_t_14_desert"): { _x set [3, 4] }; // Капитан
			case (_className == "min_rf_t_14_winter"): { _x set [3, 4] }; // Капитан
			case (_className == "min_rf_su_34"): { _x set [3, 4] }; // Капитан
			case (_className == "min_rf_su_34_desert"): { _x set [3, 4] }; // Капитан
			case (_className == "min_rf_ka_52"): { _x set [3, 4] }; // Капитан
			case (_className == "min_rf_ka_52_grey"): { _x set [3, 4] }; // Капитан
            case (_className == "rhs_t90am_tv"): { _x set [3, 3] }; // Лейтенант
			case (_className == "rhs_t90sm_tv"): { _x set [3, 3] }; // Лейтенант
			case (_className == "O_BMPT"): { _x set [3, 4] }; // Капитан
			case (_className == "FP_Ger_Fighter_Jet"): { _x set [3, 4] }; // Капитан
			case (_className == "O_Plane_CAS_02_dynamicLoadout_F"): { _x set [3, 4] }; // Капитан
        };
    } forEach _vehicles;
    
    _vehicles
};

// Функция фильтрации техники
vehicleShop_filterVehicles = {
    params ["_allVehicleClasses"]; // Получаем все классы техники    
    private _filtered = []; // Отфильтрованный массив
    
    private _allowedMods = ["CWR_", "JAS_", "lago_"];  // Разрешенные префиксы модов , "A3_", "FP_", "scat_", "min_rf_"
    private _allowedCategories = ["Car","Armored","Helicopter","Air","Tank","Plane"];  // Разрешенные категории ,"Support"
    private _blacklist = ["rhs_2s3_tv", "rhs_bm21_MSV_01", "rhs_9k79_B", "rhs_9k79_K", "rhs_9k79"]; // Запрещенная техника
    
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
                getText(_config >> "displayName"),
                0 // Временное значение (Рядовой)
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
};