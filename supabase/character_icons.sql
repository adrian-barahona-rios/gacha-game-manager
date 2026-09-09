-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere characters.sql, characters_full.sql y characters_genshin_missing.sql.
--
-- Rellena image_url con el icono oficial de cada personaje.
--
-- Fuentes (las dos permiten enlazado directo y responden con
-- Access-Control-Allow-Origin: *, comprobado una por una):
--   enka.network      -> iconos extraidos del propio juego, para los tres.
--   fandom            -> respaldo para los personajes de Genshin que Enka
--                        todavia no tiene en su catalogo.
--
-- El comentario de characters.sql decia que las wikis devolvian 403 al
-- enlazar imagenes: ya no es asi, las 227 URLs de este archivo cargan.

-- ---------------------------------------------------------------------------
-- Genshin Impact (119 personajes)
-- ---------------------------------------------------------------------------
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Aino.png' where id = 'gi-aino';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Albedo.png' where id = 'gi-albedo';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Alhatham.png' where id = 'gi-alhaitham';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Aloy.png' where id = 'gi-aloy';
update public.characters set image_url = 'https://static.wikia.nocookie.net/gensin-impact/images/1/1d/Alyosha_Icon.png' where id = 'gi-alyosha';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Ambor.png' where id = 'gi-amber';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Itto.png' where id = 'gi-arataki-itto';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Arlecchino.png' where id = 'gi-arlecchino';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Ayaka.png' where id = 'gi-ayaka';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Ayato.png' where id = 'gi-ayato';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Baizhuer.png' where id = 'gi-baizhu';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Barbara.png' where id = 'gi-barbara';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Beidou.png' where id = 'gi-beidou';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Bennett.png' where id = 'gi-bennett';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Candace.png' where id = 'gi-candace';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Charlotte.png' where id = 'gi-charlotte';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Chasca.png' where id = 'gi-chasca';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Chevreuse.png' where id = 'gi-chevreuse';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Chiori.png' where id = 'gi-chiori';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Chongyun.png' where id = 'gi-chongyun';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Citlali.png' where id = 'gi-citlali';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Clorinde.png' where id = 'gi-clorinde';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Collei.png' where id = 'gi-collei';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Columbina.png' where id = 'gi-columbina';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Cyno.png' where id = 'gi-cyno';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Dahlia.png' where id = 'gi-dahlia';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Dehya.png' where id = 'gi-dehya';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Diluc.png' where id = 'gi-diluc';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Diona.png' where id = 'gi-diona';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Dori.png' where id = 'gi-dori';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Durin.png' where id = 'gi-durin';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Emilie.png' where id = 'gi-emilie';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Escoffier.png' where id = 'gi-escoffier';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Eula.png' where id = 'gi-eula';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Faruzan.png' where id = 'gi-faruzan';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Fischl.png' where id = 'gi-fischl';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Flins.png' where id = 'gi-flins';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Freminet.png' where id = 'gi-freminet';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Furina.png' where id = 'gi-furina';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Gaming.png' where id = 'gi-gaming';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Ganyu.png' where id = 'gi-ganyu';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Gorou.png' where id = 'gi-gorou';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Heizo.png' where id = 'gi-heizou';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Hutao.png' where id = 'gi-hu-tao';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Iansan.png' where id = 'gi-iansan';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Ifa.png' where id = 'gi-ifa';
update public.characters set image_url = 'https://static.wikia.nocookie.net/gensin-impact/images/9/96/Illuga_Icon.png' where id = 'gi-illuga';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Ineffa.png' where id = 'gi-ineffa';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Jahoda.png' where id = 'gi-jahoda';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Qin.png' where id = 'gi-jean';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Kachina.png' where id = 'gi-kachina';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Kaeya.png' where id = 'gi-kaeya';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Kaveh.png' where id = 'gi-kaveh';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Kazuha.png' where id = 'gi-kazuha';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Keqing.png' where id = 'gi-keqing';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Kinich.png' where id = 'gi-kinich';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Momoka.png' where id = 'gi-kirara';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Klee.png' where id = 'gi-klee';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Kokomi.png' where id = 'gi-kokomi';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Sara.png' where id = 'gi-kujou-sara';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Shinobu.png' where id = 'gi-kuki-shinobu';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Lanyan.png' where id = 'gi-lan-yan';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Lauma.png' where id = 'gi-lauma';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Layla.png' where id = 'gi-layla';
update public.characters set image_url = 'https://static.wikia.nocookie.net/gensin-impact/images/a/a9/Linnea_Icon.png' where id = 'gi-linnea';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Lisa.png' where id = 'gi-lisa';
update public.characters set image_url = 'https://static.wikia.nocookie.net/gensin-impact/images/8/86/Lohen_Icon.png' where id = 'gi-lohen';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Linette.png' where id = 'gi-lynette';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Liney.png' where id = 'gi-lyney';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Mavuika.png' where id = 'gi-mavuika';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Mika.png' where id = 'gi-mika';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Mizuki.png' where id = 'gi-mizuki';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Mona.png' where id = 'gi-mona';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Mualani.png' where id = 'gi-mualani';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Nahida.png' where id = 'gi-nahida';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Navia.png' where id = 'gi-navia';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Nefer.png' where id = 'gi-nefer';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Neuvillette.png' where id = 'gi-neuvillette';
update public.characters set image_url = 'https://static.wikia.nocookie.net/gensin-impact/images/a/a0/Nicole_Icon.png' where id = 'gi-nicole';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Nilou.png' where id = 'gi-nilou';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Ningguang.png' where id = 'gi-ningguang';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Noel.png' where id = 'gi-noelle';
update public.characters set image_url = 'https://static.wikia.nocookie.net/gensin-impact/images/8/87/Odette_Icon.png' where id = 'gi-odette';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Olorun.png' where id = 'gi-ororon';
update public.characters set image_url = 'https://static.wikia.nocookie.net/gensin-impact/images/9/99/Prune_Icon.png' where id = 'gi-prune';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Qiqi.png' where id = 'gi-qiqi';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Shougun.png' where id = 'gi-raiden';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Razor.png' where id = 'gi-razor';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Rosaria.png' where id = 'gi-rosaria';
update public.characters set image_url = 'https://static.wikia.nocookie.net/gensin-impact/images/c/c8/Sandrone_Icon.png' where id = 'gi-sandrone';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Sayu.png' where id = 'gi-sayu';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Sethos.png' where id = 'gi-sethos';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Shenhe.png' where id = 'gi-shenhe';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Sigewinne.png' where id = 'gi-sigewinne';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_SkirkNew.png' where id = 'gi-skirk';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Sucrose.png' where id = 'gi-sucrose';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Tartaglia.png' where id = 'gi-tartaglia';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Tohma.png' where id = 'gi-thoma';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Tighnari.png' where id = 'gi-tighnari';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_PlayerGirl.png' where id = 'gi-traveler';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Varesa.png' where id = 'gi-varesa';
update public.characters set image_url = 'https://static.wikia.nocookie.net/gensin-impact/images/9/98/Varka_Icon.png' where id = 'gi-varka';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Venti.png' where id = 'gi-venti';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Wanderer.png' where id = 'gi-wanderer';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Wriothesley.png' where id = 'gi-wriothesley';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Xiangling.png' where id = 'gi-xiangling';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Liuyun.png' where id = 'gi-xianyun';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Xiao.png' where id = 'gi-xiao';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Xilonen.png' where id = 'gi-xilonen';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Xingqiu.png' where id = 'gi-xingqiu';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Xinyan.png' where id = 'gi-xinyan';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Yae.png' where id = 'gi-yae-miko';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Feiyan.png' where id = 'gi-yanfei';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Yaoyao.png' where id = 'gi-yaoyao';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Yelan.png' where id = 'gi-yelan';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Yoimiya.png' where id = 'gi-yoimiya';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Yunjin.png' where id = 'gi-yun-jin';
update public.characters set image_url = 'https://enka.network/ui/UI_AvatarIcon_Zhongli.png' where id = 'gi-zhongli';
update public.characters set image_url = 'https://static.wikia.nocookie.net/gensin-impact/images/2/22/Zibai_Icon.png' where id = 'gi-zibai';

