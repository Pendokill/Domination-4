private _dialog = findDisplay 5000;
if (isNull _dialog) exitWith { hint "������: ������ �� ������"; };

private _vehicleList = _dialog displayCtrl 5001;
private _selectedIndex = lbCurSel _vehicleList;

if (_selectedIndex == -1) exitWith {
    hint "�������� ������� �� ������!";
};

private _className = _vehicleList lbData _selectedIndex;
private _cost = _vehicleList lbValue _selectedIndex;

// �������� �����
private _currentPoints = [player] call vehicleShop_getPoints;
if (_currentPoints < _cost) exitWith {
    hint format ["������������ �����! ����� %1, � ��� %2", _cost, _currentPoints];
};

// �������� ��� ����������� ������ �� ������
[player, _selectedIndex, _className, _cost] remoteExec ["vehicleShop_purchase", 2];

hint "��������� �������...";
closeDialog 0;