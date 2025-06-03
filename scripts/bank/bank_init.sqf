/*
    by Pirat
    Банковская система для Domination 4
    Версия 3.1 - исправлено обращение к полю playerid вместо pid
*/

// ====================== СЕРВЕРНАЯ ЧАСТЬ ======================
if (isServer) then {
    // Инициализация массива кредитов
    bank_loans = [];
    publicVariable "bank_loans";
    
    // Функция загрузки кредитов из БД
    bank_fnc_loadLoans = {
        private _result = "extDB3" callExtension format["0:dom:bankLoanGetAll:%1", round(serverTime)];
        
        if (_result != "") then {
            private _parsed = parseSimpleArray _result;
            if (count _parsed > 0 && {_parsed select 0 == 1}) then {
                bank_loans = _parsed select 1;
                bank_loans = bank_loans apply {
                    [_x select 0, _x select 1, _x select 2, _x select 3, (_x select 4) == 1, _x select 5]
                };
                publicVariable "bank_loans";
                diag_log format["[Bank] Загружено %1 активных кредитов", count bank_loans];
            } else {
                bank_loans = [];
                publicVariable "bank_loans";
            };
        } else {
            bank_loans = [];
            publicVariable "bank_loans";
        };
    };
    
    [] spawn {
        sleep 5;
        call bank_fnc_loadLoans;
    };

    // Основная функция изменения очков с записью в БД
    bank_fnc_updateScore = {
        params ["_player", "_points"];
        
        // Мгновенное изменение очков
        _player addScore _points;
        
        // Запись в БД через custom call
        private _playerUID = getPlayerUID _player;
        private _currentScore = score _player;
        
        // Используем зарегистрированный custom call
        "extDB3" callExtension format[
            "1:dom:playerUpdateScore:%1:%2",
            _playerUID,
            _currentScore
        ];
        
        "extDB3" callExtension format["0:dom:%1", _query];
        
        // Обновляем интерфейс у всех игроков
        [] remoteExec ["bank_fnc_updateDialog", -2];
    };
    publicVariable "bank_fnc_updateScore";

    // Функция взятия кредита (серверная)
bank_fnc_takeLoanServer = {
    params ["_player", "_amount", "_time"];
    
    private _playerUID = getPlayerUID _player;
    private _currentDebt = 0;
    
    // Проверка наличия активного кредита
    {
        if ((_x select 0) == _playerUID) exitWith { _currentDebt = _x select 2; };
    } forEach bank_loans;
    
    if (_currentDebt > 0) exitWith {
        ["<t color='#FF0000'>У вас уже есть непогашенный кредит!</t>", _player] remoteExec ["hint", _player];
        playSound "FD_CP_Not_Clear_F";
    };
    
    // Процентные ставки
    private _interestRate = switch (_time) do {
        case 3: {0.05};
        case 6: {0.10};
        case 12: {0.15};
        case 24: {0.25};
        default {0};
    };
    
    if (score _player < 0) then { _interestRate = 0.15; _time = 6; };
    
    private _totalToPay = _amount * (1 + _interestRate);
    private _dueTime = serverTime + (_time * 3600);  // Сохраняем время в Unix-времени
    
    // Добавляем кредит
    private _newLoan = [_playerUID, _amount, _totalToPay, _dueTime, false, 0];
    bank_loans pushBack _newLoan;
    publicVariable "bank_loans";
    
    // Сохраняем в БД
    "extDB3" callExtension format[
        "1:dom:bankLoanInsert:%1:%2:%3:%4:0:0",
        _playerUID, _amount, _totalToPay, _dueTime
    ];
    
    // Начисляем очки
    [_player, _amount] call bank_fnc_updateScore;
    
    // Отправляем уведомление
    private _msg = format[
        "Кредит %1 очков получен!<br/>Вернуть: %2 очков до %3",
        _amount, _totalToPay, [_dueTime, "HH:MM:SS"] call BIS_fnc_secondsToString
    ];
    [_msg, _player] remoteExec ["hint", _player];
    sleep 4;  // Задерживаем на 4 секунды
    ["", _player] remoteExec ["hint", player];  // Убираем подсказку
};
    publicVariable "bank_fnc_takeLoanServer";

    // Функция погашения кредита (серверная)
    bank_fnc_payLoanServer = {
        params ["_player"];
        
        private _playerUID = getPlayerUID _player;
        private _loanIndex = -1;
        private _debtAmount = 0;
        
        {
            if ((_x select 0) == _playerUID) exitWith {
                _loanIndex = _forEachIndex;
                _debtAmount = _x select 2;
            };
        } forEach bank_loans;
        
        if (_loanIndex == -1) exitWith {
            ["<t color='#FF0000'>У вас нет активных кредитов!</t>", _player] remoteExec ["hint", _player];
            playSound "FD_CP_Not_Clear_F";
            false
        };
        
        if (score _player < _debtAmount) exitWith {
            ["Недостаточно средств!", _player] remoteExec ["hint", _player];
        };
        
        // Списываем очки
        [_player, -_debtAmount] call bank_fnc_updateScore;
        
        // Удаляем кредит
        bank_loans deleteAt _loanIndex;
        publicVariable "bank_loans";
        
        // Удаляем из БД
        "extDB3" callExtension format["1:dom:bankLoanDelete:%1", _playerUID];
        
        // Отправляем уведомление
        ["Кредит погашен!", _player] remoteExec ["hint", _player];
        sleep 4;  // Задерживаем на 4 секунды
        ["", _player] remoteExec ["hint", _player];  // Убираем подсказку
    };
    publicVariable "bank_fnc_payLoanServer";

    // Проверка просроченных кредитов
    [] spawn {
        while {true} do {
            sleep 300;
            {
                _x params ["_uid", "_amount", "_debt", "_due", "_overdue", "_penalty"];
                
                if (serverTime > _due && !_overdue) then {
                    // Штраф 50% за просрочку
                    private _newDebt = _debt * 1.5;
                    bank_loans set [_forEachIndex, [_uid, _amount, _newDebt, _due, true, _penalty+1]];
                    publicVariable "bank_loans";
                    
                    // Обновляем в БД
                    "extDB3" callExtension format[
                        "1:dom:bankLoanUpdate:%1:%2:%3:%4:1:%5",
                        _amount, _newDebt, _due, _penalty+1, _uid
                    ];
                    
                    private _player = [_uid] call BIS_fnc_getUnitByUID;
                    if (!isNull _player) then {
                        ["Просрочка! Долг увеличен на 50%", _player] remoteExec ["hint", _player];
                    };
                };
            } forEach bank_loans;
        };
    };
};

