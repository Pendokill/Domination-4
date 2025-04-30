if (!hasInterface) exitWith {};

disableSerialization;
createDialog "VehicleShopDialog";

private _dialog = findDisplay 5000;
if (isNull _dialog) exitWith {
    hint "Ошибка создания меню магазина";
    diag_log "[VehicleShop] Не удалось создать диалог";
};

// Заполнение списка техники
private _vehicleList = _dialog displayCtrl 5001;
lbClear _vehicleList;

{
    _x params ["_class", "_cost", "_name"];
    private _index = _vehicleList lbAdd _name;
    _vehicleList lbSetData [_index, _class];
    _vehicleList lbSetValue [_index, _cost];
} forEach vehicleShop_vehicles;

// Отображение текущих очков (bis_revive_score)
private _pointsText = _dialog displayCtrl 5003;
_pointsText ctrlSetText format ["Очков: %1", player getVariable ["playerTotalPoints", 0]];

// Выбор первого элемента
_vehicleList lbSetCurSel 0;
[_vehicleList, 0] call vehicleShop_updateDetails;

diag_log "[VehicleShop] Меню магазина успешно открыто";