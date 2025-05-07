class VehicleShopDialog {
    idd = 5000;
    movingEnable = 0;
    enableSimulation = 1;
    
    class ControlsBackground {
        class Background: RscText {
            idc = -1;
            x = 0.2 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.6 * safezoneW;
            h = 0.6 * safezoneH;
            colorBackground[] = {0,0,0,0.8};
        };
        
        class TitleBackground: RscText {
            idc = -1;
            x = 0.2 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.6 * safezoneW;
            h = 0.06 * safezoneH;
            colorBackground[] = {0.13,0.54,0.21,0.8};
        };
        
        class Title: RscText {
            idc = -1;
            text = "МАГАЗИН ТЕХНИКИ";
            x = 0.2 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.6 * safezoneW;
            h = 0.06 * safezoneH;
            font = "RobotoCondensed";
            sizeEx = "6 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            colorText[] = {1,1,1,1};
        };
    };
    
    class Controls {
        class VehicleList: RscListBox {
            idc = 5001;
            x = 0.21 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.45 * safezoneH;
            font = "RobotoCondensed";
            sizeEx = "4.8 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            rowHeight = "0.045 * safezoneH";
            onLBSelChanged = "_this call vehicleShop_updateDetails";
        };
        
        class PointsText: RscText {
            idc = 5003;
            text = "ВАШ СЧЁТ:";
            x = 0.51 * safezoneW + safezoneX;
            y = 0.27 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.04 * safezoneH;
            font = "RobotoCondensedBold";
            sizeEx = "5.0 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            colorText[] = {1,1,1,1};
        };
        
        class DetailsBackground: RscText {
            idc = -1;
            x = 0.51 * safezoneW + safezoneX;
            y = 0.32 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.41 * safezoneH;
            colorBackground[] = {0.1,0.1,0.1,0.8};
        };
        
        class DetailsText: RscStructuredText {
            idc = 5004;
            x = 0.515 * safezoneW + safezoneX;
            y = 0.33 * safezoneH + safezoneY;
            w = 0.27 * safezoneW;
            h = 0.39 * safezoneH;
            font = "RobotoCondensed";
            size = "2.6 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            colorBackground[] = {0,0,0,0};
            shadow = 0;
            class Attributes {
                font = "RobotoCondensed";
                color = "#FFFFFF";
                align = "left";
                shadow = 0;
            };
        };
        
        class PurchaseButton: RscShortcutButton {
            idc = 5002;
            text = "КУПИТЬ";
            x = 0.21 * safezoneW + safezoneX;
            y = 0.75 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.05 * safezoneH;
            font = "RobotoCondensedBold";
            sizeEx = "3 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            action = "call vehicleShop_purchase";
            colorBackground[] = {0,0.6,0,1};
            colorBackgroundActive[] = {0,0.8,0,1};
            style = 2;
        };
        
        class CloseButton: RscShortcutButton {
            idc = -1;
            text = "ЗАКРЫТЬ";
            x = 0.51 * safezoneW + safezoneX;
            y = 0.75 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.05 * safezoneH;
            font = "RobotoCondensedBold";
            sizeEx = "3 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            action = "closeDialog 0";
            colorBackground[] = {0.6,0,0,1};
            colorBackgroundActive[] = {0.8,0,0,1};
            style = 2;
        };
        
        class ModeButton: RscShortcutButton {
            idc = 5005;
            text = "ПЕРЕКЛЮЧИТЬ";
            x = 0.7 * safezoneW + safezoneX; // Правая часть экрана
            y = 0.27 * safezoneH + safezoneY; // Рядом с очками
            w = 0.1 * safezoneW; // Компактная ширина
            h = 0.04 * safezoneH;
            font = "RobotoCondensed";
            sizeEx = "3 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            action = "call vehicleShop_toggleMode";
            colorBackground[] = {0.2,0.2,0.8,1};
            tooltip = "Сменить режим загрузки (только админ)";
        };
    };
};