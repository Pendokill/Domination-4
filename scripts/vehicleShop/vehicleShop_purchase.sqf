vehicleShop_purchase = {
    private _dialog = findDisplay 5000;
    if (isNull _dialog) exitWith { hint "Диалог не найден"; };
    
    private _vehicleList = _dialog displayCtrl 5001;
    private _selectedIndex = lbCurSel _vehicleList;
    
    if (_selectedIndex == -1) exitWith {
        hint "Выберите технику из списка!";
    };
    // Проверка очков (bis_revive_score)
    private _className = _vehicleList lbData _selectedIndex;
    private _cost = _vehicleList lbValue _selectedIndex;
    private _currentPoints = player getVariable ["bis_revive_score", 0];
    
    if (_currentPoints < _cost) exitWith {
        hint format ["Недостаточно очков!\nНужно: %1\nВаши: %2", _cost, _currentPoints];
    };
    
};

// Поиск ближайшей стойки
private _nearestStand = [vehicleShop_stands, player] call BIS_fnc_nearestPosition;
private _spawnPositions = [_nearestStand] call vehicleShop_getSpawnPos;

// Поиск свободного места
private _freeSpot = nil;
{
    _x params ["_pos", "_dir"];
    if (count (nearestObjects [_pos, ["AllVehicles"], 5]) == 0) exitWith {
        _freeSpot = _x;
    };
} forEach _spawnPositions;

if (isNil "_freeSpot") exitWith {
    hint "Нет свободного места для спавна!";
};
    // Остальной код покупки...
    // (оставьте ваш существующий код покупки техники)
// Создание техники
_freeSpot params ["_pos", "_dir"];
private _vehicle = createVehicle [_className, _pos, [], 0, "CAN_COLLIDE"];
_vehicle setDir (_dir + getDir _nearestStand);
_vehicle setPosATL _pos;

// Помещаем игрока в технику
player moveInDriver _vehicle;

// Списание очков
[player, _cost] call vehicleShop_deductPoints;

// Обновление интерфейса
private _pointsText = _dialog displayCtrl 5003;
_pointsText ctrlSetText format ["Очков: %1", player getVariable ["bis_revive_score", 0]];

hint format ["Куплено: %1", getText(configFile >> "CfgVehicles" >> _className >> "displayName")];