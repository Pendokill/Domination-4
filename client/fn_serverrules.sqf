// by Xeno //Миссия Доминация: <a underline='true' color='#00ff4c' href='https://zonats.ru/topic/7598-missija-dominacija-cup-chernarus/'>Обсудить</a><br/>
//#define __DEBUG__
#include "..\x_setup.sqf"

"Приветствуем на Доминации!" hintC [
    parseText 
	"
	<img size='10' align='center' image='pics\domproc.paa'/>
	<br/><t align='center'><t size='1.2'><t color='#FF0000'>ПРАВИЛА СЕРВЕРА</t><br/>
	<br/><t align='left'><t size='1'>
	1) Стрельба, уничтожение объектов и транспорта на базе - автокик<br/>
	2) Намеренное уничтожение команды - тюрьма<br/>
	3) Словесные оскорбления недопустимы<br/>
	4) VOIP в глобальном\Групповом канале не допускается<br/>
	5) Разбил технику - притащи на Рем. точку<br/>
	6) Моды с арсеналом, телепортом, спавном - бан!<br/>
	<br/>
	<t align='left'><t size='1'>
	Сайт: <a underline='true' color='#00ff4c' href='https://zonats.ru'>Посетить</a><br/>
	Миссия Доминация: <a underline='true' color='#00ff4c' href='https://zonats.ru/topic/5243-missija-dominacija-malden-stratis-altis/'>Обсудить</a><br/>
	Улучшить ФПС: <a underline='true' color='#00ff4c' href='https://zonats.ru/topic/5448-nastrojka-i-optimizacija-arma-3/'>Мне нужно!</a><br/>
	Группа ВК: <a underline='true' color='#00ff4c' href='https://vk.com/club10671900'>Зайти</a><br/>
	Рекомендуемые моды: <a underline='true' color='#00ff4c' href='https://steamcommunity.com/sharedfiles/filedetails/?id=2713618821'>Подписаться</a><br/>
	Наш взвод: <a underline='true' color='#00ff4c' href='https://units.arma3.com/unit/spnaz'>Втупить</a><br/>
	<br/></t></t>
	"
];

d_hintC_EH = findDisplay 57 displayAddEventHandler ["unload", {
	0 = _this spawn {
		scriptName "spawn_serverrules";
		_this # 0 displayRemoveEventHandler ["unload", d_hintC_EH];
		d_hintC_EH = nil;
		hintSilent "";
	};
}];
