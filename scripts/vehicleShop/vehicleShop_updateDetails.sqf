vehicleShop_updateDetails = {
    params ["_control", "_selectedIndex"];
    
    private _dialog = uiNamespace getVariable "VehicleShopDialog";
    if (isNull _dialog) exitWith {};
    
    private _detailsCtrl = _dialog displayCtrl 5004;
    private _vehicleData = vehicleShop_vehicles select _selectedIndex;
    
    private _className = _vehicleData select 0;
    private _cost = _vehicleData select 1;
    private _displayName = _vehicleData select 2;
    
    private _config = configFile >> "CfgVehicles" >> _className;
    private _description = getText(_config >> "Library" >> "libTextDesc");
    private _maxSpeed = getNumber(_config >> "maxSpeed");
    private _armor = getNumber(_config >> "armor");
    
    // Ограничиваем длину описания
    if (count _description > 150) then {
        _description = (_description select [0, 150]) + "...";
    };
    
    _detailsCtrl ctrlSetStructuredText parseText format [
        "<t font='PuristaMedium' size='0.85'>" +
        "<t color='#FFFF00'>%1</t><br/>" +
        "<t color='#FFA500'>Цена:</t> %2 очков<br/>" +
        "<t color='#FFA500'>Скорость:</t> %3 км/ч<br/>" +
        "<t color='#FFA500'>Броня:</t> %4<br/>" +
        "<t color='#FFA500'>Описание:</t> %5" +
        "</t>",
        _displayName, _cost, _maxSpeed, _armor, _description
    ];
};