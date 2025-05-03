// vehicleShop_customPrices.sqf
vehicleShop_customPrices = {
    params ["_vehicles"];
    
    {
        _x params ["_className", "_cost", "_displayName"];
        
        // Здесь ваши правила изменения цен
        switch (_className) do {
            case "rhs_t72ba_tv": { _x set [1, 500] }; // Пример изменения цены Т-72
            case "rhs_bmp2_msv": { _x set [1, 300] }; // Пример для БМП-2
			case "rhs_t90sm_tv": { _x set [1, 700] }; // Пример изменения цены Т-90
            case "rhs_t90am_tv": { _x set [1, 700] }; // Т-90
			case "min_rf_sa_22": { _x set [1, 1200] }; // Панцирь-С1
            case "min_rf_sa_22_desert": { _x set [1, 1200] }; // Пример для Панцирь-С1
			case "min_rf_sa_22_winter": { _x set [1, 1200] }; // Пример изменения цены Панцирь-С1
            case "min_rf_t_15": { _x set [1, 950] }; // Пример для Т-15 Армата
			case "min_rf_t_15_desert": { _x set [1, 950] }; // Т-15 Армата
			case "min_rf_t_15_winter": { _x set [1, 950] }; // Т-15 Армата
            // Добавьте другие классы по аналогии
        };
    } forEach _vehicles;
    
    _vehicles
};