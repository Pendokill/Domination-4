if (!isServer) exitWith {
    _this remoteExec ["vehicleShop_purchase", 2];
};

params ["_player", "_className", "_cost"];

// Проверяем достаточно ли очков
private _currentPoints = [_player] call vehicleShop_getPoints;
if (_currentPoints < _cost) exitWith {
    [format ["Недостаточно очков! Нужно: %1, есть: %2", _cost, _currentPoints]] remoteExec ["hint", _player];
};

// Находим стойку и позицию спавна
private _nearestStand = [vehicleShop_stands, _player] call BIS_fnc_nearestPosition;
private _spawnPositions = [_nearestStand] call vehicleShop_getSpawnPos;

// Ищем свободное место
private _spawnData = nil;
{
    _x params ["_pos", "_dir"];
    private _nearVehicles = nearestObjects [_pos, ["AllVehicles"], 5];
    if (count _nearVehicles == 0) exitWith {
        _spawnData = _x;
    };
} forEach _spawnPositions;

if (isNil "_spawnData") exitWith {
    ["Все позиции спавна заняты!"] remoteExec ["hint", _player];
};

// Создаем технику
_spawnData params ["_pos", "_dir"];
private _vehicle = createVehicle [_className, _pos, [], 0, "CAN_COLLIDE"];
_vehicle setDir (_dir + getDir _nearestStand);
_vehicle setPosATL _pos;

// Помещаем игрока в технику
[_player, _vehicle] remoteExec ["moveInDriver", _player];

// Списание очков
[_player, _cost] call vehicleShop_deductPoints;

// Обновление интерфейса
["Техника успешно куплена!"] remoteExec ["hint", _player];
[_player] remoteExec ["vehicleShop_updatePoints", _player];

diag_log format ["[VehicleShop] Игрок %1 купил %2 за %3 очков", name _player, _className, _cost];