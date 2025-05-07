//    by Pirat
// vehicleShop_customPrices.sqf
vehicleShop_customPrices = {
    params ["_vehicles"];
    
    {
        _x params ["_className", "_cost", "_displayName"];
        private _config = configFile >> "CfgVehicles" >> _className;
        private _vehicleClass = toLower getText(_config >> "vehicleClass");
        
        // Принудительное определение ранга по классу техники
        private _requiredRank = switch (true) do {
            // Танки - лейтенант (3)
            case (_vehicleClass == "Tank"): {3};
            
            // Бронетехника - сержант (2)
            case (_vehicleClass == "armored"): {2};
            
            // Самолеты и вертолеты - капитан (4)
            case (_vehicleClass in ["plane","helicopter"]): {4};
            
            // Корабли и статичное оружие - ефрейтор (1)
            case (_vehicleClass in ["ship","staticweapon"]): {1};
            
            // По умолчанию (Car, Support и др.) - рядовой (0)
            default {0};
        };
        
        // Добавляем или обновляем ранг в массиве
        if (count _x < 4) then {
            _x pushBack _requiredRank;
        } else {
            _x set [3, _requiredRank];
        };
        
        // Кастомные цены для конкретных моделей (ваш существующий код)
        switch (_className) do {
            case "rhs_t15_tv": { _x set [1, 500] };
            case "rhs_bmp2_msv": { _x set [1, 300] };
            case "rhs_t90sm_tv": { _x set [1, 700] };
            case "rhs_t90am_tv": { _x set [1, 700] };
            case "min_rf_sa_22": { _x set [1, 1200] };
            case "min_rf_sa_22_desert": { _x set [1, 1200] };
            case "min_rf_sa_22_winter": { _x set [1, 1200] };
            case "min_rf_t_15": { _x set [1, 900] };
            case "min_rf_t_15_desert": { _x set [1, 900] };
            case "min_rf_t_15_winter": { _x set [1, 900] };
            case "min_rf_2b26": { _x set [1, 1700] };
            case "min_rf_2b26_desert": { _x set [1, 1700] };
            case "min_rf_2b26_winter": { _x set [1, 1700] };
            case "O_BMPT": { _x set [1, 950] };
            case "min_rf_ka_52": { _x set [1, 1400] };
            case "min_rf_ka_52_grey": { _x set [1, 1400] };
            case "min_rf_su_34": { _x set [1, 1200] };
            case "min_rf_su_34_desert": { _x set [1, 1200] };
            
            // Специальные переопределения ранга для отдельных моделей
            case "min_rf_sa_22": { _x set [3, 5] }; // Панцирь - майор (5)
            case "min_rf_2b26": { _x set [3, 6] }; // Град - полковник (6)
            case "min_rf_ka_52": { _x set [3, 4] }; // Ка-52 - капитан (4)
        };
    } forEach _vehicles;
    
    _vehicles
};