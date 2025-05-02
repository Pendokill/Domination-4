if (!isServer) exitWith {};

params ["_player", "_selectedIndex"];
private _vehicleData = vehicleShop_vehicles select _selectedIndex;
_vehicleData params ["_class","_cost","_name"];

// Проверка очков
private _points = [_player] call vehicleShop_getPoints;
if (_points < _cost) exitWith {
    [format ["Ошибка: у игрока %1 недостаточно очков", name _player]] remoteExec ["systemChat", _player];
};

// Поиск места спавна
private _stand = [vehicleShop_stands, _player] call BIS_fnc_nearestPosition;
private _spawnPos = [];
{
    _x params ["_pos","_dir"];
    if (count nearestObjects [_pos, ["AllVehicles"], 5] == 0) exitWith {
        _spawnPos = [_pos, _dir];
    };
} forEach ([_stand] call vehicleShop_getSpawnPos);

if (_spawnPos isEqualTo []) exitWith {
    ["Все места спавна заняты!"] remoteExec ["hint", _player];
};

// Создание техники
_spawnPos params ["_pos","_dir"];
private _vehicle = createVehicle [_class, _pos, [], 0, "CAN_COLLIDE"];
_vehicle setDir (_dir + getDir _stand);
_vehicle setPosATL _pos;

// Помещаем игрока в технику
[_player, _vehicle] remoteExec ["moveInDriver", _player];

// Списание очков
[_player, _cost] call vehicleShop_deductPoints;

// Уведомление
[format ["%1 куплен за %2 очков", _name, _cost]] remoteExec ["hint", _player];
diag_log format ["[VehicleShop] %1 купил %2", name _player, _name];