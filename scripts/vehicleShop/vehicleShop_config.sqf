// Принудительная инициализация массива
if (isNil "vehicleShop_vehicles") then {
    vehicleShop_vehicles = [];
};

// Основной список техники
vehicleShop_vehicles = [
    ["B_MRAP_01_F", 10, "HMMWV (10 очков)"],
    ["B_Truck_01_transport_F", 75, "Грузовик (75 очков)"],
    ["B_APC_Wheeled_01_cannon_F", 150, "AMV (150 очков)"],
    ["B_Heli_Light_01_F", 100, "MH-9 Hummingbird (100 очков)"],
    ["B_Heli_Transport_01_F", 200, "UH-80 Ghost Hawk (200 очков)"],
    ["B_MBT_01_cannon_F", 300, "M2A1 Slammer (300 очков)"]
];

// Автопоиск стоек с резервным вариантом
vehicleShop_stands = entities "Land_InfoStand_V2_F";
if (count vehicleShop_stands == 0) then {
    vehicleShop_stands = [stand1]; // Создайте хотя бы одну стойку в редакторе
    diag_log "[VehicleShop] Использована резервная стойка stand1";
};

vehicleShop_configReady = true;
diag_log "[VehicleShop] Конфигурация загружена";