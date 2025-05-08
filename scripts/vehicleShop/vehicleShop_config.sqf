/*  
    by Pirat
    vehicleShop_config.sqf
    Полностью исправленная версия
*/

// ====================== ОСНОВНЫЕ ПЕРЕМЕННЫЕ ======================
vehicleShop_vehicles = []; // Массив загруженной техники
vehicleShop_spawnMarker = "vehicle_spawn"; // Маркер спавна
vehicleShop_configLoaded = true; // Флаг готовности
vehicleShop_loadMode = 1; // 0-авто, 1-ручной
vehicleShop_rankNames = ["Рядовой","Ефрейтор","Сержант","Лейтенант","Капитан","Майор","Полковник","Генерал"];

// Ручной список техники (формат: [класс, цена, название, ранг])
vehicleShop_manualVehicles = [
    ["O_G_Quadbike_01_F", 40, "Квадроцикл", 0],
    ["O_G_Offroad_01_armed_F", 80, "Внедорожник (Пулемёт)", 0],
    ["O_G_Offroad_01_AT_F", 80, "Внедорожник (СПГ-9)", 0],
    ["FP_Spetsnaz_Alpha_UAZ_AGS30", 90, "УАЗ Патриот (АГС-30)", 0],
    ["rhs_gaz66_r142_vdv", 80, "ГАЗ-66 (Р-142 Н)", 0],
    ["rhs_gaz66_zu23_vdv", 150, "ГАЗ-66 (ЗУ-23-2)", 0],
	["I_MRAP_03_hmg_F", 300, "Страйдер (Пулемёт)", 0],
	["I_MRAP_03_gmg_F", 300, "Страйдер (Гранатомёт)", 0],
	["O_MRAP_02_hmg_F", 300, "Ифрит (Пулемёт)", 0],
	["O_MRAP_02_gmg_F", 300, "Ифрит (Гранатомёт)", 0],
	["min_rf_gaz_2330_HMG", 350, "ТИГР-2330", 0],
	["min_rf_gaz_2330_HMG_desert", 350, "ТИГР-2330 (Пустыня)", 0],
	["min_rf_gaz_2330_HMG_winter", 350, "ТИГР-2330 (Зима)", 0],
	["rhs_tigr_sts_3camo_msv", 400, "ТИГР-2330", 0],
    ["rhsgref_BRDM2_ATGM_vmf", 350, "БРДМ-2 (ПТУР)", 1],
	["O_APC_Wheeled_02_rcws_v2_F", 350, "МСЕ-3 Марид", 1],
	["O_APC_Tracked_02_cannon_F", 350, "БТР-К Камыш", 1],
	["rhs_btr80_vdv", 250, "БТР-80 (ВДВ)", 1],
	["rhs_btr80a_vmf", 350, "БТР-80А (МП)", 1],
    ["rhs_bmp1p_vmf", 250, "БМП-1", 2],
	["rhs_brm1k_vmf", 250, "БРМ-1К", 2],
	["rhs_bmp2k_vmf", 350, "БМП-2К", 2],
	["rhs_bmp2_msv", 350, "БМП-2", 2],
	["rhs_bmd2m", 350, "БМД-2М", 2],
	["rhs_bmd4ma_vdv", 450, "БМД-4М (ДБ)", 2],
	["rhs_zsu234_aa", 300, "ЗСУ-23-4", 2],
	["FP_Ger_Boxer", 300, "Boxer", 2],
	["min_rf_ags_30_desert", 40, "АГС-30 ГМГ", 0],
	["min_rf_Mortar_desert", 60, "Миномёт Мк-6", 0],
	["min_rf_Metis_desert", 80, "Метис-М", 0],
	["rhs_Kornet_9M133_2_vmf", 80, "Корнет-М", 0],
	["I_MBT_03_cannon_F", 600, "МБТ-52 Кума", 2],
	["rhs_t72be_tv", 650, "Т-72 Б3", 3],
	["FP_Ger_Leopard", 800, "Леопард", 3],
    ["rhs_t80bv", 600, "Т-80БВ", 3],
	["rhs_t80uk", 650, "Т-80УК", 3],
    ["FP_Chechen_T80", 600, "Т-80", 3],
	["rhs_t90am_tv", 800, "Т-90АМ", 3],
    ["rhs_t90sm_tv", 800, "Т-90СМ", 3],
	["O_BMPT", 950, "БМПТ Терминатор", 3],
	["min_rf_t_15", 950, "Т-15 Армата", 3],
	["min_rf_t_15_desert", 950, "Т-15 Армата (Пустыня)", 3],
	["min_rf_t_15_winter", 950, "Т-15 Армата (Зима)", 3],
    ["min_rf_t_14", 1000, "Т-14 Армата", 3],
	["min_rf_t_14_desert", 1000, "Т-14 Армата (Пустыня)", 3],
	["min_rf_t_14_winter", 1000, "Т-14 Армата (Зима)", 3],
	["min_rf_su_34", 1150, "Су-34", 4],
	["min_rf_su_34_desert", 1150, "Су-34", 4],
	["I_Plane_Fighter_03_dynamicLoadout_F", 700, "А-143", 3],
	["O_Plane_CAS_02_dynamicLoadout_F", 750, "То-199 Неофрон", 4],
	["RHS_T50_vvs_blueonblue", 850, "СУ-57", 4],
	["RHS_T50_vvs_generic_ext", 850, "СУ-57 (Внешние пилоны)", 4],
	["RHS_Su25SM_vvsc", 800, "СУ-25 (Камуфляж)", 4],
	["RHS_Su25SM_vvs", 800, "СУ-25 СМ", 4],
	["rhs_mig29s_vvsc", 850, "МИГ-29 С (Камуфляж)", 4],
	["rhs_mig29s_vvs", 850, "МИГ-29 С", 4],
	["rhs_mig29sm_vvsс", 850, "МИГ-29 СМ (Камуфляж)", 4],
	["rhs_mig29sm_vvs", 850, "МИГ-29 СМ", 4],
	["RHS_A10", 900, "A-10A", 4],
	["rhsusf_f22", 1100, "F-22A", 4],
	["RHS_TU95MS_vvs_chelyabinsk", 400, "ТУ-95 МС-6", 4],
	["RHS_MELB_AH6M", 300, "АН-6М Литлбёрд (2 пулемёта + 2 малых нурса)", 4],
	["RHS_MELB_AH6M_M", 350, "АН-6М-М Литлбёрд (пулемёт + большой нурс)", 4],
    ["RHS_MELB_AH6M_H", 400, "АН-6М-Н Литлбёрд (пулемёт + 2 ракеты наведения)", 4],
	["RHS_Mi8AMTSh_vvs", 450, "МИ-8 АМТШ", 3],
	["RHS_Mi24V_vvs", 650, "МИ-24 В", 4],
	["rhsgref_cdf_Mi24D", 700, "МИ-24 Д", 4],
	["rhsgref_mi24g_CAS", 750, "МИ-24 Г", 4],
	["FP_Spetsnaz_Alpha_Mi24_Super_Hind", 800, "МИ-24", 4],
	["RHS_Ka52_vvs", 1400, "Ка-52 Аллигатор", 4],
	["RHS_Ka52_vvsc", 1400, "Ка-52 Аллигатор (Камуфляж)", 4],
    ["min_rf_ka_52", 1400, "Ка-52 Аллигатор", 4],
	["min_rf_ka_52_grey", 1400, "Ка-52 Аллигатор", 4],
	["RHS_AH1Z_wd", 1400, "АН-1Z", 4],
	["RHS_AH64D", 1400, "АН-64D", 4],
	["min_rf_heli_light_black", 200, "КА-60 Касатка (Вооружение)", 3],
	["rhs_mi28n_vvsc", 1200, "МИ-28Н (Камуфляж)", 4],
	["rhs_mi28n_vvs", 1200, "МИ-28Н", 4],
    ["min_rf_sa_22", 1200, "Панцирь-С1", 6],
	["min_rf_sa_22_desert", 1200, "Панцирь-С1 (Пустыня)", 6],
	["min_rf_sa_22_winter", 1200, "Панцирь-С1 (Зима)", 6],
    ["min_rf_2b26", 1700, "РСЗО Град-К", 6],
	["min_rf_2b26_desert", 1700, "РСЗО Град-К (Пустыня)", 6],
	["min_rf_2b26_winter", 1700, "РСЗО Град-К (Зима)", 6]
];

