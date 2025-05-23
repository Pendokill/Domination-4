﻿private ["_action"];
_action = _this select 0;

switch (_action) do {
	case "onLoad": {
		{((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160001) lbAdd _x} forEach [localize "$STR_Intro_01", localize "$STR_Intro_02", localize "$STR_Intro_03", localize "$STR_Intro_04", localize "$STR_Intro_05", localize "$STR_Intro_06", localize "$STR_Intro_10"];
		((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160001) lbSetCurSel 0;
	};
	case "onHelpLBSelChanged": {
		_changeTo = _this select 1;
		
_helps = [
"<t size='1.4' color='#2394ef'>Инструктаж</t><br /><br />
	<t align='center'><img image='pics\domls.paa' size='13'/></t><br /><br />
	Вы должны освободить остров от всех сил противника!<br />
	- Главная задача Доминации - зачистить города от агрессоров <t color='#42aaff'>(PvE)</t>, и сделать это желательно раньше команды противника <t color='#42aaff'>(PvP)</t>. Основные цели - это Радиовышка - нужно взорвать её, выполнить вторичное задание (уничтожить офицера врга, предателя, ПРП техники и др.) уничтожить казармы и захватить все Блокпосты.<br />
	- Так же будут отдельные Допзадания, за которые ваша команда получит Технику и Авиацию.<br />
	- Вы можете транспортировать технику на своих вертолётах.<br />
	У вас есть Мобильный ШТАБ (КШМ) для перемещения его в точки боевых действий и дальнейшей телепортации на него с БАЗЫ. После развертывания КШМ, вы можете телепортироваться от одного КШМ к другому, активировать БПЛА, включить спутниковое отслеживание или создать лёгкую технику.<br />
	Инженеры могут ремонтировать и заправлять транспорт, бронетехнику и авиацию (при наличии рем. комплекта). Инженеры также могут строить ПРП при наличии Инженерной машины, загружать/выгружать статичное оружие в инженерные грузовики и выгружать. Инженеры также могут переворачивать авиатехнику и автотранспорт, которые лежат в перевернутом виде, но только когда они имеют при себе ремкомплект (в режиме ИИ, каждый бот может проделать так же).<br />
	Вся техника и авиация, которую Вы выиграли при выполнении Допзаданий или Основной цели, после уничтожения может перевозиться вертолетом <t color='#e8bd12'>РЕМКА</t> на <t color='#e8bd12'>точки ремонта</t> техники! Где через некоторое время она будет восстановлена. Вертолёт Ремка - перевозит только подбитую бонус-технику!<br />
	Артрасчёт могут наносить удары на расстоянии (цели должны быть помечены лазерным целеуказателем). Они также способны помочь спасти заложников (в режиме ИИ, каждый игрок может делать это).<br />
	Командиры групп Морпехов, ВДВ,  и Спецназа могут запросить поддержку с воздуха. Они также могут пометить цели для артиллерии (нужен лазероуказатель).<br /><br />
	Более подробное описание: <t color='#f455aa'>Карта (М) - Инструктаж</t>!
",
"<t size='1.4' color='#2394ef'>Особенности игры</t><br /><br />
НАСТРОЙКИ (меню действий) - основные настройки игры, статистика и задания, находятся в меню <t color='#e54934'>U-1</t>.<br /><br />
<t color='#e54934'>БАЗА</t> - Служит в качестве стартовой позиции, десантирования, телепорта для перемещения, позиции возрождения транспорта, техники, авиации, доступа к виртуальному арсеналу и ремонтым площадкам для подбитой техники.<br />
<t color='#e54934'>АВАНПОСТ</t> (от 1 до 3) - Служит в качестве дополнительной позиции возрождения, десантирования, телепорта, позиции возрождения транспорта, техники, доступа к оружию и ПРП техники (Перевалочный Рем-Пункт).<br />
<t color='#e54934'>АВИАНОСЕЦ</t> - Служит в качестве дополнительной позиции возрождения, десантирования, телепорта для перемещения, позиции возрождения авиации и доступа к оружию.<br /><br />
<t color='#e8bd12'>ТОЧКИ РЕМОНТА</t> - служат в качестве обслуживания техники и авиации, а так же полного восстановления разбитой бонус-техники и бонус-авиации.<br />
 1. Сервис техники: мелкий ремонт, заправка, загрузка БК для транспорта и бронетехники.<br />
 2. Сервис вертолетов: мелкий ремонт, заправка, загрузка БК и смена пилонов для вертолётов.<br />
 3. Авиасервис: мелкий ремонт, заправка, загрузка БК и смена пилонов для самолётов.<br />
 4. Точка ремонта: полное восстановление разбитой бонус-техники и авиации. Обломки перевозятся только вертолётом - Ремка!<br />
 5. Точка ремонта АВАНПОСТ: мелкий ремонт, заправка, загрузка БК для вертолётов, транспорта и бронетехники.<br />
<t color='#e8bd12'>ФЛАГИ</t> - служат в качестве десантирования и телепортов для быстрого перемещения между БАЗОЙ, КШМ, АВАНПОСТОМ и АВИАНОСЦЕМ.<br />
<t color='#e8bd12'>РЕСПАУН</t> - Выбрать возрождение можно на БАЗЕ, АВАНПОСТУ, на АВИАНОСЦЕ или на месте своего командира взвода.<br />
<t color='#e8bd12'>ЛЕЧЕНИЕ</t> - Игрок может быть оживлён игроком или своим бойцом AI, если были наняты в КАЗАРМЕ на БАЗЕ (может быть выключено).<br />
<t color='#e8bd12'>ТЮРЬМА</t> - служит в качестве наказания тимкиллеров. При достижении определённого минуса в очках, такой игрок автоматически заключается за решётку на некоторое время.<br /><br />
<t color='#33ffba'>АТАКИ НА БАЗУ</t> - периодически противник засылает десант диверсантов на основную БАЗУ. Где они устраивают диверсии подрывая технику, Артрасчёт и уничтожая игроков на месте возрождения.<br />
<t color='#33ffba'>ПВО</t> - на ГЛАВНОЙ ТОЧКЕ образуется целая цитадель противовоздушной и противотанковой обороны (рандомно миссией)! Вас может встретить корабельная турель, ракетная шахта, ракетная установка стационарные ПВО-установки + пехота со стингерами. Выполняя полёты, будьте осторожны и не лезьте напролом.<br />
<t color='#33ffba'>ПТРК</t> - на ГЛАВНОЙ ТОЧКЕ кроме танков и бронетехники противника с ПТРК, вас может сразить (если вы на технике) корабельная турель и пехота с джавелинами.<br /><br />
<t color='#33ffba'>ВТОРИЧНОЕ ЗАДАНИЕ</t> - на ГЛАВНЫХ ТОЧКАХ появляются дополнительные задания по мере зачистки городов (необязательны для выполнения), но дают дополнительные очки.<br />
 1. <t color='#42aaff'>Военнопленные:</t> нужно уничтожить охрану и встать (на некоторое время) рядом с пленным.<br />
 2. <t color='#42aaff'>Везунчик:</t> нужно найти попавшего в беду и защищать требуемое время от атак противника.<br />
 3. <t color='#42aaff'>В тылу врага:</t> при сообщении о игроке, действующего в тылу противника, ему нужно находиться требуемое время в радиусе ГЛАВНОЙ ТОЧКИ.<br /><br />
",
"<t size='1.4' color='#2394ef'>Игровой процесс</t><br /><br />
<t align='center'><img image='pics\domproc.paa' size='10'/></t><br /><br />
<t color='#42aaff'>ОСНОВНОЕ ЗАДАНИЕ</t><br />
<t color='#33ffba'>ЗЕЛЁНЫМ</t> выделено основное задание, <t color='#005aeb'>СИНИМ</t> отмечена занятая противником территория.<br />
1. <t color='#33ffba'>Радиовышка:</t> подрывается только взрывчаткой (2х400).<br />
2. <t color='#33ffba'>Казармы:</t> нужно захватывать (стоять рядом) или подрываются взрывчаткой (1х400), зависит от настроек миссии.<br />
3. <t color='#33ffba'>Блокпосты:</t> нужно захватывать (стоять рядом).<br />
4. <t color='#33ffba'>Вторичные задания:</t> выполняются по желанию, описаны в меню U-1. <t color='#8E8E8E'>СОВЕТ...</t> обыскивайте тела ликвидируемых целей вторичных заданий!!!<br />
<t color='#33ffba'>БОЕВАЯ ПОДДЕРЖКА</t> - вы можете запрашивать поддержку в виде Артударов и Авиаударов (нужен лазерный целеуказатель - Песок или др.), Эвакуатора, автомобиля и ящика с БК!<br />
 1. <t color='#e8bd12'>Артудар:</t> навести на место для удара, кликнуть ЛКМ, прокрутить колёсико мышки, в меню выбрать - Указать цель для артиллерии, нажать колёсико мышки. Выбираем тип снаряда, кол-во залпов и кликаем - Запрос артиллерии! Этим мы указали цель! Далее жмём U-2<br />
 2. <t color='#e8bd12'>Авиаудар:</t> навести на место для удара, кликнуть ЛКМ, прокрутить колёсико мышки, в меню выбрать - Запрос Авиаудара, нажать колёсико мышки.<br />
 3. <t color='#e8bd12'>Эвакуатор:</t> нажать U-3 (или в меню - Эвакуатор).<br />
 4. <t color='#e8bd12'>Автомобиль и БК:</t> нажать U-4 (или в меню - Вызвать сброс), далее выбираем Транспорт или БК.<br />
 5. <t color='#e8bd12'>Союзники:</t> периодически (рандомно миссией) к нам на помощь идут наши союзники в виде Мотопехоты или Пехотных взводов на зачистку ГЛАВНЫХ ТОЧЕК.<br /><br />
<t color='#e54934'>СОВЕТ...</t> спас жизнь товарищу - жизнь прибавилась тебе!<br /><br />
<t color='#42aaff'>ДОПОЛНИТЕЛЬНОЕ ЗАДАНИЕ</t><br />
Выполняются по желанию, описаны в меню U-1. За выполнение доп-заданий даётся бонус-техника и авиация!
",
"<t size='1.4' color='#2394ef'>Наёмники</t><br /><br />
<t align='center'><img image='pics\AI2.paa' size='8'/></t><br /><br />
В Доминации можно нанимать в свою команду бойцов (<t color='#e54934'>зависит от режима игры</t>), каждый юнит выполняет свою функцию! <br />
<t color='#33ffba'>Например...</t> <br />
<t color='#e8bd12'>Медик</t> - всегда поднимет вас, юнита и других игроков на сервере! Начинает действовать после того, как раненный попросит помощи.<br />
<t color='#e8bd12'>Лётчик или Вертолётчик</t> - лучше определяет цели. Для стрельбы наводящими ракетами, вам нужно указать цель и самому нажать ЛКМ.<br />
<t color='#e8bd12'>Экипаж бронетехники</t> - лучше определяет цели. Для стрельбы наводящими ракетами, вам нужно указать цель и самому нажать ЛКМ. Стрелку сами переключаем орудие, ракеты или пулемёт через <t color='#e54934'>F</t>. Если вы покинули машину, юниты сами переключают оружие и работают по целям.<br />
<t color='#e8bd12'>Инженер</t> - переворачивает-ремонтирует технику и авиацию, минирует-разминирует.<br />
<t color='#e8bd12'>Спецназ</t> или <t color='#e8bd12'>Разведчик</t> - для штурма или ближнего боя вам не найти бойцов лучше, чем эти ребята.<br />
Всегда выбирайте нужных бойцов для выполнения определённых задач!<br /><br />
Учимся управлять юнитами: <a underline='true' color='#00ff4c' href='https://zonats.ru/topic/5363-upravlenie-botami-v-arma-3/'>форум</a><br /><br />
",
"<t size='1.4' color='#2394ef'>Рекомендуемые моды</t><br /><br />
 <t align='center'><img image='A3\data_f\SteamPublisher\All\Arma3_workshop_addon.jpg' size='9'/></t><br /><br />
Для полного погружения в игру и ощущения боевых действий, советуем вам установить <img image='A3\ui_f\data\GUI\RscCommon\RscButtonMenuSteam\steam_ca.paa' size='1'/><t color='#00ff4c'><a underline='true' href='https://steamcommunity.com/sharedfiles/filedetails/?id=2713618821'> Рекомендуемые моды</a></t>!<br /><br />
",
"<t size='1.4' color='#2394ef'>Очки и Звания</t><br /><br />
Вам присваиваются звания в зависимости от вашего счёта:<br /><br />
<img image='pics\1.paa' size='3.5'/>   <t color='#e8bd12'>0</t> очей  =  <t color='#33ffba'>РЯДОВОЙ (PRIVATE)</t><br/>
<img image='pics\2.paa' size='3.5'/>   <t color='#e8bd12'>500</t> очей  =  <t color='#33ffba'>ЕФРЕЙТОР (CORPORAL)</t><br/>
<img image='pics\3.paa' size='3.5'/>   <t color='#e8bd12'>2000</t> очей  =  <t color='#33ffba'>СЕРЖАНТ (SERGEANT)</t><br/>
<img image='pics\4.paa' size='3.5'/>   <t color='#e8bd12'>5000</t> очей  =  <t color='#33ffba'>ЛЕЙТЕНАНТ (LIEUTENANT)</t><br/>
<img image='pics\5.paa' size='3.5'/>   <t color='#e8bd12'>9000</t> очей  =  <t color='#33ffba'>КАПИТАН (CAPTAIN)</t><br/>
<img image='pics\6.paa' size='3.5'/>   <t color='#e8bd12'>16000</t> очей  =  <t color='#33ffba'>МАЙОР (MAJOR)</t><br/>
<img image='pics\7.paa' size='3.5'/>   <t color='#e8bd12'>30000</t> очей  =  <t color='#33ffba'>ПОЛКОВНИК (COLONEL)</t><br/>
<img image='pics\8.paa' size='3.5'/>   <t color='#e8bd12'>50000</t> очей  =  <t color='#33ffba'>ГЕНЕРАЛ (GENERAL)</t><br /><br />
<t color='#eaff96'>Выполняйте задания и зарабатывайте очки</t>!
",
"<t size='1.4' color='#2394ef'>ПРАВИЛА СЕРВЕРА И СВЯЗЬ</t><br /><br />
	1) Стрельба, уничтожение объектов и транспорта на базе - автокик<br/>
	2) Намеренное уничтожение команды - тюрьма<br/>
	3) Словесные оскорбления недопустимы<br/>
	4) VOIP в глобальном\Групповом канале не допускается<br/>
	5) Разбил технику - притащи на Рем. точку<br/>
	6) <t color='#e54934'>ЗАПРЕЩЕНО</t>: <t color='#e8bd12'>использование модов и паков техники, авиации, амуниции и оружия - кроме рекомендуемых</t>!!! <t color='#e54934'>БАН</t> незамедлительно!<br/><br/> 
	Сайт: <a underline='true' color='#00ff4c' href='https://zonats.ru'>Посетить</a><br/>
	Миссия Доминация: <a underline='true' color='#00ff4c' href='https://zonats.ru/topic/5243-missija-dominacija-malden-stratis-altis/'>Обсудить</a><br/>
	Улучшить ФПС: <a underline='true' color='#00ff4c' href='https://zonats.ru/topic/5448-nastrojka-i-optimizacija-arma-3/'>Мне нужно!</a><br/>
	Группа ВК: <a underline='true' color='#00ff4c' href='https://vk.com/club10671900'>Зайти</a><br/>
	Рекомендуемые моды: <a underline='true' color='#00ff4c' href='https://steamcommunity.com/sharedfiles/filedetails/?id=2713618821'>Подписаться</a><br/>
	Наш взвод: <a underline='true' color='#00ff4c' href='https://units.arma3.com/unit/spnaz'>Втупить</a>
