/*
    vehicleShop_dialog.hpp
    Описание интерфейса магазина техники
*/

class VehicleShopDialog {
    idd = 5000; // Уникальный ID диалога
    movingEnable = 0; // Запрет перемещения окна
    enableSimulation = 1; // Включение симуляции
    
    class ControlsBackground {
        // Фон окна
        class Background: RscText {
            idc = -1;
            x = 0.2 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.6 * safezoneW;
            h = 0.6 * safezoneH;
            colorBackground[] = {0, 0, 0, 0.8}; // Полупрозрачный черный
        };
        
        // Фон заголовка
        class TitleBackground: RscText {
            idc = -1;
            x = 0.2 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.6 * safezoneW;
            h = 0.06 * safezoneH;
            colorBackground[] = {0.13, 0.54, 0.21, 0.8}; // Цвет фона заголовка
        };
        
        // Текст заголовка
        class Title: RscText {
            idc = -1;
            text = "МАГАЗИН ТЕХНИКИ"; // Название магазина
            x = 0.2 * safezoneW + safezoneX;
            y = 0.2 * safezoneH + safezoneY;
            w = 0.6 * safezoneW;
            h = 0.06 * safezoneH;
            font = "RobotoCondensed";
            sizeEx = "6 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            colorText[] = {1, 1, 1, 1}; // Белый текст
            colorBackground[] = {0, 0, 0, 0}; // Прозрачный фон
        };
    };
    
    class Controls {
        // Список техники (левая панель)
        class VehicleList: RscListBox {
            idc = 5001; // ID для доступа
            x = 0.21 * safezoneW + safezoneX;
            y = 0.28 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.45 * safezoneH;
            font = "RobotoCondensed";
            sizeEx = "4.8 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            rowHeight = "0.045 * safezoneH"; // Высота строки
            onLBSelChanged = "_this call vehicleShop_updateDetails"; // Обработчик выбора
        };
        
        // Текст с количеством очков
        class PointsText: RscText {
            idc = 5003;
            text = "ВАШ СЧЁТ:";
            x = 0.51 * safezoneW + safezoneX;
            y = 0.27 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.04 * safezoneH;
            font = "RobotoCondensedBold";
            sizeEx = "5.0 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            colorText[] = {1, 1, 1, 1}; // Белый текст
        };
        
        // Фон описания техники
        class DetailsBackground: RscText {
            idc = -1;
            x = 0.51 * safezoneW + safezoneX;
            y = 0.32 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.41 * safezoneH;
            colorBackground[] = {0.1, 0.1, 0.1, 0.8}; // Темный фон
        };
        
        // Текст описания техники
        class DetailsText: RscStructuredText {
            idc = 5004;
            x = 0.515 * safezoneW + safezoneX;
            y = 0.33 * safezoneH + safezoneY;
            w = 0.27 * safezoneW;
            h = 0.39 * safezoneH;
            font = "RobotoCondensed";
            size = "2.6 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            colorBackground[] = {0, 0, 0, 0}; // Прозрачный фон
        };
        
        // Кнопка покупки
        class PurchaseButton: RscShortcutButton {
            idc = 5002;
            text = "КУПИТЬ";
            x = 0.21 * safezoneW + safezoneX; // Такая же X-координата как у списка техники
            y = 0.75 * safezoneH + safezoneY; // Нижняя часть левого блока
            w = 0.28 * safezoneW; // Такая же ширина как у списка техники
            h = 0.05 * safezoneH;
            font = "RobotoCondensedBold";
            sizeEx = "3 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            action = "call vehicleShop_purchase"; // Обработчик нажатия
            colorBackground[] = {0, 0.6, 0, 1}; // Зеленый цвет
            colorBackgroundActive[] = {0, 0.8, 0, 1}; // Зеленый (активный)
            style = 2; // Центрирование текста
        };
        
        // Кнопка закрытия
        class CloseButton: RscShortcutButton {
            idc = -1;
            text = "ЗАКРЫТЬ";
            x = 0.51 * safezoneW + safezoneX;
            y = 0.75 * safezoneH + safezoneY;
            w = 0.28 * safezoneW;
            h = 0.05 * safezoneH;
            font = "RobotoCondensedBold";
            sizeEx = "3 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
            action = "closeDialog 0"; // Закрытие диалога
            colorBackground[] = {0.6, 0, 0, 1}; // Красный цвет
            colorBackgroundActive[] = {0.8, 0, 0, 1}; // Красный (активный)
            style = 2; // Центрирование текста
        };
    };
};