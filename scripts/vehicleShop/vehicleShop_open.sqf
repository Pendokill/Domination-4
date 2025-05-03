if (!hasInterface) exitWith {};

disableSerialization;

// Дополнительная проверка перед открытием
if (isNil "vehicleShop_vehicles" || {count vehicleShop_vehicles == 0}) then {
    systemChat "Данные магазина не загружены. Попробуйте позже.";
    diag_log "[VehicleShop] Ошибка: vehicleShop_vehicles не загружен";
} else {
    createDialog "VehicleShopDialog";
    
    if (isNull (findDisplay 5000)) then {
        systemChat "Ошибка открытия меню";
        diag_log "[VehicleShop] Не удалось создать диалог";
    } else {
        [] call vehicleShop_updateUI;
        diag_log "[VehicleShop] Диалог успешно открыт";
    };
};