",
"<t size='1.4' color='#2394ef'>Наёмники</t><br /><br />
Aside from the Commander, there are multiple <t color='#e8bd12'>Teams</t> (labeled as <t color='#eaff96'>Alpha</t>, <t color='#eaff96'>Bravo</t>, <t color='#eaff96'>Charlie</t>...) which may be controlled by either the AI (if enabled) or a player. Without an order from the Commander, those units will run toward the closest hostile town.<br /><br />
<t align='center'><img image='\A3\ui_f\data\map\Markers\NATO\b_inf.paa' size='2'/> <img image='\A3\ui_f\data\map\Markers\NATO\o_inf.paa' size='2'/></t><br /><br />
A Team Leader receives a percentage of the total resource income earned. Assuming the value is set on <t color='#f455aa'>30 percent</t> for the <t color='#e8bd12'>Player Pool</t> and that there are <t color='#f455aa'>3 Team Leaders</t> on your side (excluding the Commander) then each of those units will receive <t color='#f455aa'>10 percent</t> of the pool resources (30 / 3).<br /><br />
Team Leaders may also earn resource from the <t color='#e8bd12'>Award Pool</t>. This pool awards the Team Leaders based on their combative and non combative score. Assuming that the Award Pool is set on <t color='#f455aa'>10 percent</t> and that there is <t color='#f455aa'>2 Team Leaders</t> with a score of <t color='#f455aa'>75</t> and <t color='#f455aa'>25</t> then the first one will receive <t color='#f455aa'>75 percent</t> of the pool resources.<br /><br />
The <t color='#e8bd12'>Player Pool</t> and the <t color='#e8bd12'>Award Pool</t> percentage may be viewed from the <t color='#eaff96'>Options Menu</t>. The <t color='#e8bd12'>Commander</t> may raise or lower them from within the <t color='#eaff96'>Transfer Resources Menu</t>.
"
];
		((uiNamespace getVariable "cti_dialog_ui_onlinehelpmenu") displayCtrl 160002) ctrlSetStructuredText parseText (_helps select _changeTo);
	};
};