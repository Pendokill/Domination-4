//Land_i_house_Big_01_V1_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_bed=createSimpleObject["a3\Props_F_Orange\Furniture\WoodenBed_01_F.p3d",[0,0,0]];
_chair=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_chair3=createSimpleObject["a3\structures_f\furniture\ChairWood_F.p3d",[0,0,0]];
_desk=createSimpleObject["a3\structures_f\furniture\TableDesk_F.p3d",[0,0,0]];
_desk2=createSimpleObject["a3\structures_f\furniture\TableDesk_F.p3d",[0,0,0]];
_desk3=createSimpleObject["a3\structures_f\furniture\TableDesk_F.p3d",[0,0,0]];
_desk4=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeTable_01_F.p3d",[0,0,0]];
_dTable=createSimpleObject["a3\Props_F_Orange\Furniture\TableBig_01_F.p3d",[0,0,0]];
_fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
_luggage=createSimpleObject["A3\Structures_F_EPB\Items\Luggage\LuggageHeap_01_F.p3d",[0,0,0]];
_mCase=createSimpleObject["A3\Structures_F_Heli\Items\Luggage\PlasticCase_01_small_F.p3d",[0,0,0]];
_microW=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Microwave_01_F.p3d",[0,0,0]];
_pcCase=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\PCSet_01_case_F.p3d",[0,0,0]];
_pcChair=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeChair_01_F.p3d",[0,0,0]];
_pcMon=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\PCSet_01_screen_F.p3d",[0,0,0]];
_plant=createSimpleObject["a3\Props_F_Orange\Items\Decorative\FlowerPot_01_flower_F.p3d",[0,0,0]];
_printer=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Printer_01_F.p3d",[0,0,0]];
_rack=createSimpleObject["a3\structures_f\furniture\Rack_F.p3d",[0,0,0]];
_radio=createSimpleObject["a3\structures_f\Items\Electronics\FMradio_F.p3d",[0,0,0]];
_rug=createSimpleObject[(selectRandom["Land_Rug_01_F","Land_Rug_01_Traditional_F"]),[0,0,0]];
_shelf=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeCabinet_01_F.p3d",[0,0,0]];
_shelfW=createSimpleObject["A3\Structures_F_EPB\Furniture\ShelvesWooden_F.p3d",[0,0,0]];
_sink=createSimpleObject["A3\Structures_F\Civ\Accessories\Sink_F.p3d",[0,0,0]];
_sofa=createSimpleObject["a3\Props_F_Orange\Furniture\Sofa_01_F.p3d",[0,0,0]];
_sofa2=createSimpleObject["a3\Props_F_Orange\Furniture\Armchair_01_F.p3d",[0,0,0]];
_sTable=createSimpleObject["A3\Structures_F_Heli\Furniture\RattanTable_01_F.p3d",[0,0,0]];
_stool=createSimpleObject["a3\structures_f\furniture\Bench_F.p3d",[0,0,0]];
_trash=createSimpleObject["A3\Structures_F_Heli\Civ\Garbage\WheelieBin_01_F.p3d",[0,0,0]];
_tv=createSimpleObject["Land_FlatTV_01_F",[0,0,0]];
{_f pushBack _x}forEach[_bed,_chair,_chair2,_chair3,_desk,_desk2,_desk3,_desk4,_dTable,_fridge,_luggage,_mCase,_microW,_pcCase,_pcChair,_pcMon,_plant,_printer,_rack,_radio,_rug,_shelf,_shelfW,_sink,_sofa,_sofa2,_sTable,_stool,_tv,_trash];
_b setVariable["PF",_f];

_bed setPos(_b modelToWorld[3.5,-5.3,1.72]);
_chair setPos(_b modelToWorld[2.27,3.7,-2.62]);
_chair2 setPos(_b modelToWorld[-0.3,3.5,-2.62]);_chair2 setDir(_dir+250); 
_chair3 setPos(_b modelToWorld[1,4.4,-2.62]);_chair3 setDir(_dir+14); 
_desk setPos(_b modelToWorld[0.66,7,-1.91]);
_desk2 setPos(_b modelToWorld[-3.5,7,-1.91]);
_desk3 setPos(_b modelToWorld[-1.1,7,-1.91]);
_desk4 setPos(_b modelToWorld[4.3,-2.25,1.65]);
_dTable setPos(_b modelToWorld[1,3.7,-1.73]);
_fridge setPos(_b modelToWorld[-2.3,6.9,-1.6]);
_luggage setPos(_b modelToWorld[4.29,-3.73,1.825]);_luggage setDir(_dir+180); 
_mCase setPos(_b modelToWorld[2.24,-5.3,1.12]);
_microW setPos(_b modelToWorld[-1,6.85,-1.73]);
_pcCase setPos(_b modelToWorld[4.3,-1.45,1.31]);
_pcChair setPos(_b modelToWorld[3.7,-2,2.15]);_pcChair setDir(_dir+285); 
_pcMon setPos(_b modelToWorld[4.3,-2,2.14]);
_plant setPos(_b modelToWorld[2.8,0.4,-1.01]);
_printer setPos(_b modelToWorld[4.4,-2.67,2]);
_rack setPos(_b modelToWorld[-4.12,1.92,-1]);
_radio setPos(_b modelToWorld[-0.5,6.75,1.76]);_radio setDir(_dir+150); 
_rug setPos(_b modelToWorld[-0.5,-6.2,-2.595]);
_sink setPos(_b modelToWorld[-3.9,5.5,-1.4]);
_shelf setPos(_b modelToWorld[1.5,7.06,2.36]);
_shelfW setPos(_b modelToWorld[4.18,-6.845,-1.6]);
_sofa setPos(_b modelToWorld[1.4,-2,-1.614]);
_sofa2 setPos(_b modelToWorld[0.45,6.75,1.77]);_sofa2 setDir(_dir+180); 
_sTable setPos(_b modelToWorld[-0.7,6.75,1.62]);
_stool setPos(_b modelToWorld[1.45,0.85,-2.13]);
_trash setPos(_b modelToWorld[-3,0,-1.67]);_trash setDir(_dir+30);
_tv setPos(_b modelToWorld[1.45,0.9,-1.5]);
{_x setDir _dir}forEach[_desk,_desk2,_desk3,_dTable,_fridge,_mCase,_microW,_plant,_rack,_shelf,_sofa,_sTable,_tv];
{_x setDir(_dir+90)}forEach[_bed,_chair,_desk4,_pcCase,_pcMon,_printer,_rug,_sink,_shelfW,_stool];
if((dayTime<18)&&{(dayTime>5)})then{_tv setObjectTextureGlobal[0,(selectRandom["\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_pills_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_supermarket_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_maskrtnik_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_bluking_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_wine_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_plane_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_action_co.paa","\A3\Structures_F_Argo\Commercial\Billboards\Data\Advertisements\bill_getlost_co.paa"])]}}