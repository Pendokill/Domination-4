// Конфигурация магазина техники
vehicleShop_vehicles = [
    ["B_MRAP_01_F", 10, "HMMWV (10 очков)"],
    ["B_Truck_01_transport_F", 75, "Грузовик (75 очков)"],
    ["B_APC_Wheeled_01_cannon_F", 150, "AMV (150 очков)"],
    ["B_Heli_Light_01_F", 100, "MH-9 Hummingbird (100 очков)"],
    ["B_Heli_Transport_01_F", 200, "UH-80 Ghost Hawk (200 очков)"],
    ["B_MBT_01_cannon_F", 300, "M2A1 Slammer (300 очков)"]
];

// Позиции спавна относительно стоек
vehicleShop_spawnOffsets = [
    [3, 0, 0, 0],
    [0, 3, 0, 90],
    [-3, 0, 0, 180],
    [0, -3, 0, 270]
];

// Автоматический поиск стоек InfoStand
vehicleShop_stands = (allMissionObjects "Land_InfoStand_V2_F") select {
    // Можно добавить дополнительные проверки, если нужно
    true
};

if (count vehicleShop_stands == 0) then {
    diag_log "[VehicleShop] Внимание: не найдено стоек Land_InfoStand_V2_F!";
} else {
    diag_log format ["[VehicleShop] Найдено стоек: %1", count vehicleShop_stands];
};

// Глобальная переменная для проверки загрузки
vehicleShop_configLoaded = true;