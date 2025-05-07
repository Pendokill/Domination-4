/*  
    by Pirat
    vehicleShop_open.sqf
    Добавлена проверка текущего режима загрузки
*/

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
        // Отображаем текущий режим загрузки
        systemChat format ["Текущий режим магазина: %1", ["Автоматический", "Ручной"] select vehicleShop_loadMode];
        [] call vehicleShop_updateUI;
        diag_log "[VehicleShop] Диалог успешно открыт";
    };
};