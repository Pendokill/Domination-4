//Land_i_house_Small_02_V1_F
isNil{params["_b"];
if(isNil{_b getVariable"PF_B"})then{_b setVariable["PF_B","h2b_1"]};_f=[];_dir=getDir _b;
_bed1=createSimpleObject["a3\structures_f\civ\Camping\CampingTable_F.p3d",[0,0,0]];
_bed2=createSimpleObject["a3\structures_f\civ\Camping\CampingTable_F.p3d",[0,0,0]];
_blanket=selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"];
_blanket1=createSimpleObject[_blanket,[0,0,0]];
_blanket2=createSimpleObject[_blanket,[0,0,0]];
_chair1=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_chair2=createSimpleObject["A3\Structures_F\Furniture\ChairPlastic_F.p3d",[0,0,0]];
_desk=createSimpleObject["a3\structures_f\furniture\TableDesk_F.p3d",[0,0,0]];
_flag1=createSimpleObject["Banner_01_F",[0,0,0]];
_fridge=createSimpleObject["Fridge_01_closed_F",[0,0,0]];
_microW=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Microwave_01_F.p3d",[0,0,0]];
_pillow=selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
_pillow1=createSimpleObject[_pillow,[0,0,0]];
_pillow2=createSimpleObject[_pillow,[0,0,0]];
_rack=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeCabinet_01_F.p3d",[0,0,0]];
_sack=createSimpleObject["A3\Structures_F\Civ\Market\Sack_F.p3d",[0,0,0]];
_radio=createSimpleObject["A3\Structures_F\Items\Electronics\FMradio_F.p3d",[0,0,0]];
_sink=createSimpleObject["A3\Structures_F\Civ\Accessories\Sink_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_EPC\Civ\Accessories\TablePlastic_01_F.p3d",[0,0,0]];
_trash=createSimpleObject["A3\Structures_F_Heli\Civ\Garbage\WheelieBin_01_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bed1,_bed2,_blanket1,_blanket2,_chair1,_chair2,_desk,_flag1,_fridge,_microW,_pillow1,_pillow2,_rack,_radio,_sack,_sink,_table,_trash];
_b setVariable["PF",_f];

_bed1 setPos(_b modelToWorld[6.55,2.4,-.28]);
_bed2 setPos(_b modelToWorld[7.15,-2.35,-.28]);_bed2 setDir(_dir+270);
_blanket1 setPos(_b modelToWorld[6.55,2.4,-.245]);
_blanket2 setPos(_b modelToWorld[7.15,-2.35,-.245]);
_chair1 setPos(_b modelToWorld[6.5,.35,.215]);_chair1 setDir _dir;
_chair2 setPos(_b modelToWorld[6.77,1.35,.215]);_chair2 setDir(_dir+50);
_desk setPos(_b modelToWorld[.4,-1.115,-.04]);
_flag1 setPos(_b modelToWorld[1.1,-1,1.2]);
_fridge setPos(_b modelToWorld[.35,-2.3,.265]);
_microW setPos(_b modelToWorld[.4,-.815,.14]);_microW setDir(_dir+110);
_pillow1 setPos(_b modelToWorld[7.3,2.4,-.18]);
_pillow2 setPos(_b modelToWorld[7.15,-3.1,-.18]);
_rack setPos(_b modelToWorld[1.55,-3.1,.82]);
_radio setPos(_b modelToWorld[7,.35,.28]);_radio setDir(_dir+290);
_sack setPos(_b modelToWorld[-2.68,2.47,.09]);_sack setDir(_dir+270);
_sink setPos(_b modelToWorld[-.3,-3,.5]);_sink setDir _dir;
_table setPos(_b modelToWorld[7,.35,.135]);_table setDir(_dir+270);
_trash setPos(_b modelToWorld[-3.3,2.4,.28]);
{_x setDir(_dir+90)}forEach[_blanket1,_desk,_flag1,_fridge,_pillow1,_pillow2];
{_x setDir(_dir+180)}forEach[_bed1,_blanket2,_rack,_trash];
_flagAltis=selectRandom["a3\data_f\flags\flag_AAF_co.paa","a3\data_f\flags\flag_Altis_co.paa","a3\data_f\flags\flag_FIA_co.paa","a3\data_f\flags\flag_AltisColonial_co.paa"];
_flagTanoa=selectRandom["a3\data_f_exp\flags\flag_GEN_CO.paa","a3\data_f\flags\flag_SYND_CO.paa","a3\data_f\flags\flag_VIPER_CO.paa","a3\data_f\flags\flag_Tanoa_CO.paa"];
switch(PF_WN)do{
case"Altis":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Malden":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Stratis":{_flag1 setObjectTextureGlobal[0,_flagAltis]};
case"Tanoa":{_flag1 setObjectTextureGlobal[0,_flagTanoa]};
default{_flag1 setObjectTextureGlobal[0,"a3\data_f\flags\flag_bis_co.paa"]}}}