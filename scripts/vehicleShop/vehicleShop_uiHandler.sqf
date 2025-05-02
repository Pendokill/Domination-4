switch (_this select 0) do {
    case "onLBSelChanged": {
        _this params ["", "_control", "_selectedIndex"];
        private _dialog = uiNamespace getVariable "VehicleShopDialog";
        private _detailsCtrl = _dialog displayCtrl 5004;
        
        private _vehicleData = vehicleShop_vehicles select _selectedIndex;
        _vehicleData params ["_class","_cost","_name"];
        
        private _cfg = configFile >> "CfgVehicles" >> _class;
        private _desc = getText(_cfg >> "Library" >> "libTextDesc");
        private _speed = getNumber(_cfg >> "maxSpeed");
        private _armor = getNumber(_cfg >> "armor");
        
        _detailsCtrl ctrlSetStructuredText parseText format [
            "<t font='PuristaMedium' size='0.85'>" +
            "<t color='#FFFF00'>%1</t><br/>" +
            "<t color='#FFA500'>Цена:</t> %2 очков<br/>" +
            "<t color='#FFA500'>Скорость:</t> %3 км/ч<br/>" +
            "<t color='#FFA500'>Броня:</t> %4<br/>" +
            "<t color='#FFA500'>Описание:</t> %5" +
            "</t>",
            _name, _cost, _speed, _armor, _desc
        ];
    };
    
    case "onPurchaseClick": {
        private _dialog = uiNamespace getVariable "VehicleShopDialog";
        private _vehicleList = _dialog displayCtrl 5001;
        private _selectedIndex = lbCurSel _vehicleList;
        
        if (_selectedIndex < 0) exitWith { hint "Выберите технику!" };
        
        private _cost = _vehicleList lbValue _selectedIndex;
        private _points = [player] call vehicleShop_getPoints;
        
        if (_points < _cost) exitWith {
            hint format ["Недостаточно очков! Нужно: %1", _cost];
        };
        
        [player, _selectedIndex] remoteExec ["vehicleShop_purchase", 2];
        closeDialog 0;
        hint "Заказ принят в обработку...";
    };
};