//Land_i_Stone_HouseSmall_V1_F
isNil{params["_b"];_f=[];_dir=getDir _b;
_axe=createSimpleObject["A3\Structures_F\Items\Tools\Axe_F.p3d",[0,0,0]];
_basket=createSimpleObject["A3\Structures_F\Civ\Market\Basket_F.p3d",[0,0,0]];
_bed1=createSimpleObject["a3\structures_f\civ\Camping\CampingTable_F.p3d",[0,0,0]];
_bed2=createSimpleObject["a3\structures_f\civ\Camping\CampingTable_F.p3d",[0,0,0]];
_blanket=[(selectRandom["A3\Structures_F\Civ\Camping\Sleeping_bag_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_blue_F.p3d","A3\Structures_F\Civ\Camping\Sleeping_bag_brown_F.p3d"]),[0,0,0]];
_blanket1=createSimpleObject _blanket;
_blanket2=createSimpleObject _blanket;
_bottle=createSimpleObject["A3\Props_F_Orange\Humanitarian\Supplies\WaterBottle_01_compressed_F.p3d",[0,0,0]];
_bottle1=createSimpleObject["A3\Props_F_Orange\Humanitarian\Supplies\WaterBottle_01_full_F.p3d",[0,0,0]];
_bottle2=createSimpleObject["A3\Props_F_Orange\Humanitarian\Supplies\WaterBottle_01_empty_F.p3d",[0,0,0]];
_can=createSimpleObject["A3\Structures_F\Items\Vessels\CanisterPlastic_F.p3d",[0,0,0]];
_chair1=createSimpleObject["A3\Structures_F\Furniture\ChairWood_F.p3d",[0,0,0]];
_chair2=createSimpleObject["A3\Structures_F\Furniture\ChairWood_F.p3d",[0,0,0]];
_chair3=createSimpleObject["A3\Structures_F\Furniture\ChairWood_F.p3d",[0,0,0]];
_crates=createSimpleObject["A3\Structures_F\Civ\Market\CratesWooden_F.p3d",[0,0,0]];
_desk=createSimpleObject["A3\Structures_F_Heli\Furniture\OfficeTable_01_F.p3d",[0,0,0]];
_gen=createSimpleObject["A3\Structures_F\Items\Electronics\Portable_generator_F.p3d",[0,0,0]];
_glove=createSimpleObject["A3\Structures_F\Items\Tools\Gloves_F.p3d",[0,0,0]];
_logs=createSimpleObject["A3\Structures_F\Civ\Accessories\WoodPile_F.p3d",[0,0,0]];
_matches=createSimpleObject["A3\Structures_F_EPA\Items\Tools\Matches_F.p3d",[0,0,0]];
_pillow=selectRandom["Land_Pillow_F","Land_Pillow_camouflage_F","Land_Pillow_grey_F","Land_Pillow_old_F"];
_pillow1=createSimpleObject[_pillow,[0,0,0]];
_pillow2=createSimpleObject[_pillow,[0,0,0]];
_poster=createSimpleObject[(selectRandom["Land_Poster_01_F","Land_Poster_02_F","Land_Poster_03_F"]),[0,0,0]];
_radio=createSimpleObject["Land_FMRadio_F",[0,0,0]];
_rug=createSimpleObject[(selectRandom["Land_Rug_01_F","Land_Rug_01_Traditional_F"]),[0,0,0]];
_shelf=createSimpleObject["a3\Props_F_Orange\Furniture\OfficeCabinet_02_F.p3d",[0,0,0]];
_stool=createSimpleObject["A3\Structures_F\Furniture\Bench_F.p3d",[0,0,0]];
_stump=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenLog_F.p3d",[0,0,0]];
_table=createSimpleObject["A3\Structures_F_EPA\Civ\Camping\WoodenTable_large_F.p3d",[0,0,0]];
_wrench=createSimpleObject["A3\Structures_F\Items\Tools\Wrench_F.p3d",[0,0,0]];
{_f pushBack _x}forEach[_axe,_basket,_bed1,_bed2,_blanket1,_blanket2,_bucket,_can,_chair1,_chair2,_chair3,_crates,_desk,_gen,_glove,_logs,_matches,_pillow1,_pillow2,_poster,_radio,_rug,_shelf,_stool,_table];
 _b setVariable["PF",_f];

_axe setPos(_b modelToWorld[2.1,4.1,-.62]);_axe setDir(_dir+160);
 _basket setPos(_b modelToWorld[-5.5,1.45,0]);
 _bed1 setPos(_b modelToWorld[-5,0,-.18]);_bed1 setDir(_dir+90);
_bed2 setPos(_b modelToWorld[-5.9,0,-.18]);_bed2 setDir(_dir+270);
_blanket1 setPos(_b modelToWorld[-5,0,-.14]);
_blanket2 setPos(_b modelToWorld[-5.9,0,-.14]);
 _can setPos(_b modelToWorld[-9.4,-.7,0]);_can setDir(_dir+270);
 _chair1 setPos(_b modelToWorld[8.3,1.5,-.6]);_chair1 setDir(_dir+random 10+270);
_chair2 setPos(_b modelToWorld[8.3,2.5,-.6]);_chair2 setDir(_dir+random 10+270);
_chair3 setPos(_b modelToWorld[4.5,-.5,-.64]);
_crates setPos(_b modelToWorld[-.65,4.4,.85]);
_desk setPos(_b modelToWorld[4.3,-.7,.19]);
_gen setPos(_b modelToWorld[-9.3,1,.07]);_gen setDir(_dir+90);
_glove setPos(_b modelToWorld[-8.9,1.5,-.63]);_glove setDir(_dir+260);
_logs setPos(_b modelToWorld[3.2,4.85,-.12]);_logs setDir(_dir+90);
_matches setPos(_b modelToWorld[3,3.75,-.158]);
_pillow1 setPos(_b modelToWorld[-5,-.8,-.1]);
_pillow2 setPos(_b modelToWorld[-5.9,-.8,-.1]);
_poster setPos(_b modelToWorld[-6.8,5.2,1]);
_radio setPos(_b modelToWorld[8.7,2,.378]);_radio setDir(_dir+280);
_rug setPos(_b modelToWorld[7,.5,-.6]);
_shelf setPos(_b modelToWorld[5.56,-.83,.91]);
_stool setPos(_b modelToWorld[3,3.5,-.19]);_stool setDir(_dir+40);
_table setPos(_b modelToWorld[8.75,2,.24]);
{_x setDir _dir}forEach[_chair3,_pillow1,_pillow2,_poster,_rug,_stump,_table];
{_x setDir(random 359)}forEach[_basket,_matches];
{_x setDir(_dir+180)}forEach[_blanket1,_blanket2,_crates,_desk,_shelf]}