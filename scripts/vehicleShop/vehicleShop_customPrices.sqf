// Пример переопределения цен
vehicleShop_customPrices = {
    params ["_vehicles"];
    
    {
        _className = _x select 0;
        switch (true) do {
            case (_className == "rhs_t72ba_tv"): { _x set [1, 350] }; // Т-72БА
            case (_className == "rhs_bmp2_msv"): { _x set [1, 150] }; // БМП-2
            case (_className find "mi8" != -1):  { _x set [1, (_x select 1) * 1.2] }; // +20% к вертолетам
        };
    } forEach _vehicles;
    
    _vehicles
};

// И добавьте вызов в vehicleShop_config.sqf после фильтрации:
vehicleShop_vehicles = [vehicleShop_vehicles] call vehicleShop_customPrices;