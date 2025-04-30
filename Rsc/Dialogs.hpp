#include "Styles.hpp"

class CTI_RscOnlineHelpMenu {
	movingEnable = 0;
	idd = 160000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_onlinehelpmenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_OnlineHelpMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_onlinehelpmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_OnlineHelpMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.1)";
			y = "SafeZoneY + (SafezoneH * 0.105)";
			w = "SafeZoneW * 0.8";
			h = "SafeZoneH * 0.8";
			colorBackground[] = {0, 0, 0, 0.7};
			moving = 1;
		};
		class CTI_Background_Header : CTI_Background {
			x = "SafeZoneX + (SafeZoneW * 0.1)";
			y = "SafeZoneY + (SafezoneH * 0.105)";
			w = "SafeZoneW * 0.8";
			h = "SafeZoneH * 0.05"; //0.06 stock
			colorBackground[] = {0, 0, 0, 0.4};
		};
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = "SafeZoneX + (SafeZoneW * 0.12)";
			y = "SafeZoneY + (SafezoneH * 0.11)";
			w = "SafeZoneW * 0.78";
			h = "SafeZoneH * 0.037";

			text = "Информация по Доминации";
			colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CTI_Menu_InfoListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW * 0.12)";
			y = "SafeZoneY + (SafezoneH * 0.175)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.71";
		};
		class CTI_Menu_InfoResourcesFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW * 0.34)";
			y = "SafeZoneY + (SafezoneH * 0.175)";
			w = "SafeZoneW * 0.54";
			h = "SafeZoneH * 0.71";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.34)";
			y = "SafeZoneY + (SafezoneH * 0.175)";
			w = "SafeZoneW * 0.54";
			h = "SafeZoneH * 0.71";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Control_Exit : RscButton {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.84)";
			y = "SafeZoneY + (SafezoneH * 0.11)";
			w = "SafeZoneW * 0.04";
			h = "SafeZoneH * 0.04";

			text = "X";
			action = "closeDialog 0";
		};
	};

	class controls {
		class CTI_Menu_Help_Topics : RscListBox {
			idc = 160001;

			x = "SafeZoneX + (SafeZoneW * 0.12)";
			y = "SafeZoneY + (SafezoneH * 0.175)";
			w = "SafeZoneW * 0.2";
			h = "SafeZoneH * 0.71";

			rowHeight = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.90 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			onLBSelChanged = "['onHelpLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_OnlineHelpMenu.sqf'";
		};

		class CTI_Menu_Help_ControlsGroup : RscControlsGroup {
			x = "SafeZoneX + (SafeZoneW * 0.34)";
			y = "SafeZoneY + (SafezoneH * 0.175)";
			w = "SafeZoneW * 0.54";
			h = "SafeZoneH * 0.71";

			class controls {
				class CTI_Menu_Help_Explanation : RscStructuredText {
					idc = 160002;

					x = "0";
					y = "0";
					w = "SafeZoneW * 0.53";
					h = "SafeZoneH * 2.71";

					size = "0.85 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
					// text = "Your Resources: $8000";
				};
			};
		};
	};
};

class CTI_RscPurchaseMenu {
	movingEnable = 0;
	idd = 110000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_purchasemenu', _this select 0];['onLoad'] execVM 'Client\Events\Events_UI_PurchaseMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_purchasemenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";