// ======================= КЛИЕНТСКАЯ ЧАСТЬ ========================
if (hasInterface) then {
    bank_loans = [];
    
    // Функция обновления диалога
bank_fnc_updateDialog = {
    if (isNull (findDisplay 6000)) exitWith {};
    
    private _display = findDisplay 6000;
    private _uid = getPlayerUID player;
    private _debt = 0;
    private _time = 0;
    
    {
        if ((_x select 0) == _uid) exitWith {
            _debt = _x select 2;
            _time = _x select 3;
        };
    } forEach bank_loans;
    
    // Обновляем UI
    (_display displayCtrl 5010) ctrlSetText format["Ваш баланс: %1", score player];
    
    private _debtCtrl = _display displayCtrl 5013;
    if (_debt > 0) then {
        _debtCtrl ctrlSetStructuredText parseText format[
            "<t color='#FFA500' align='center'>Текущий долг: %1 очей<br/>До погашения: %2</t>",
            _debt,
            [_time - serverTime, "HH:MM:SS"] call BIS_fnc_secondsToString
        ];
    } else {
        _debtCtrl ctrlSetStructuredText parseText "<t color='#00FF00' align='center'>Нет задолжности</t>";
    };
    
    private _payBtn = _display displayCtrl 5012;
    _payBtn ctrlEnable (_debt > 0);
    _payBtn ctrlSetText (if (_debt > 0) then {"ПОГАСИТЬ"} else {"НЕТ ДОЛГОВ"});
};
 
    // Клиентские функции
    bank_fnc_takeLoan = {
        if (isNil "bank_selectedAmount" || isNil "bank_selectedTime") exitWith {
            hint parseText "<t color='#FF0000'>Ошибка!</t><br/>Выберите сумму и срок кредита";
            playSound "FD_CP_Not_Clear_F";
        };
        
        private _uid = getPlayerUID player;
        private _hasDebt = false;
        
        // Проверяем наличие активного кредита
        {
            if ((_x select 0) == _uid) exitWith { _hasDebt = true; };
        } forEach bank_loans;
        
        if (_hasDebt) exitWith {
            hint parseText "<t color='#FF0000'>У вас есть задолжность!</t><br/>Погасите сначала взятый кредит.";
            playSound "FD_CP_Not_Clear_F";
        };
        
        // Отправляем запрос на оформление кредита
        [player, bank_selectedAmount, bank_selectedTime] remoteExec ["bank_fnc_takeLoanServer", 2];
        
        // Начинаем показывать временной хинт
        hint parseText "<t color='#FFFF00'>Обработка запроса на кредит...</t>";
        sleep 1;  // Небольшая задержка перед изменением текста
        
        // Меняем текст хинта на "Кредит получен!"
        hint parseText "<t color='#00FF00'>Кредит получен!</t>";
        playSound "webmoney";
        sleep 4;  // Пауза на 4 секунды
        
        // Убираем хинт
        ["", player] remoteExec ["hint", player];
    };
    
    bank_fnc_payLoan = {
        // Отправляем запрос на погашение кредита
        [player] remoteExec ["bank_fnc_payLoanServer", 2];
        
        // Временный хинт
        hint parseText "<t color='#FFFF00'>Обработка погашения кредита...</t>";
        sleep 1;  // Маленькая пауза
        
        // Меняем текст хинта на "Кредит погашен!"
        hint parseText "<t color='#00FF00'>Кредит погашен!</t>";
        sleep 4;  // Пауза на 4 секунды
        
        // Убираем хинт
        ["", player] remoteExec ["hint", player];
    };
    
    // Автообновление диалога
    [] spawn {
        waitUntil {!isNull player};
        while {true} do {
            if (!isNull (findDisplay 6000)) then {
                [] call bank_fnc_updateDialog;
            };
            sleep 0.5;
        };
    };
    
    // Добавляем действие к банкоматам
    [] spawn {
        waitUntil {time > 1};
        {
            _x addAction [
                "<t color='#00FF00'>[Банковская система]</t>",
                {
                    createDialog "BankDialog";
                    [] call bank_fnc_updateDialog;
                },
                nil, 1.5, true, true, "",
                "player distance _target < 3", 5
            ];
        } forEach (allMissionObjects "Land_ATM_01_malden_F");
    };
};