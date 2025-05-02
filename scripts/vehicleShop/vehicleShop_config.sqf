// Конфигурация техники
vehicleShop_vehicles = [
    ["B_MRAP_01_F", 50, "HMMWV (50 очков)"],
    ["B_Truck_01_transport_F", 75, "Грузовик (75 очков)"],
    ["B_APC_Wheeled_01_cannon_F", 150, "AMV (150 очков)"],
    ["B_Heli_Light_01_F", 100, "MH-9 Hummingbird (100 очков)"],
    ["B_Heli_Transport_01_F", 200, "UH-80 Ghost Hawk (200 очков)"],
    ["B_MBT_01_cannon_F", 300, "M2A1 Slammer (300 очков)"]
];

// Позиции спавна [X,Y,Z,Dir]
vehicleShop_spawnOffsets = [
    [3, 0, 0, 0],
    [0, 3, 0, 90],
    [-3, 0, 0, 180],
    [0, -3, 0, 270]
];

// Автопоиск стоек
vehicleShop_stands = (allMissionObjects "Land_InfoStand_V2_F") select {true};

// Система очков (совместимость с Domination)
vehicleShop_getPoints = {
    params ["_player"];
    private _uid = getPlayerUID _player;
    
    if (!isNil "d_player_hash") then {
        private _scores = d_player_hash getVariable [_uid + "_scores", []];
        if (count _scores >= 6) exitWith { _scores select 5 };
    };
    
    // Fallback для SP
    private _scores = _player getVariable ["d_player_score", [0,0,0,0,0,0]];
    if (count _scores >= 6) then { _scores select 5 } else { 0 }
};

vehicleShop_deductPoints = {
    params ["_player", "_cost"];
    private _uid = getPlayerUID _player;
    
    if (!isNil "d_player_hash") then {
        private _scores = d_player_hash getVariable [_uid + "_scores", [0,0,0,0,0,0]];
        if (count _scores >= 6) then {
            _scores set [5, (_scores select 5) - _cost];
            d_player_hash setVariable [_uid + "_scores", _scores, true];
            publicVariable "d_player_hash";
        };
    } else {
        // Fallback для SP
        private _scores = _player getVariable ["d_player_score", [0,0,0,0,0,0]];
        if (count _scores >= 6) then {
            _scores set [5, (_scores select 5) - _cost];
            _player setVariable ["d_player_score", _scores, true];
        };
    };
};

vehicleShop_getSpawnPos = {
    params ["_stand"];
    vehicleShop_spawnOffsets apply {
        _x params ["_xOff","_yOff","_zOff","_dir"];
        [_stand modelToWorld [_xOff,_yOff,_zOff], _dir]
    };
};

diag_log format ["[VehicleShop] Инициализировано: %1 стоек, %2 единиц техники", 
    count vehicleShop_stands, count vehicleShop_vehicles];

vehicleShop_configLoaded = true;