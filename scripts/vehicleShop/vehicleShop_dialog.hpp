class VehicleShopDialog {
    idd = 5000;
    movingEnable = true;
    enableSimulation = true;
    onLoad = "uiNamespace setVariable ['VehicleShopDialog', _this select 0]";
    
    class ControlsBackground {
        class Background: RscText {
            x = 0.3; y = 0.2;
            w = 0.4; h = 0.65;
            colorBackground[] = {0,0,0,0.8};
        };
        
        class Title: RscText {
            text = "МАГАЗИН ТЕХНИКИ";
            x = 0.3; y = 0.2;
            w = 0.4; h = 0.05;
            colorBackground[] = {0,0.3,0.6,1};
            colorText[] = {1,1,1,1};
            sizeEx = 0.04;
        };
    };
    
    class Controls {
        class VehicleList: RscListBox {
            idc = 5001;
            x = 0.31; y = 0.26;
            w = 0.38; h = 0.35;
            sizeEx = 0.035;
            colorBackground[] = {0,0,0,0.3};
            onLBSelChanged = "['onLBSelChanged', _this] call vehicleShop_uiHandler";
        };
        
        class PointsText: RscText {
            idc = 5003;
            text = "";
            x = 0.31; y = 0.22;
            w = 0.38; h = 0.04;
            colorText[] = {1,1,0,1};
            sizeEx = 0.04;
        };
        
        class DetailsText: RscStructuredText {
            idc = 5004;
            x = 0.31; y = 0.62;
            w = 0.38; h = 0.15;
            size = 0.03;
            colorBackground[] = {0,0,0,0.3};
        };
        
        class PurchaseButton: RscButton {
            idc = 5002;
            text = "КУПИТЬ";
            x = 0.35; y = 0.78;
            w = 0.3; h = 0.05;
            colorBackground[] = {0,0.5,0,1};
            action = "['onPurchaseClick'] call vehicleShop_uiHandler";
        };
        
        class CloseButton: RscButton {
            text = "ЗАКРЫТЬ";
            x = 0.35; y = 0.84;
            w = 0.3; h = 0.05;
            colorBackground[] = {0.5,0,0,1};
            action = "closeDialog 0";
        };
    };
};