// ====================== ФУНКЦИИ ======================
/*
    Установка режима загрузки
    Параметры:
        _mode - 0 (авто) или 1 (ручной)
*/
vehicleShop_setLoadMode = {
    params ["_mode"];
    
    if !(_mode in [0,1]) exitWith {
        diag_log "[VehicleShop] Ошибка: неверный режим";
    };
    
    vehicleShop_loadMode = _mode;
    publicVariable "vehicleShop_loadMode";
    
    if (isServer) then {
        [] spawn {
            sleep 0.1;
            [] call vehicleShop_loadVehicles;
        };
    };
    
    playSound "FD_Finish_F";
    diag_log format ["[VehicleShop] Режим изменен: %1", ["Авто","Ручной"] select _mode];
};

/*
    Основная загрузка техники
*/
vehicleShop_loadVehicles = {
    if (!isServer) exitWith {};
    
    private _timer = diag_tickTime;
    diag_log format ["[VehicleShop] Начало загрузки (%1)", ["Авто","Ручной"] select vehicleShop_loadMode];
    
    switch (vehicleShop_loadMode) do {
        case 0: {
            private _allClasses = "(configName _x) isKindOf 'AllVehicles'" configClasses (configFile >> "CfgVehicles") apply {configName _x};
            vehicleShop_vehicles = [_allClasses] call vehicleShop_filterVehicles;
            vehicleShop_vehicles = [vehicleShop_vehicles] call vehicleShop_customPrices;
            
            // Применяем наценку 60% в авторежиме
            vehicleShop_vehicles = [vehicleShop_vehicles, 60] call vehicleShop_applyPriceMarkup;
        };
        case 1: {
            vehicleShop_vehicles = +vehicleShop_manualVehicles;
            
            // Применяем наценку 10% в ручном режиме
            vehicleShop_vehicles = [vehicleShop_vehicles, 0] call vehicleShop_applyPriceMarkup;
        };
    };
    
    publicVariable "vehicleShop_vehicles";
    diag_log format ["[VehicleShop] Загружено %1 единиц за %2с", count vehicleShop_vehicles, diag_tickTime - _timer];
};

