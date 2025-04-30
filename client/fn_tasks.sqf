// by Xeno
//#define __DEBUG__
#include "..\x_setup.sqf"

if (isNil "d_MaxNumAmmoboxes") then {
	waitUntil {!isNil "d_MaxNumAmmoboxes"};
};

#define __BR "<br/>"
#define __BRBR "<br/><br/>"
#define __BRBRBR "<br/><br/><br/>"

_index = player createDiarySubject ["Diary","Брифинг"];
_rankString = "Вам присваиваются звания в зависимости от вашего счёта:";
_rankString = _rankString + format ["<br/><img image='pics\1.paa' width='32' height='64'/> 0 очей   = РЯДОВОЙ (PRIVATE)<br/>
<img image='pics\2.paa' width='32' height='64'/> %2 очей = ЕФРЕЙТОР (CORPORAL)<br/>
<img image='pics\3.paa' width='32' height='64'/> %3 очей = СЕРЖАНТ (SERGEANT)<br/>
<img image='pics\4.paa' width='32' height='64'/> %4 очей = ЛЕЙТЕНАНТ (LIEUTENANT)<br/>
<img image='pics\5.paa' width='32' height='64'/> %5 очей = КАПИТАН (CAPTAIN)<br/>
<img image='pics\6.paa' width='32' height='64'/> %6 очей = МАЙОР (MAJOR)<br/>
<img image='pics\7.paa' width='32' height='64'/> %7 очей = ПОЛКОВНИК (COLONEL)<br/>
<img image='pics\8.paa' width='32' height='64'/> %8 очей = ГЕНЕРАЛ (GENERAL)<br/><br/>", 0, d_points_needed_db # 0, d_points_needed_db # 1, d_points_needed_db # 2, d_points_needed_db # 3, d_points_needed_db # 4, d_points_needed_db # 5, d_points_needed_db # 6];
player createDiaryRecord ["Diary", ["Ранг игроков", _rankString]];

_textCQ = ["
<img image='pics\domproc.paa' width='368' height='184'/><br/><br/>
<font color='#42aaff'>ОСНОВНОЕ ЗАДАНИЕ</font><br/>
<font color='#33ffba'>ЗЕЛЁНЫМ</font> выделено основное задание, <font color='#005aeb'>СИНИМ</font> отмечена занятая противником территория.<br/>
1. <font color='#33ffba'>Радиовышка:</font> подрывается только взрывчаткой (2х400).<br/>
2. <font color='#33ffba'>Казармы:</font> нужно захватывать (стоять рядом) или подрываются взрывчаткой (1х400), зависит от настроек миссии.<br/>
3. <font color='#33ffba'>Блокпосты:</font> нужно захватывать (стоять рядом).<br/>
4. <font color='#33ffba'>Вторичные задания:</font> выполняются по желанию, описаны в меню U-1. <font color='#8E8E8E'>СОВЕТ...</font> обыскивайте тела ликвидируемых целей вторичных заданий!!!<br/>
<font color='#8E8E8E'>СОВЕТ...</font> спас жизнь товарищу - жизнь прибавилась тебе!<br/><br/>
<font color='#42aaff'>ДОПОЛНИТЕЛЬНОЕ ЗАДАНИЕ</font><br/>
Выполняются по желанию, описаны в меню U-1. За выполнение доп-заданий даётся бонус-техника и авиация!
"] joinString "";

player createDiaryRecord 
["Diary",["Игровой процесс",_textCQ]];

//<font face='PuristaMedium' size=22 color='#014EE3'>If you are unconscious:</font><br/>
//- You can <font face='PuristaMedium' size=15 color='#8E8E8E'>СЕРЫЙ ЦВЕТ</font> to a safe position.<br/><br/>
player createDiaryRecord 
["Diary",["Особенности игры","
НАСТРОЙКИ (меню действий) - основные настройки игры, статистика и задания, находятся в меню U-1.<br/><br/>
<font color='#e54934'>БАЗА</font> <marker name='base_spawn_1'>(обзор)</marker> - Служит в качестве стартовой позиции, десантирования, телепорта для перемещения, позиции возрождения транспорта, техники, авиации, доступа к виртуальному арсеналу и ремонтым площадкам для подбитой техники.<br/>
<font color='#e54934'>АВАНПОСТ</font> <marker name='d_farp_marker_l'>(обзор</marker>, от 1 до 3) - Служит в качестве дополнительной позиции возрождения, десантирования, телепорта, позиции возрождения транспорта, техники, доступа к оружию и ПРП техники (Перевалочный Рем-Пункт).<br/>
<font color='#e54934'>АВИАНОСЕЦ</font> <marker name='Carrier'>(обзор</marker>, не везде) - Служит в качестве дополнительной позиции возрождения, десантирования, телепорта для перемещения, позиции возрождения авиации и доступа к оружию.<br/><br/>
<font color='#33ffba'>ТОЧКИ РЕМОНТА</font> - служат в качестве обслуживания техники и авиации, а так же полного восстановления разбитой бонус-техники и бонус-авиации.<br/>
 1. <marker name='lamp_01'>Сервис техники:</marker> мелкий ремонт, заправка, загрузка БК для транспорта и бронетехники.<br/>
 2. <marker name='lamp_02'>Сервис вертолетов:</marker> мелкий ремонт, заправка, загрузка БК и смена пилонов для вертолётов.<br/>
 3. <marker name='d_base_jet_fac'>Авиасервис:</marker> мелкий ремонт, заправка, загрузка БК и смена пилонов для самолётов.<br/>
 4. <marker name='d_base_wreck_fac'>Точка ремонта:</marker> полное восстановление разбитой бонус-техники и авиации. Обломки перевозятся только вертолётом - Ремка!<br/>
 5. <marker name='lamp_03serviceall_trigger'>Точка ремонта АВАНПОСТ:</marker> мелкий ремонт, заправка, загрузка БК для вертолётов, транспорта и бронетехники.<br/>
<font color='#33ffba'>ФЛАГИ</font> - служат в качестве десантирования и телепортов для быстрого перемещения между БАЗОЙ, КШМ, АВАНПОСТОМ и АВИАНОСЦЕМ.<br/>
<font color='#33ffba'>РЕСПАУН</font> - Выбрать возрождение можно на <marker name='base_spawn_1'>БАЗЕ</marker>, <marker name='d_farp_marker_l'>АВАНПОСТУ</marker>, на <marker name='Carrier'>АВИАНОСЦЕ</marker> или на месте своего командира взвода.<br/>
<font color='#33ffba'>ЛЕЧЕНИЕ</font> - Игрок может быть оживлён игроком или своим бойцом AI, если были наняты в <marker name='d_pos_aihut'>КАЗАРМЕ</marker> на БАЗЕ (может быть выключено).<br/>
<font color='#33ffba'>ТЮРЬМА</font> - служит в качестве наказания тимкиллеров. При достижении определённого минуса в очках, такой игрок автоматически заключается за решётку на некоторое время.<br/><br/>
<font color='#33ffba'>АТАКИ НА БАЗУ</font> - периодически противник засылает десант диверсантов на основную БАЗУ. Где они устраивают диверсии подрывая технику, Артрасчёт и уничтожая игроков на месте возрождения.<br/>
<font color='#33ffba'>ПВО</font> - на ГЛАВНОЙ ТОЧКЕ образуется целая цитадель противовоздушной и противотанковой обороны (рандомно миссией)! Вас может встретить корабельная турель, ракетная шахта, ракетная установка стационарные ПВО-установки + пехота со стингерами. Выполняя полёты, будьте осторожны и не лезьте напролом.<br/>
<font color='#33ffba'>ПТРК</font> - на ГЛАВНОЙ ТОЧКЕ кроме танков и бронетехники противника с ПТРК, вас может сразить (если вы на технике) корабельная турель и пехота с джавелинами.<br/><br/>
<font color='#33ffba'>ВТОРИЧНОЕ ЗАДАНИЕ</font> - на ГЛАВНЫХ ТОЧКАХ появляются дополнительные задания по мере зачистки городов (необязательны для выполнения), но дают дополнительные очки.<br/>
 1. <font color='#8E8E8E'>Военнопленные:</font> нужно уничтожить охрану и встать (на некоторое время) рядом с пленным.<br/>
 2. <font color='#8E8E8E'>Везунчик:</font> нужно найти попавшего в беду и защищать требуемое время от атак противника.<br/>
 3. <font color='#8E8E8E'>В тылу врага:</font> при сообщении о игроке, действующего в тылу противника, ему нужно находиться требуемое время в радиусе ГЛАВНОЙ ТОЧКИ.<br/><br/>
<font color='#33ffba'>БОЕВАЯ ПОДДЕРЖКА</font> - вы можете запрашивать поддержку в виде Артударов и Авиаударов (нужен лазерный целеуказатель - Песок или др.), Эвакуатора, автомобиля и ящика с БК!<br/>
 1. <font color='#8E8E8E'>Артудар:</font> навести на место для удара, кликнуть ЛКМ, прокрутить колёсико мышки, в меню выбрать - Указать цель для артиллерии, нажать колёсико мышки. Выбираем тип снаряда, кол-во залпов и кликаем - Запрос артиллерии! Этим мы указали цель! Далее жмём U-2<br/>
 2. <font color='#8E8E8E'>Авиаудар:</font> навести на место для удара, кликнуть ЛКМ, прокрутить колёсико мышки, в меню выбрать - Запрос Авиаудара, нажать колёсико мышки.<br/>
 3. <font color='#8E8E8E'>Эвакуатор:</font> нажать U-3 (или в меню - Эвакуатор).<br/>
 4. <font color='#8E8E8E'>Автомобиль и БК:</font> нажать U-4 (или в меню - Вызвать сброс), далее выбираем Транспорт или БК.<br/>
 5. <font color='#8E8E8E'>Союзники:</font> периодически (рандомно миссией) к нам на помощь идут наши союзники в виде Мотопехоты или Пехотных взводов на зачистку ГЛАВНЫХ ТОЧЕК.
"]];

private _bar = [
	localize "STR_DOM_MISSIONSTRING_23", __BR,
	"<font face='RobotoCondensed' size=42 color='#e54934'>ДОМИНАЦИЯ 4!</font>, <img image='pics\domls.paa' width='368' height='184'/>", __BRBR,
	"Заходите на Портал игрового сообщества: <font color='#33ffba'>ZONATS.RU</font>", __BRBR,
	localize "STR_DOM_MISSIONSTRING_24", __BR,
	localize "STR_DOM_MISSIONSTRING_25", __BRBRBR,
	localize "STR_DOM_MISSIONSTRING_26", __BRBR,
	localize "STR_DOM_MISSIONSTRING_27", __BRBR,
	localize "STR_DOM_MISSIONSTRING_28", __BRBR,
	localize "STR_DOM_MISSIONSTRING_29", __BR,
	localize "STR_DOM_MISSIONSTRING_30", __BR,
#ifndef __TT__
	format [localize "STR_DOM_MISSIONSTRING_31", d_MaxNumAmmoboxes], __BR,
#else
	format [localize "STR_DOM_MISSIONSTRING_39", d_MaxNumAmmoboxes], __BR,
#endif
	localize "STR_DOM_MISSIONSTRING_32", __BR,
	localize "STR_DOM_MISSIONSTRING_33", __BRBR,
	localize "STR_DOM_MISSIONSTRING_34", __BR,
	localize "STR_DOM_MISSIONSTRING_35", __BR,
	localize "STR_DOM_MISSIONSTRING_36", __BR,
	localize "STR_DOM_MISSIONSTRING_37", __BRBR,
	localize "STR_DOM_MISSIONSTRING_40", __BRBR,
	localize "STR_DOM_MISSIONSTRING_41", __BR,
	localize "STR_DOM_MISSIONSTRING_42", __BRBR,
	localize "STR_DOM_MISSIONSTRING_43", __BRBR,
	localize "STR_DOM_MISSIONSTRING_44", __BR,
	localize "STR_DOM_MISSIONSTRING_46", __BRBR,
	localize "STR_DOM_MISSIONSTRING_48", __BRBR,
	localize "STR_DOM_MISSIONSTRING_51", __BR,
	localize "STR_DOM_MISSIONSTRING_52", __BR,
	localize "STR_DOM_MISSIONSTRING_54", __BRBR,
	localize "STR_DOM_MISSIONSTRING_55", __BR,
	localize "STR_DOM_MISSIONSTRING_58", __BRBR,
	localize "STR_DOM_MISSIONSTRING_61", __BRBR,
	"Thanks to all people who donate, you guys are great :-)", __BRBR
];

player createDiaryRecord ["Diary", ["Брифинг", _bar joinString ""]];

player createDiarySubject ["dLicense","Лицензия"];
player createDiaryRecord ["dLicense", ["License", "
Arma Public License Share Alike (APL-SA)<br/><br/>
https://www.bohemia.net/community/licenses/arma-public-license-share-alike<br/><br/>
Вы можете:<br/><br/>
Share - copy and redistribute the material in any medium or format<br/><br/>
The licensor cannot revoke these freedoms as long as you follow the license terms.<br/><br/><br/>
Under the following terms:<br/><br/>
Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner,<br/>
but not in any way that suggests the licensor endorses you or your use.<br/><br/>
NonCommercial - You may not use the material for commercial purposes.<br/><br/>
NoDerivatives - If you remix, transform, or build upon the material, you may not distribute the modified material.<br/><br/><br/>
No additional restrictions - You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
"]];

if (d_database_found && {getClientStateNumber < 10}) then {
	if (!isNil "d_db_savegames" && {serverCommandAvailable "#shutdown" || {isServer}}) then {
		player createDiarySubject ["dDBLoad", localize "STR_DOM_MISSIONSTRING_1750"];
		private _helperar = [];
		{
			_helperar pushBack format ["<execute expression='%1 call d_fnc_db_load_savegame'>%2</execute><br/>", _forEachIndex, _x];
		} forEach d_db_savegames;
		player createDiaryRecord ["dDBLoad", [localize "STR_DOM_MISSIONSTRING_1750", format [localize "STR_DOM_MISSIONSTRING_1751", "<br/><br/>", _helperar joinString ""]]];
	};
};

waitUntil {!isNil "d_current_target_index"};

private _tstate = ["Succeeded", "Assigned"] select (d_current_target_index == -1);
[true, "d_obj00", [localize "STR_DOM_MISSIONSTRING_62", localize "STR_DOM_MISSIONSTRING_62", localize "STR_DOM_MISSIONSTRING_62"], getPosWorld player, _tstate, 2, false, "Defend", false] call d_fnc_taskcreate;

d_obj00_task = true;
