// by Pirat
// Проверяем, что функции существуют
if (isNil "bank_fnc_updateDialog" || isNil "bank_fnc_checkLoans") then {
    diag_log "[Bank] КРИТИЧЕСКАЯ ОШИБКА: Функции не найдены!";
    [] spawn {
        sleep 5;
        if (isNil "bank_fnc_updateDialog") then {
            diag_log "[Bank] bank_fnc_updateDialog все еще не существует!";
        };
    };
};

// Обработчик для диалога
[] spawn {
    waitUntil {!isNull findDisplay 6000}; // Изменен IDD на 6000 чтобы избежать конфликта
    
    // Инициализация переменных
    bank_selectedAmount = nil;
    bank_selectedTime = nil;
    
    // Обновляем информацию
    [] spawn {
        while {!isNull findDisplay 6000} do {
            call bank_fnc_updateDialog;
            sleep 1;
        };
    };
};

// Периодическая проверка кредитов
[] spawn {
    while {true} do {
        call bank_fnc_checkLoans;
        sleep 60;
    };
};