/*
    Фильтрация техники для авторежима
*/
vehicleShop_filterVehicles = {
    params ["_allClasses"];
    private _filtered = [];
    private _allowedMods = ["rhs_", "min_rf_", "FP_"];
    private _blacklist = ["rhs_2s3_tv", "rhs_bm21_MSV_01"];
    
    {
        private _className = _x;
        private _config = configFile >> "CfgVehicles" >> _className;
        
        // Исправленная проверка изображения
        if (getText(_config >> "picture") == "") then { continueWith ""; };
        
        private _modAllowed = false;
        { if (_className find _x == 0) exitWith { _modAllowed = true }; } forEach _allowedMods;
        
        if (_modAllowed && {getNumber(_config >> "scope") == 2}) then {
            private _cost = round ((getNumber(_config >> "armor") * 0.8 + (getNumber(_config >> "enginePower") * 0.2)));
            _cost = (_cost max 10) min 2000;
            
            _filtered pushBack [
                _className,
                _cost,
                getText(_config >> "displayName"),
                0
            ];
        };
    } forEach _allClasses;
    
    _filtered sort true;
    _filtered
};

/*
    Настройка кастомных цен и рангов
*/
vehicleShop_customPrices = {
    params ["_vehicles"];
    
    {
        _x params ["_className", "_cost"];
        private _requiredRank = [_className, _cost] call vehicleShop_getVehicleRank;
        
        if (count _x < 4) then {
            _x pushBack _requiredRank;
        } else {
            _x set [3, _requiredRank];
        };
        // Ручные переопределения        
        switch (_className) do {
            case "min_rf_sa_22": { _x set [3, 6] };
            case "min_rf_2b26": { _x set [3, 6] };
            case "rhs_t90am_tv": { _x set [3, 3] };
        };
    } forEach _vehicles;
    
    _vehicles
};

