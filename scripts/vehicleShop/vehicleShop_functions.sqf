vehicleShop_populateList = {
    params ["_faction", "_side"];
    
    private _allVehicles = [];
    private _categories = [
        "Car",
        "Armored",
        "Tank",
        "Helicopter",
        "Plane",
        "Ship",
        "Support"
    ];
    
    // Получаем все конфиги техники
    private _cfgVehicles = configFile >> "CfgVehicles";
    
    // Фильтруем по фракции и стороне
    for "_i" from 0 to (count _cfgVehicles - 1) do {
        private _vehicle = _cfgVehicles select _i;
        if (isClass _vehicle) then {
            private _className = configName _vehicle;
            private _scope = getNumber(_vehicle >> "scope");
            private _sideNum = getNumber(_vehicle >> "side");
            private _factionClass = getText(_vehicle >> "faction");
            private _vehicleClass = getText(_vehicle >> "vehicleClass");
            
            if (_scope == 2 && 
                _sideNum == _side && 
                _factionClass == _faction && 
                (_vehicleClass in _categories)) then {
                
                private _displayName = getText(_vehicle >> "displayName");
                private _cost = round ((getNumber(_vehicle >> "armor") + (getNumber(_vehicle >> "maxSpeed")/10)) / 2;
                _cost = (_cost max 10) min 1000; // Ограничиваем стоимость
                
                _allVehicles pushBack [_className, _cost, _displayName];
            };
        };
    };
    
    // Сортируем по стоимости
    _allVehicles sort true;
    
    // Сохраняем в глобальную переменную
    missionNamespace setVariable ["vehicleShop_vehicles", _allVehicles, true];
    publicVariable "vehicleShop_vehicles";
    
    diag_log format ["[VehicleShop] Загружено %1 единиц техники для фракции %2", count _allVehicles, _faction];
};