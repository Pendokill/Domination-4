class VehicleShopDialog {
    idd = 5000;
    movingEnable = false;
    
    class ControlsBackground {
        class Background: RscText {
            idc = -1;
            x = 0.3; y = 0.2;
            w = 0.4; h = 0.6;
            colorBackground[] = {0,0,0,0.7};
        };
        
        class Title: RscText {
            idc = -1;
            text = "МАГАЗИН ТЕХНИКИ";
            x = 0.3; y = 0.2;
            w = 0.4; h = 0.05;
            colorBackground[] = {0,0.3,0.6,0.8};
        };
    };
    
    class Controls {
        class VehicleList: RscListbox {
            idc = 5001;
            x = 0.32; y = 0.28;
            w = 0.36; h = 0.4;
            onLBSelChanged = "_this call vehicleShop_updateDetails";
        };
        
        class PurchaseButton: RscButton {
            idc = 5002;
            text = "КУПИТЬ";
            x = 0.35; y = 0.7;
            w = 0.3; h = 0.05;
            action = "[] call vehicleShop_purchase";
        };
        
        class PointsText: RscText {
            idc = 5004;
            text = "Очков: 0";
            x = 0.32; y = 0.25;
            w = 0.36; h = 0.03;
        };
    };
};