-- ---------------------------------------------------------------------------
-- Honkai: Star Rail (81 personajes)
-- ---------------------------------------------------------------------------
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1308.png' where id = 'hsr-acheron';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1402.png' where id = 'hsr-aglaea';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1405.png' where id = 'hsr-anaxa';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1015.png' where id = 'hsr-archer';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1302.png' where id = 'hsr-argenti';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1008.png' where id = 'hsr-arlan';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1009.png' where id = 'hsr-asta';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1304.png' where id = 'hsr-aventurine';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1211.png' where id = 'hsr-bailu';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1307.png' where id = 'hsr-black-swan';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1205.png' where id = 'hsr-blade';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1315.png' where id = 'hsr-boothill';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1101.png' where id = 'hsr-bronya';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1407.png' where id = 'hsr-castorice';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1412.png' where id = 'hsr-cerydra';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1406.png' where id = 'hsr-cipher';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1107.png' where id = 'hsr-clara';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1415.png' where id = 'hsr-cyrene';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1002.png' where id = 'hsr-dan-heng';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1305.png' where id = 'hsr-dr-ratio';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1413.png' where id = 'hsr-evernight';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1220.png' where id = 'hsr-feixiao';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1310.png' where id = 'hsr-firefly';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1208.png' where id = 'hsr-fu-xuan';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1225.png' where id = 'hsr-fugue';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1301.png' where id = 'hsr-gallagher';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1104.png' where id = 'hsr-gepard';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1509.png' where id = 'hsr-gilgamesh';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1210.png' where id = 'hsr-guinaifen';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1215.png' where id = 'hsr-hanya';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1013.png' where id = 'hsr-herta';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1003.png' where id = 'hsr-himeko';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1109.png' where id = 'hsr-hook';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1217.png' where id = 'hsr-huohuo';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1409.png' where id = 'hsr-hyacine';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1410.png' where id = 'hsr-hysilens';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1213.png' where id = 'hsr-imbibitor-lunae';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1314.png' where id = 'hsr-jade';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1218.png' where id = 'hsr-jiaoqiu';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1204.png' where id = 'hsr-jing-yuan';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1212.png' where id = 'hsr-jingliu';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1005.png' where id = 'hsr-kafka';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1222.png' where id = 'hsr-lingsha';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1111.png' where id = 'hsr-luka';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1203.png' where id = 'hsr-luocha';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1110.png' where id = 'hsr-lynx';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1224.png' where id = 'hsr-march-7th';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1224.png' where id = 'hsr-march-7th-imaginaria';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1312.png' where id = 'hsr-misha';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1223.png' where id = 'hsr-moze';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1404.png' where id = 'hsr-mydei';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1105.png' where id = 'hsr-natasha';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1106.png' where id = 'hsr-pela';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1414.png' where id = 'hsr-permanser-terrae';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1408.png' where id = 'hsr-phainon';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1201.png' where id = 'hsr-qingque';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1317.png' where id = 'hsr-rappa';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1508.png' where id = 'hsr-rin-tohsaka';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1309.png' where id = 'hsr-robin';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1303.png' where id = 'hsr-ruan-mei';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1014.png' where id = 'hsr-saber';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1108.png' where id = 'hsr-sampo';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1102.png' where id = 'hsr-seele';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1103.png' where id = 'hsr-serval';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1006.png' where id = 'hsr-silver-wolf';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1306.png' where id = 'hsr-sparkle';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1313.png' where id = 'hsr-sunday';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1206.png' where id = 'hsr-sushang';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1401.png' where id = 'hsr-the-herta';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1202.png' where id = 'hsr-tingyun';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1112.png' where id = 'hsr-topaz';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/8002.png' where id = 'hsr-trazacaminos-fisico';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/8004.png' where id = 'hsr-trazacaminos-fuego';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/8008.png' where id = 'hsr-trazacaminos-hielo';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/8006.png' where id = 'hsr-trazacaminos-imaginario';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1403.png' where id = 'hsr-tribbie';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1004.png' where id = 'hsr-welt';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1214.png' where id = 'hsr-xueyi';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1209.png' where id = 'hsr-yanqing';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1207.png' where id = 'hsr-yukong';
update public.characters set image_url = 'https://enka.network/ui/hsr/SpriteOutput/AvatarRoundIcon/1221.png' where id = 'hsr-yunli';

