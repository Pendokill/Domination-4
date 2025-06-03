#include "Styles.hpp"

class CTI_RscOnlineHelpMenu {
	movingEnable = 0;
	idd = 160000;
	onLoad = "uiNamespace setVariable ['cti_dialog_ui_onlinehelpmenu', _this select 0];['onLoad'] execVM 'client\Events\Events_UI_OnlineHelpMenu.sqf'";
	onUnload = "uiNamespace setVariable ['cti_dialog_ui_onlinehelpmenu', nil]; ['onUnload'] call compile preprocessFileLineNumbers 'client\Events\Events_UI_OnlineHelpMenu.sqf'";

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