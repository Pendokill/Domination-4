class VehicleShopDialog {
    idd = 5000;
    movingEnable = false;
    
    class ControlsBackground {
        class Background: RscText {
            x = 0.3; y = 0.2;
            w = 0.4; h = 0.6;
            colorBackground[] = {0,0,0,0.7};
        };
        
        class Title: RscText {
            text = "Магазин техники";
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
            text = "Купить";
            x = 0.4; y = 0.7;
            w = 0.2; h = 0.05;
            action = "[] spawn vehicleShop_purchase";
        };
        
        class CloseButton: RscButton {
            text = "Закрыть";
            x = 0.4; y = 0.76;
            w = 0.2; h = 0.05;
            action = "closeDialog 0";
        };
        
        class PointsText: RscText {
            idc = 5003;  // Изменили с 5004 на 5003
            text = "";   // Оставляем пустым, будет заполнено динамически
            x = 0.32; y = 0.25;
            w = 0.36; h = 0.03;
        };
        
        class DetailsText: RscStructuredText {
            idc = 5004;  // Теперь 5004 для деталей
            x = 0.32; y = 0.69;
            w = 0.36; h = 0.2;
        };
    };
};