-- ---------------------------------------------------------------------------
-- Zenless Zone Zero (27 personajes)
-- ---------------------------------------------------------------------------
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle01.png' where id = 'zzz-anby';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle15.png' where id = 'zzz-anton';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle16.png' where id = 'zzz-ben';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle10.png' where id = 'zzz-billy';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle32.png' where id = 'zzz-burnice';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle25.png' where id = 'zzz-caesar';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle09.png' where id = 'zzz-corin';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle21.png' where id = 'zzz-ellen';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle20.png' where id = 'zzz-grace';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle35.png' where id = 'zzz-harumasa';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle24.png' where id = 'zzz-jane-doe';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle14.png' where id = 'zzz-koleda';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle26.png' where id = 'zzz-lighter';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle27.png' where id = 'zzz-lucy';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle18.png' where id = 'zzz-lycaon';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle13.png' where id = 'zzz-miyabi';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle11.png' where id = 'zzz-nekomata';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle12.png' where id = 'zzz-nicole';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle28.png' where id = 'zzz-piper';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle29.png' where id = 'zzz-qingyi';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle22.png' where id = 'zzz-rina';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle30.png' where id = 'zzz-seth';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle05.png' where id = 'zzz-soldado-11';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle05.png' where id = 'zzz-soldier-11';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle17.png' where id = 'zzz-soukaku';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle31.png' where id = 'zzz-yanagi';
update public.characters set image_url = 'https://enka.network/ui/zzz/IconRoleCircle23.png' where id = 'zzz-zhu-yuan';

-- Resumen: 227 iconos (217 de enka.network, 10 de fandom).
--
-- Comprobacion: debe devolver 227.
select count(*) from public.characters
where image_url is not null and image_url <> '';