/*
    Определение ранга техники
*/
vehicleShop_getVehicleRank = {
    params ["_className", "_cost"];
    private _class = toLower getText(configFile >> "CfgVehicles" >> _className >> "vehicleClass");
    private _armor = getNumber(configFile >> "CfgVehicles" >> _className >> "armor");
    
    // Временный лог для диагностики
    diag_log format ["Определение ранга для: %1 (Класс: %2, Цена: %3, Броня: %4)", 
        _className, _class, _cost, _armor];
    
    switch (true) do {
        // Танки
        case (_class == "tank" && _cost >= 1000): {5};  // Тяжелые танки - майор
        case (_class == "tank" && _cost >= 500):  {3};  // Средние танки - лейтенант
        case (_class == "tank"):                  {2};  // Легкие танки - сержант
        
        // Бронетехника
        case (_class in ["armored"] && _armor >= 500): {2};
        case (_class in ["armored"]):                  {1};
        
        // Спецтехника
        case (_className find "aa" != -1):             {4};  // ПВО - капитан
        case (_className find "artillery" != -1):      {5};  // Артиллерия - майор
        
        default {0};  // Вся остальная техника - рядовой
    };
};

// ====================== ИНИЦИАЛИЗАЦИЯ ======================
if (isServer) then {
    [] spawn {
        waitUntil {!isNil "vehicleShop_configLoaded"};
        sleep 1; // Задержка для стабильности
        
        // Первоначальная загрузка техники
        [] call vehicleShop_loadVehicles;
        
        // Команда для смены режима загрузки
        ["vehshop_mode", {
            params ["_args", "_admin"];
            private _mode = parseNumber _args;
            if (_mode in [0,1]) then {
                [_mode] call vehicleShop_setLoadMode;
                systemChat format ["[Магазин] Режим изменен: %1", ["Авто","Ручной"] select _mode];
            } else {
                systemChat "Использование: #vehshop_mode <0|1> (0-авто, 1-ручная)";
            };
        }, "admin"] remoteExec ["addAdminMenuCommand", 0, true];
        
        // Команда для установки наценки
        ["vehshop_markup", {
            params ["_args", "_admin"];
            private _percent = parseNumber _args;
            
            if (_percent >= -50 && _percent <= 300) then { // Диапазон от -50% до +300%
                // Сохраняем оригинальные цены перед изменением
                if (isNil "vehicleShop_originalPrices") then {
                    vehicleShop_originalPrices = +vehicleShop_vehicles;
                };
                
                // Применяем наценку к оригинальным ценам
                private _newVehicles = +vehicleShop_originalPrices;
                _newVehicles = [_newVehicles, _percent] call vehicleShop_applyPriceMarkup;
                
                vehicleShop_vehicles = _newVehicles;
                publicVariable "vehicleShop_vehicles";
                
                systemChat format ["[Магазин] Установлена наценка: %1%", _percent];
                diag_log format ["[VehicleShop] Применена наценка %1%", _percent];
                
                // Обновляем интерфейс у всех игроков
                if (hasInterface) then {
                    [] call vehicleShop_updateUI;
                } else {
                    remoteExecCall ["vehicleShop_updateUI", -2];
                };
            } else {
                systemChat "Допустимый диапазон: от -50% до +300%";
            };
        }, "admin"] remoteExec ["addAdminMenuCommand", 0, true];
        
        // Команда для сброса наценки
        ["vehshop_resetprices", {
            params ["", "_admin"];
            
            if (!isNil "vehicleShop_originalPrices") then {
                vehicleShop_vehicles = +vehicleShop_originalPrices;
                publicVariable "vehicleShop_vehicles";
                systemChat "[Магазин] Цены сброшены к оригинальным";
                
                // Обновляем интерфейс у всех игроков
                if (hasInterface) then {
                    [] call vehicleShop_updateUI;
                } else {
                    remoteExecCall ["vehicleShop_updateUI", -2];
                };
            } else {
                systemChat "[Магазин] Оригинальные цены не найдены";
            };
        }, "admin"] remoteExec ["addAdminMenuCommand", 0, true];
        
        // Команда для принудительного обновления
        ["vehshop_reload", {
            params ["", "_admin"];
            [] call vehicleShop_loadVehicles;
            systemChat "[Магазин] Техника перезагружена";
        }, "admin"] remoteExec ["addAdminMenuCommand", 0, true];
        
        diag_log "[VehicleShop] Админские команды инициализированы";
    };
};

// ====================== НАЦЕНКА ======================
vehicleShop_applyPriceMarkup = {
    params ["_vehicles", "_percent"];
    
    {
        if (count _x >= 2) then {
            private _currentPrice = _x select 1;
            private _newPrice = _currentPrice * (1 + (_percent / 100));
            _x set [1, round _newPrice];
        };
    } forEach _vehicles;
    
    _vehicles
};