	class controlsBackground {
		class CTI_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.21)";
			y = "SafeZoneY + (SafezoneH * 0.175)";
			w = "SafeZoneW * 0.615";
			h = "SafeZoneH * 0.705";
			colorBackground[] = {0, 0, 0, 0.7};
			moving = 1;
		};
		class CTI_Background_Header : CTI_Background {
			x = "SafeZoneX + (SafeZoneW * 0.21)";
			y = "SafeZoneY + (SafezoneH * 0.175)";
			w = "SafeZoneW * 0.615";
			h = "SafeZoneH * 0.05"; //0.06 stock
			colorBackground[] = {0, 0, 0, 0.4};
		};
		class CTI_Menu_Title : RscText {
			style = ST_LEFT;
			x = "SafeZoneX + (SafeZoneW * 0.23)";
			y = "SafeZoneY + (SafezoneH * 0.180)";
			w = "SafeZoneW * 0.595";
			h = "SafeZoneH * 0.037";

			text = "Заводской режим";
			colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CTI_Menu_UnitsListFrame : RscFrame {
			x = "SafeZoneX + (SafeZoneW * 0.225)";
			y = "SafeZoneY + (SafezoneH * 0.419)";
			w = "SafeZoneW * 0.275";
			h = "SafeZoneH * 0.391";
		};
		class CTI_Menu_Info : CTI_Menu_UnitsListFrame {
			y = "SafeZoneY + (SafezoneH * 0.245)";
			h = "SafeZoneH * 0.064";
		};
		class CTI_Menu_Info_Background : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.225)";
			y = "SafeZoneY + (SafezoneH * 0.245)";
			w = "SafeZoneW * 0.275";
			h = "SafeZoneH * 0.064";
			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};
		class CTI_Menu_ResourcesInfo_Background : CTI_Menu_Info_Background {
			y = "SafeZoneY + (SafezoneH * 0.373)";
			h = "SafeZoneH * 0.030";
		};

		class CTI_Menu_SubInfo : CTI_Menu_Info {
			y = "SafeZoneY + (SafezoneH * 0.325)";
			h = "SafeZoneH * 0.078";
		};

		class CTI_Menu_ComboFrame : CTI_Menu_Info {
			x = "SafeZoneX + (SafeZoneW * 0.535)";
			h = "SafeZoneH * 0.1";
		};

		class CTI_Menu_TeamComboLabel : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.54)";
			y = "SafeZoneY + (SafezoneH * 0.257)";
			w = "SafeZoneW * 0.1";
			h = "SafeZoneH * 0.035";

			text = "Команда :";
			// colorText[] = {0.258823529, 0.713725490, 1, 1};

			sizeEx = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CTI_Menu_FactoryComboLabel : CTI_Menu_TeamComboLabel {
			y = "SafeZoneY + (SafezoneH * 0.3)";

			text = "Фабрика :";
		};

		class CTI_Menu_MapFrame : CTI_Menu_ComboFrame {
			y = "SafeZoneY + (SafezoneH * 0.361)";
			h = "SafeZoneH * 0.235";
		};
		class CTI_Menu_Info_MapIntel : RscText {
			x = "SafeZoneX + (SafeZoneW * 0.535)";
			y = "SafeZoneY + (SafezoneH * 0.361)";
			w = "SafeZoneW * 0.275";
			h = "SafeZoneH * 0.2";

			colorBackground[] = {0.5, 0.5, 0.5, 0.25};
		};

		class CTI_Menu_QueueFrame : CTI_Menu_MapFrame {
			y = "SafeZoneY + (SafezoneH * 0.612)";
			h = "SafeZoneH * 0.143";
		};
	};

	class controls {
		class CTI_Menu_Map : RscMapControl {
			idc = 110010;

			x = "SafeZoneX + (SafeZoneW * 0.535)";
			y = "SafeZoneY + (SafezoneH * 0.391)";
			w = "SafeZoneW * 0.275";
			h = "SafeZoneH * 0.205";

			showCountourInterval = 1;
		};
		class CTI_Menu_Map_Info : RscStructuredText {
			idc = 110901;

			x = "SafeZoneX + (SafeZoneW * 0.535)";
			y = "SafeZoneY + (SafezoneH * 0.361)";
			w = "SafeZoneW * 0.1375";
			h = "SafeZoneH * 0.03";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

			class Attributes {
				font = "RobotoCondensed";
				color = "#ffffff";
				align = "left";
				shadow = 1;
			};
		};
		class CTI_Menu_Group_Info : CTI_Menu_Map_Info {
			idc = 110902;

			x = "SafeZoneX + (SafeZoneW * 0.6725)";
		};
		class CTI_Icon_Barracks : RscActiveText {
			idc = 110001;
			style = ST_KEEP_ASPECT_RATIO;
			x = "SafeZoneX + (SafeZoneW * 0.225)";
			y = "SafeZoneY + (SafezoneH * 0.245)";
			w = "SafeZoneW * 0.035";
			h = "SafeZoneH * 0.064";

			color[] = {0.75,0.75,0.75,0.7};
			colorActive[] = {1,1,1,0.7};
			colorDisabled[] = {1,1,1,0.7};
			colorBackground[] = {0.6, 0.8392, 0.4706, 0.7};
			colorBackgroundSelected[] = {0.6, 0.8392, 0.4706, 0.7};
			colorFocused[] = {0.0, 0.0, 0.0, 0};

			text = "Rsc\Pictures\icon_wf_building_barracks.paa";
			action = "['onIconSet', 0, CTI_BARRACKS] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Light : CTI_Icon_Barracks {
			idc = 110002;
			x = "SafeZoneX + (SafeZoneW * 0.26)";

			text = "Rsc\Pictures\icon_wf_building_lvs.paa";
			action = "['onIconSet', 1, CTI_LIGHT] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Heavy : CTI_Icon_Barracks {
			idc = 110003;
			x = "SafeZoneX + (SafeZoneW * 0.295)";

			text = "Rsc\Pictures\icon_wf_building_hvs.paa";
			action = "['onIconSet', 2, CTI_HEAVY] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Air : CTI_Icon_Barracks {
			idc = 110004;
			x = "SafeZoneX + (SafeZoneW * 0.33)";

			text = "Rsc\Pictures\icon_wf_building_air.paa";
			action = "['onIconSet', 3, CTI_AIR] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Repair : CTI_Icon_Barracks {
			idc = 110005;
			x = "SafeZoneX + (SafeZoneW * 0.365)";

			text = "Rsc\Pictures\icon_wf_building_repair.paa";
			action = "['onIconSet', 4, CTI_REPAIR] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Ammo : CTI_Icon_Barracks {
			idc = 110006;
			x = "SafeZoneX + (SafeZoneW * 0.4)";

			text = "Rsc\Pictures\icon_wf_building_ammo.paa";
			action = "['onIconSet', 5, CTI_AMMO] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Naval : CTI_Icon_Barracks {
			idc = 110007;
			x = "SafeZoneX + (SafeZoneW * 0.435)";

			text = "Rsc\Pictures\icon_wf_building_naval.paa";
			action = "['onIconSet', 6, CTI_NAVAL] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};

		class CTI_Icon_Driver : CTI_Icon_Barracks {
			idc = 110100;
			x = "SafeZoneX + (SafeZoneW * 0.34)";
			y = "SafeZoneY + (SafezoneH * 0.325)";
			w = "SafeZoneW * 0.03";
			h = "SafeZoneH * 0.048";

			color[] = {0.258823529, 0.713725490, 1, 1};
			colorActive[] = {1,1,1,0.7};
			colorBackground[] = {0.6, 0.8392, 0.4706, 0.7};
			colorBackgroundSelected[] = {0.6, 0.8392, 0.4706, 0.7};
			colorFocused[] = {0.0, 0.0, 0.0, 0};

			text = "Rsc\Pictures\i_driver.paa";
			action = "['onVehicleIconClicked', 'driver', 110100] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Gunner : CTI_Icon_Driver {
			idc = 110101;
			x = "SafeZoneX + (SafeZoneW * 0.37)";

			text = "Rsc\Pictures\i_gunner.paa";
			action = "['onVehicleIconClicked', 'gunner', 110101] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Commander : CTI_Icon_Driver {
			idc = 110102;
			x = "SafeZoneX + (SafeZoneW * 0.4)";

			text = "Rsc\Pictures\i_commander.paa";
			action = "['onVehicleIconClicked', 'commander', 110102] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Turrets : CTI_Icon_Driver {
			idc = 110103;
			x = "SafeZoneX + (SafeZoneW * 0.43)";

			text = "Rsc\Pictures\i_turrets.paa";
			action = "['onVehicleIconClicked', 'turrets', 110103] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Icon_Lock : CTI_Icon_Driver {
			idc = 110104;
			x = "SafeZoneX + (SafeZoneW * 0.47)";

			color[] = {1, 0.22745098, 0.22745098, 1};

			text = "Rsc\Pictures\i_lock.paa";
			action = "['onVehicleLockClicked'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};


		class CTI_Menu_Control_UnitsList : RscListNBox {
			idc = 111007;

			x = "SafeZoneX + (SafeZoneW * 0.225)";
			y = "SafeZoneY + (SafezoneH * 0.419)";
			w = "SafeZoneW * 0.275";
			h = "SafeZoneH * 0.391";

			// rowHeight = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			rowHeight = "1.35 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			itemBackground[] = {1,1,1,0.1};
			// columns[] = {0.001, 0.26};
			columns[] = {0.001, 0.35};

			onLBSelChanged = "['onUnitsLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
			onLBDblClick = "['onPurchase', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};

		class CTI_Menu_ComboTeam : RscCombo {
			idc = 110008;

			x = "SafeZoneX + (SafeZoneW * 0.6075)";
			y = "SafeZoneY + (SafezoneH * 0.257)";
			w = "SafeZoneW * 0.195";
			h = "SafeZoneH * 0.035";

			sizeEx = "0.8 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			onLBSelChanged = "['onGroupLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Menu_ComboFactory : CTI_Menu_ComboTeam {
			idc = 110009;

			y = "SafeZoneY + (SafezoneH * 0.3)";
			onLBSelChanged = "['onFactoryLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};

		class CTI_Menu_Control_Purchase : RscButton {
			idc = 100011;

			// x = "SafeZoneX + (SafeZoneW * 0.535)";
			x = "SafeZoneX + (SafeZoneW * 0.225)";
			y = "SafeZoneY + (SafeZoneH * 0.825)";
			w = "SafeZoneW * 0.275";
			h = "SafeZoneH * 0.04";

			text = "Купить";
			action = "['onPurchase', lnbCurSelRow 111007] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Menu_Control_CancelQueu : CTI_Menu_Control_Purchase {
			idc = 100012;

			x = "SafeZoneX + (SafeZoneW * 0.535)";
			y = "SafeZoneY + (SafeZoneH * 0.77)";

			text = "Отменить очередь";
			action = "['onQueueCancel', lbCurSel 110013] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Menu_Control_IndependentSalvager : CTI_Menu_Control_CancelQueu {
			idc = 100016;

			y = "SafeZoneY + (SafeZoneH * 3.825)";

			text = "Сдать технику для утилизацию";
			action = "['onIndependentSalvagerPressed'] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Menu_Control_QueueList : RscListBox {
			idc = 110013;

			x = "SafeZoneX + (SafeZoneW * 0.535)";
			y = "SafeZoneY + (SafezoneH * 0.612)";
			h = "SafeZoneH * 0.143";
			w = "SafeZoneW * 0.275";

			rowHeight = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "0.78 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};

			// onLBSelChanged = "['onUnitsLBSelChanged', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
			onLBDblClick = "['onQueueCancel', _this select 1] call compile preprocessFileLineNumbers 'Client\Events\Events_UI_PurchaseMenu.sqf'";
		};
		class CTI_Menu_Control_Cost : RscStructuredText {
			idc = 110014;
			x = "SafeZoneX + (SafeZoneW * 0.225)";
			y = "SafeZoneY + (SafezoneH * 0.373)";
			w = "SafeZoneW * 0.1375";
			h = "SafeZoneH * 0.03";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Menu_Control_Resources : CTI_Menu_Control_Cost {
			idc = 110015;
			x = "SafeZoneX + (SafeZoneW * 0.3625)";

			size = "0.9 * (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CTI_Control_Exit : RscButton {
			idc = 22555;

			x = "SafeZoneX + (SafeZoneW * 0.77)";
			y = "SafeZoneY + (SafezoneH * 0.18)";
			w = "SafeZoneW * 0.04";
			h = "SafeZoneH * 0.04";

			text = "X";
			action = "closeDialog 0";
		};
	};
};