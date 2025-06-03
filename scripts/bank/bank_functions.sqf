// by Pirat
bank_fnc_takeLoan = {
    if (isNil "bank_selectedAmount" || isNil "bank_selectedTime") exitWith {
        hint "Выберите сумму и срок кредита!";
    };
    
    private _playerUID = getPlayerUID player;
    private _currentDebt = 0;
    
    // Проверяем текущий долг игрока
    {
        if ((_x select 0) == _playerUID) exitWith {
            _currentDebt = _x select 2;
        };
    } forEach bank_loans;
    
    // Если у игрока уже есть долг
    if (_currentDebt > 0) then {
        hint format["У вас уже есть непогашенный кредит на %1 очей!", _currentDebt];
    } else {
        private _playerBalance = score player; // Используем систему очков вместо dinero
        private _interestRate = 0;
        
        // Определяем процентную ставку
        switch (bank_selectedTime) do {
            case 3: { _interestRate = 0.1; };
            case 6: { _interestRate = 0.3; };
            case 12: { _interestRate = 0.5; };
            case 24: { _interestRate = 1.0; };
        };
        
        // Если баланс отрицательный, удваиваем ставку
        if (_playerBalance < 0) then {
            _interestRate = 1.0;
            if (bank_selectedTime > 6) then {
                bank_selectedTime = 6;
                hint "При отрицательном балансе максимальный срок - 6 часов!";
            };
        };
        
        private _totalToPay = bank_selectedAmount * (1 + _interestRate);
        private _dueTime = serverTime + (bank_selectedTime * 3600);
        
        // Добавляем кредит в систему
        bank_loans pushBack [_playerUID, bank_selectedAmount, _totalToPay, _dueTime, false];
        publicVariable "bank_loans";
        
        // Выдаем деньги игроку через систему очков
        player addScore bank_selectedAmount;
        hint format["Вы взяли кредит на %1 очей. К возврату: %2 очей через %3 ч.", bank_selectedAmount, _totalToPay, [(_dueTime - serverTime), "HH:MM:SS"] call BIS_fnc_secondsToString];
    };
};

bank_fnc_payLoan = {
    private _playerUID = getPlayerUID player;
    private _playerBalance = score player; // Используем систему очков
    private _loanIndex = -1;
    private _loanToPay = [];
    
    // Находим кредит игрока
    {
        if ((_x select 0) == _playerUID) exitWith {
            _loanToPay = _x;
            _loanIndex = _forEachIndex;
        };
    } forEach bank_loans;
    
    if (_loanIndex == -1) exitWith {
        hint "У вас нет активных кредитов!";
    };
    
    private _amountToPay = _loanToPay select 2;
    
    if (_playerBalance < _amountToPay) exitWith {
        hint format["Недостаточно средств для погашения! Нужно: %1 очей", _amountToPay];
    };
    
    // Погашаем кредит через систему очков
    player addScore -_amountToPay;
    bank_loans deleteAt _loanIndex;
    publicVariable "bank_loans";
    
    hint "Кредит успешно погашен!";
};

// Обновленная функция проверки просроченных кредитов
bank_fnc_checkLoans = {
    {
        private _playerUID = _x select 0;
        private _originalAmount = _x select 1;
        private _totalToPay = _x select 2;
        private _dueTime = _x select 3;
        private _isOverdue = _x select 4;
        
        if (serverTime > _dueTime) then {
            if (!_isOverdue) then {
                // Первая просрочка
                private _player = [_playerUID] call BIS_fnc_getUnitByUID;
                if (!isNull _player) then {
                    // Сажаем в тюрьму
                    [_player, 300] remoteExec ["fn_jail", _player];
                    
                    // Увеличиваем долг на 50%
                    private _newTotal = _totalToPay * 1.5;
                    bank_loans set [_forEachIndex, [_playerUID, _originalAmount, _newTotal, _dueTime + (_dueTime - serverTime), true]];
                    publicVariable "bank_loans";
                    
                    hint parseText format[
                        "<t color='#FF0000'>Вы просрочили кредит! Долг увеличен на 50%. Новый долг: %1 очей</t>", 
                        _newTotal
                    ];
                };
            } else {
                // Вторая просрочка - списываем средства и баним
                private _player = [_playerUID] call BIS_fnc_getUnitByUID;
                if (!isNull _player) then {
                    // Списываем очки (может уйти в минус)
                    private _currentScore = score _player;
                    _player addScore -_totalToPay;
                    
                    // Баним на 24 часа
                    [_player, "Bank system", 86400] remoteExec ["fn_banPlayer", 2];
                    
                    // Удаляем кредит
                    bank_loans deleteAt _forEachIndex;
                    publicVariable "bank_loans";
                    
                    hint parseText "<t color='#FF0000'>Вы не погасили кредит вовремя! Средства списаны, вы забанены на 24 часа.</t>";
                };
            };
        };
    } forEach bank_loans;
};

// Обновленная функция для диалога
bank_fnc_updateDialog = {
    private _display = findDisplay 5000;
    if (isNull _display) exitWith {};
    
    private _playerBalance = score player; // Используем систему очков
    (_display displayCtrl 5010) ctrlSetText format["Ваш баланс: %1 очей", _playerBalance];
    
    private _playerUID = getPlayerUID player;
    private _hasLoan = false;
    
    {
        if ((_x select 0) == _playerUID) exitWith {
            _hasLoan = true;
            private _dueTime = _x select 3;
            private _timeLeft = _dueTime - serverTime;
            
            if (_timeLeft > 0) then {
                (_display displayCtrl 5012) ctrlSetText format["Погасить (%1)", [(_timeLeft), "HH:MM:SS"] call BIS_fnc_secondsToString];
            } else {
                (_display displayCtrl 5012) ctrlSetText "Просрочено!";
            };
        };
    } forEach bank_loans;
    
    if (!_hasLoan) then {
        (_display displayCtrl 5012) ctrlEnable false;
    };
};