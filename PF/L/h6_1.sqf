//Land_House_1W09_F
isNil{params["_b"];_f=[];_chair=0;_chair4=0;_chair5=0;_pic=0;_rack=0;_rack1=0;_sack=0;_dir=getDir _b;
_bed=createSimpleObject["a3\props_f_orange\furniture\woodenbed_01_f.p3d",[0,0,0]];
if(floor random 2==0)then{_chair=createSimpleObject["a3\Props_F_Orange\Furniture\Armchair_01_F.p3d",[0,0,0]];_f pushBack _chair};
_chair1=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_chair2=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
_chair3=createSimpleObject["a3\structures_f\furniture\chairwood_f.p3d",[0,0,0]];
if(floor random 2==0)then{_chair4=createSimpleObject["a3\structures_f_heli\furniture\rattanchair_01_f.p3d",[0,0,0]];_f pushBack _chair4};
if(floor random 2==0)then{_chair5=createSimpleObject["a3\structures_f_heli\furniture\rattanchair_01_f.p3d",[0,0,0]];_f pushBack _chair5};
_desk=createSimpleObject["A3\Structures_F\Furniture\TableDesk_F.p3d",[0,0,0]];
_fridge=createSimpleObject["A3\Structures_F_Heli\Items\Electronics\Fridge_01_F.p3d",[0,0,0]];
if(floor random 2==0)then{_pic=createSimpleObject["a3\props_f_orange\items\decorative\photoframe_01_f.p3d",[0,0,0]];_f pushBack _pic};
_pkg=createSimpleObject["a3\structures_f_epb\items\luggage\luggageheap_01_f.p3d",[0,0,0]];
_plant=createSimpleObject["a3\props_f_orange\items\decorative\flowerpot_01_flower_f.p3d",[0,0,0]];
_pole=createSimpleObject["a3\structures_f\ind\powerlines\powerpolewooden_small_f.p3d",[0,0,0]];
if(floor random 2==0)then{_rack=createSimpleObject["a3\props_f_orange\furniture\officecabinet_02_f.p3d",[0,0,0]];_f pushBack _rack};
if(floor random 2==0)then{_rack1=createSimpleObject["a3\structures_f\furniture\rack_f.p3d",[0,0,0]];_f pushBack _rack1};
_rug=createSimpleObject["a3\props_f_orange\furniture\rug_01_f.p3d",[0,0,0]];
if(floor random 2==0)then{_sack=createSimpleObject["a3\structures_f\civ\market\sack_f.p3d",[0,0,0]];_f pushBack _sack};
_table=createSimpleObject["a3\props_f_orange\furniture\tablebig_01_f.p3d",[0,0,0]];
{_f pushBack _x}forEach[_bed,_chair1,_chair2,_chair3,_desk,_fridge,_pkg,_plant,_pole,_rug,_table];
_b setVariable["PF",_f];

_bed setPos(_b modelToWorld[-0.07,-3.41,-1.04]);_bed setDir(_dir+180);
if(_chair isEqualType objNull)then{_chair setPos(_b modelToWorld[-6.6,.795,-1.04]);_chair setDir(_dir+90)};
_chair1 setPos(_b modelToWorld[-2.2,4.04,-1.96]);_chair1 setDir(_dir+310);
_chair2 setPos(_b modelToWorld[-1.7,3.66,-1.96]);_chair2 setDir(_dir+185);
_chair3 setPos(_b modelToWorld[-.7,3.446,-1.96]);_chair3 setDir(_dir+125+random 65);
if(_chair4 isEqualType objNull)then{_chair4 setPos(_b modelToWorld[-3.6,-3,-0.84])};
if(_chair5 isEqualType objNull)then{_chair5 setPos(_b modelToWorld[-6.72,-3,-0.84]);_chair5 setDir(_dir+160)};
_desk setPos(_b modelToWorld[1.83,4.14,-1.248]);
_fridge setPos(_b modelToWorld[0.5,4.1,-0.926]);
if(_pic isEqualType objNull)then{_pic setPos(_b modelToWorld[-4.12,.3,-0.3]);_pic setDir(_dir+270)};
_pkg setPos(_b modelToWorld[-0.034,-2.04,-0.94]);_pkg setDir(_dir+268);
_plant setPos(_b modelToWorld[-3.43,-4.3,0.429]);
_pole setPos(_b modelToWorld[-3.46,-4.35,-1.16]);
if(_rack isEqualType objNull)then{_rack setPos(_b modelToWorld[0.31,1,-.396]);_rack setDir(_dir+270)};
if(_rack1 isEqualType objNull)then{_rack1 setPos(_b modelToWorld[-5.56,3.5,-.5]);_rack1 setDir _dir};
if(_sack isEqualType objNull)then{_sack setPos(_b modelToWorld[-6.7,-.2,-1.1]);_sack setDir(_dir-31)};
_table setPos(_b modelToWorld[-1.14,4,-1.07]);
{_x setDir _dir}forEach[_desk,_fridge,_plant,_pole,_table]}