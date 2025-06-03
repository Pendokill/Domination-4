class BankDialog {
    idd = 6000;
    movingEnable = 1;
    enableSimulation = 1;
    
    class ControlsBackground {
        class Background: IGUIBack {
            idc = -1;
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.225 * safezoneH + safezoneY;
            w = 0.4125 * safezoneW;
            h = 0.55 * safezoneH;
            colorBackground[] = {0.1,0.1,0.1,0.9};
        };
        
        class Title: RscText {
            idc = -1;
            text = "БАНКОВСКАЯ СИСТЕМА";
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.192 * safezoneH + safezoneY;
            w = 0.4125 * safezoneW;
            h = 0.033 * safezoneH;
            colorBackground[] = {0.13,0.54,0.21,0.9};
            colorText[] = {1,1,1,1};
            font = "RobotoCondensedBold";
            sizeEx = "5 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
        };
    };
    
    class Controls {
        // Левая колонка - сумма кредита
        class LoanAmountTitle: RscText {
            idc = -1;
            text = "Сумма кредита:";
            x = 0.304062 * safezoneW + safezoneX;
            y = 0.247 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.022 * safezoneH;
            colorText[] = {1,1,1,1};
        };
        
        class Button500: RscButton {
            idc = 5001;
            text = "500 очков";
			variable = "bank_amount = 500"; // Добавьте эту строку
            x = 0.304062 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.033 * safezoneH;
            action = "bank_selectedAmount = 500;";
        };
        
        class Button1000: RscButton {
            idc = 5002;
            text = "1000 очков";
			variable = "bank_amount = 1000"; // Добавьте эту строку
            x = 0.304062 * safezoneW + safezoneX;
            y = 0.324 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.033 * safezoneH;
            action = "bank_selectedAmount = 1000;";
        };
        
        class Button3000: RscButton {
            idc = 5003;
            text = "3000 очков";
			variable = "bank_amount = 3000"; // Добавьте эту строку
            x = 0.304062 * safezoneW + safezoneX;
            y = 0.368 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.033 * safezoneH;
            action = "bank_selectedAmount = 3000;";
        };
        
        class Button5000: RscButton {
            idc = 5004;
            text = "5000 очков";
			variable = "bank_amount = 5000"; // Добавьте эту строку
            x = 0.304062 * safezoneW + safezoneX;
            y = 0.412 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.033 * safezoneH;
            action = "bank_selectedAmount = 5000;";
        };
        
        // Левая колонка - срок кредита
        class LoanTimeTitle: RscText {
            idc = -1;
            text = "Срок кредита:";
            x = 0.304062 * safezoneW + safezoneX;
            y = 0.467 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.022 * safezoneH;
            colorText[] = {1,1,1,1};
        };
        
        class Button3h: RscButton {
            idc = 5005;
            text = "3 часа";
            x = 0.304062 * safezoneW + safezoneX;
            y = 0.5 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.033 * safezoneH;
            action = "bank_selectedTime = 3;";
        };
        
        class Button6h: RscButton {
            idc = 5006;
            text = "6 часов";
            x = 0.304062 * safezoneW + safezoneX;
            y = 0.544 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.033 * safezoneH;
            action = "bank_selectedTime = 6;";
        };
        
        class Button12h: RscButton {
            idc = 5007;
            text = "12 часов";
            x = 0.304062 * safezoneW + safezoneX;
            y = 0.588 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.033 * safezoneH;
            action = "bank_selectedTime = 12;";
        };
        
        class Button24h: RscButton {
            idc = 5008;
            text = "24 часа";
            x = 0.304062 * safezoneW + safezoneX;
            y = 0.632 * safezoneH + safezoneY;
            w = 0.185625 * safezoneW;
            h = 0.033 * safezoneH;
            action = "bank_selectedTime = 24;";
        };
        
        // Правая колонка - правила кредита
        class RulesTitle: RscText {
            idc = -1;
            text = "Правила кредита:";
            x = 0.5 * safezoneW + safezoneX;
            y = 0.247 * safezoneH + safezoneY;
            w = 0.195937 * safezoneW;
            h = 0.022 * safezoneH;
            colorText[] = {1,1,1,1};
        };
        
        class RulesText: RscStructuredText {
            idc = 5009;
            text = "<t size='0.85'>1. Кредит выдается под проценты:<br/>- 3 часа: +5%<br/>- 6 часов: +10%<br/>- 12 часов: +15%<br/>- 24 часа: +25%<br/><br/>2. При просрочке:<br/>- 1 раз: тюрьма +50% к долгу<br/>- 2 раз: списание средств и бан 6ч<br/>- 3 раз: списание долга и бан 24ч<br/><br/>3. При отрицательном балансе:<br/>- Отказ или максимум на 6 часов<br/>- +15% к сумме</t>";
            x = 0.5 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.195937 * safezoneW;
            h = 0.33 * safezoneH;
            colorBackground[] = {0,0,0,0.3};
        };
        
        // Правая колонка - текущий баланс и долг
        class CurrentBalance: RscText {
            idc = 5010;
            text = "Текущий баланс: 0 очков";
            x = 0.5 * safezoneW + safezoneX;
            y = 0.61 * safezoneH + safezoneY;  // Было 0.62
            w = 0.195937 * safezoneW;
            h = 0.022 * safezoneH;
            colorText[] = {1,1,1,1};
        };
        
        class DebtInfo: RscStructuredText {
            idc = 5013;
            x = 0.5 * safezoneW + safezoneX;
            y = 0.635 * safezoneH + safezoneY;  // Было 0.645
            w = 0.195937 * safezoneW;
            h = 0.05 * safezoneH;
            colorBackground[] = {0,0,0,0.3};
            text = "<t align='center'>Нет текущих долгов</t>";
            class Attributes {
                font = "RobotoCondensed";
                color = "#FFFFFF";
                align = "center";
                shadow = 0;
            };
        };
        
        // Кнопки действий
        class TakeLoan: RscButton {
            idc = 5011;
            text = "ВЗЯТЬ КРЕДИТ";
            x = 0.5 * safezoneW + safezoneX;
            y = 0.690 * safezoneH + safezoneY;  // Было 0.705
            w = 0.0928125 * safezoneW;
            h = 0.033 * safezoneH;
            action = "[] call bank_fnc_takeLoan;";
            colorBackground[] = {0,0.5,0,1};
        };
        
        class PayLoan: RscButton {
            idc = 5012;
            text = "НЕТ ДОЛГОВ";
            x = 0.603125 * safezoneW + safezoneX;
            y = 0.690 * safezoneH + safezoneY;  // Было 0.705
            w = 0.0928125 * safezoneW;
            h = 0.033 * safezoneH;
            action = "[] call bank_fnc_payLoan;";
            colorBackground[] = {0.5,0.5,0.5,1};
        };
        
        class CloseButton: RscButton {
            idc = -1;
            text = "ЗАКРЫТЬ";
            x = 0.5 * safezoneW + safezoneX;
            y = 0.73 * safezoneH + safezoneY;  // Было 0.75
            w = 0.195937 * safezoneW;
            h = 0.033 * safezoneH;
            action = "closeDialog 0;";
            colorBackground[] = {0.5,0,0,1};
        };
    };
};