class VehicleShopDialog {
    idd = 5000;
    movingEnable = 0;
    enableSimulation = 1;
    onLoad = "uiNamespace setVariable ['VehicleShopDialog', _this select 0]";
    
    class ControlsBackground {
        class Background: RscText {
            idc = -1;
            x = 0.2 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.6 * safezoneW;
            h = 0.6 * safezoneH;
            colorBackground[] = {0, 0, 0, 0.9};
        };
        
        class TitleBackground: RscText {
            idc = -1;
            text = "";
            x = 0.2 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.6 * safezoneW;
            h = 0.06 * safezoneH;
            colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
        };
        
        class Title: RscText {
            idc = -1;
            text = "МАГАЗИН ТЕХНИКИ";
            x = 0.2 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.6 * safezoneW;
            h = 0.06 * safezoneH;
            font = "RobotoCondensedBold";
            sizeEx = "6 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            colorText[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0};
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
        text = "ОЧКИ:";
        x = 0.51 * safezoneW + safezoneX;
        y = 0.27 * safezoneH + safezoneY;
        w = 0.28 * safezoneW;
        h = 0.04 * safezoneH;
        font = "RobotoCondensedBold";
        sizeEx = "5.0 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
        colorText[] = {1, 1, 1, 1};
    };
    
    class DetailsBackground: RscText {
        idc = -1;
        x = 0.51 * safezoneW + safezoneX;
        y = 0.32 * safezoneH + safezoneY;
        w = 0.28 * safezoneW;
        h = 0.41 * safezoneH;
        colorBackground[] = {0.1, 0.1, 0.1, 0.8};
    };
    
    class DetailsText: RscStructuredText {
        idc = 5004;
        x = 0.515 * safezoneW + safezoneX;
        y = 0.33 * safezoneH + safezoneY;
        w = 0.27 * safezoneW;
        h = 0.39 * safezoneH;
        font = "RobotoCondensed";
        size = "2.5 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
        colorBackground[] = {0, 0, 0, 0};
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
        colorBackground[] = {0, 0.6, 0, 1};
        colorBackgroundActive[] = {0, 0.8, 0, 1};
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
        colorBackground[] = {0.6, 0, 0, 1};
        colorBackgroundActive[] = {0.4, 0.4, 0.4, 1}; // Серый при наведении
        style = 2;
    };
  };
};