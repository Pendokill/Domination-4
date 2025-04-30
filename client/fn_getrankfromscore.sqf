// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (_this < d_points_needed # 0) exitWith {"Рядовой"};
if (_this < d_points_needed # 1) exitWith {"Ефрейтор"};
if (_this < d_points_needed # 2) exitWith {"Сержант"};
if (_this < d_points_needed # 3) exitWith {"Лейтенант"};
if (_this < d_points_needed # 4) exitWith {"Капитан"};
if (_this < d_points_needed # 5) exitWith {"Майор"};
if (_this < d_points_needed # 6) exitWith {"Полковник"};
"Генерал"
