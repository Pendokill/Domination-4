private _dialog = findDisplay 5000;
if (isNull _dialog) exitWith { hint "Ошибка: диалог не найден"; };

private _vehicleList = _dialog displayCtrl 5001;
private _selectedIndex = lbCurSel _vehicleList;

if (_selectedIndex == -1) exitWith {
    hint "Выберите технику из списка!";
};

private _className = _vehicleList lbData _selectedIndex;
private _cost = _vehicleList lbValue _selectedIndex;

// Проверка очков
private _currentPoints = [player] call vehicleShop_getPoints;
if (_currentPoints < _cost) exitWith {
    hint format ["Недостаточно очков! Нужно %1, у вас %2", _cost, _currentPoints];
};

// Передаем ВСЕ необходимые данные на сервер
[player, _selectedIndex, _className, _cost] remoteExec ["vehicleShop_purchase", 2];

hint "Обработка покупки...";
closeDialog 0;