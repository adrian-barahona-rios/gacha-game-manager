-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
--
-- Rellena "Para qué personajes va bien" de los conos de luz de Honkai, las
-- armas de Genshin y los amplificadores de Zenless: 511 en total.
--
-- Fuente: las guias de Game8 (game8.co), que en la pagina de cada arma tienen
-- una seccion "Best Characters" con los personajes recomendados. Se usa Game8
-- porque la wiki de HoYoLAB solo trae esta recomendacion en unos pocos: en
-- Honkai unos 45 conos (y solo en ingles), en Genshin viene en la ficha de
-- algunos personajes y en Zenless en ninguno.
--
-- Como se escribe el texto:
--   "Ideal para X. Tambien va bien con Y y Z." cuando la guia distingue los
--     mejores de los demas: en Honkai la tabla "Best" frente a la de "Other";
--     en Zenless el primero de la lista, que va de mas a menos recomendado; en
--     Genshin los que destaca la explicacion, y ahi pone "Sobre todo para".
--   Solo la lista de nombres cuando la guia no distingue.
--   Los amplificadores exclusivos de Zenless siguen empezando por "Amplificador
--     exclusivo de X".
--   Las armas de 1 y 2 estrellas de Genshin llevan el aviso de que solo sirven
--     al principio.
-- Los personajes van con el nombre que usa la app. Los que Game8 ya recomienda
-- pero la app aun no tiene (Mortenax Blade, Himeko (Nova), Robin (Summeretto),
-- Silver Wolf Lv.999) van con su nombre en ingles.
--
-- Se quedan sin rellenar 3: Game8 no recomienda a nadie o el arma aun
-- no ha salido.
--
-- Sobrescribe lo que hubiera en good_for. Requiere que ya esten las armas
-- (hsr_conos.sql, genshin_armas.sql y zzz_amplificadores.sql).
--
-- Generado el 2026-09-11.

alter table public.weapons add column if not exists good_for text;

begin;

-- Honkai: Star Rail (conos de luz): 166
update public.weapons set good_for = 'Asta, Bronya, Tingyun, Yukong, Hanya, Ruan Mei, Sparkle (Hanabi), Trazacaminos (Imag.) y Tribbie.' where id = 'hsr-lc-21018'; -- ¡A bailar!
update public.weapons set good_for = 'March 7th, Trazacaminos (Fuego) y Aventurino (Aventurine).' where id = 'hsr-lc-21030'; -- ¡Así soy yo!
update public.weapons set good_for = 'Hook.' where id = 'hsr-lc-21026'; -- ¡Guau! ¡Hora de pasear!
update public.weapons set good_for = 'March 7th (Imaginaria).' where id = 'hsr-lc-21017'; -- ¡Suscríbanse a mi canal!
update public.weapons set good_for = 'Firefly (Sam) y Xueyi.' where id = 'hsr-lc-23025'; -- A donde regresan los sueños
update public.weapons set good_for = 'Ideal para Evernight. También va bien con Robin (Summeretto).' where id = 'hsr-lc-23049'; -- A la estrella de la larga noche
update public.weapons set good_for = 'Dan Heng (Permanser Terrae).' where id = 'hsr-lc-23051'; -- A través de montañas y ríos
update public.weapons set good_for = 'Trazacaminos (Imag.) y Ruan Mei.' where id = 'hsr-lc-21056'; -- Al perseguir el viento
update public.weapons set good_for = 'Ideal para Clara y Arlan. También va bien con Blade, Hook, Trazacaminos (Físico), Dan Heng (Imbibitor Lunae), Jingliu, Firefly (Sam) y Yunli.' where id = 'hsr-lc-23002'; -- Algo insustituible
update public.weapons set good_for = 'Gepard, March 7th y Trazacaminos (Fuego).' where id = 'hsr-lc-20003'; -- Ámbar
update public.weapons set good_for = 'Ideal para Cyrene. También va bien con Hyacine y Trazacaminos (Hielo).' where id = 'hsr-lc-23052'; -- Amor eterno como este momento
update public.weapons set good_for = 'Boothill y March 7th (Imaginaria).' where id = 'hsr-lc-20014'; -- Antagonista
update public.weapons set good_for = 'Ideal para Pela y Silver Wolf. También va bien con Welt, Luka, Black Swan, Jiaoqiu y Mortenax Blade.' where id = 'hsr-lc-22000'; -- Antes de que comience la misión del tutorial
update public.weapons set good_for = 'Ideal para Jing Yuan, Himeko, Qingque, Herta y Serval. También va bien con Argenti y Jade.' where id = 'hsr-lc-23010'; -- Antes del amanecer
update public.weapons set good_for = 'Argenti.' where id = 'hsr-lc-20006'; -- Archivos
update public.weapons set good_for = 'Kafka, Guinaifen, Black Swan y Acheron.' where id = 'hsr-lc-21041'; -- Arriba el telón
update public.weapons set good_for = 'Bronya, Tingyun, Yukong, Hanya y Sparkle (Hanabi).' where id = 'hsr-lc-21036'; -- Aventuras en Villa Ensueño
update public.weapons set good_for = 'Arlan, Blade, Clara, Hook, Trazacaminos (Físico), Dan Heng (Imbibitor Lunae), Jingliu, Xueyi, Misha, Yunli y Gilgamesh (Collab).' where id = 'hsr-lc-21019'; -- Bajo el cielo azul
update public.weapons set good_for = 'Silver Wolf Lv.999.' where id = 'hsr-lc-23057'; -- Bienvenidos a la ciudad cósmica
update public.weapons set good_for = 'Fu Xuan y Trazacaminos (Fuego).' where id = 'hsr-lc-20010'; -- Blindaje
update public.weapons set good_for = 'Welt y Acheron.' where id = 'hsr-lc-20011'; -- Bucle
update public.weapons set good_for = 'Ideal para Sampo, Guinaifen y Luka. También va bien con Kafka, Pela, Silver Wolf, Welt, Black Swan, Acheron y Mortenax Blade.' where id = 'hsr-lc-21001'; -- Buenas noches, que duermas bien
update public.weapons set good_for = 'Himeko, Argenti, Qingque, Serval, Herta, Jing Yuan, Jade y Rin Tohsaka (Collab).' where id = 'hsr-lc-24004'; -- Cálculo interminable
update public.weapons set good_for = 'Kafka, Sampo, Luka, Guinaifen, Black Swan y Acheron.' where id = 'hsr-lc-21022'; -- Calderón
update public.weapons set good_for = 'Arlan, Hook, Trazacaminos (Físico), Dan Heng (Imbibitor Lunae), Jingliu y Xueyi.' where id = 'hsr-lc-20002'; -- Colapso celeste
update public.weapons set good_for = 'Aventurino (Aventurine) y Trazacaminos (Fuego).' where id = 'hsr-lc-21043'; -- Concierto para dos
update public.weapons set good_for = 'Bailu, Luocha, Natasha, Lynx, Huohuo, Gallagher y Lingsha.' where id = 'hsr-lc-21000'; -- Conversación en el postoperatorio
update public.weapons set good_for = 'Bailu, Luocha, Natasha, Lynx y Huohuo.' where id = 'hsr-lc-20001'; -- Cornucopia
update public.weapons set good_for = 'Asta, Bronya y Yukong.' where id = 'hsr-lc-20005'; -- Coro
update public.weapons set good_for = 'Ideal para Saber (Collab). También va bien con Gilgamesh (Collab).' where id = 'hsr-lc-23045'; -- Coronación sin agradecimiento
update public.weapons set good_for = 'Dan Heng, Seele, Sushang, Yanqing, Topaz y Numby, Dr. Ratio, Boothill, March 7th (Imaginaria), Feixiao y Moze.' where id = 'hsr-lc-24001'; -- Crucero estelar
update public.weapons set good_for = 'Yao Guang.' where id = 'hsr-lc-23054'; -- Cuando se decidió a ver
update public.weapons set good_for = 'Himeko (Nova).' where id = 'hsr-lc-23060'; -- Cuando una estrella ilumina la noche
update public.weapons set good_for = 'Lingsha.' where id = 'hsr-lc-21035'; -- Cuestión de verdad
update public.weapons set good_for = 'Ideal para Yunli y Clara. También va bien con Blade.' where id = 'hsr-lc-23030'; -- Danza crepuscular
update public.weapons set good_for = 'Ideal para Sunday y Tingyun. También va bien con Sparkle (Hanabi) y Bronya.' where id = 'hsr-lc-23034'; -- De vuelta a la tierra
update public.weapons set good_for = 'Ideal para Castorice. También va bien con Evernight.' where id = 'hsr-lc-23040'; -- Despedidas más bellas
update public.weapons set good_for = 'Rin Tohsaka (Collab) y Archer (Collab).' where id = 'hsr-lc-23061'; -- Destelleos silentes
update public.weapons set good_for = 'Pela, Sampo, Silver Wolf, Welt, Luka, Black Swan, Acheron, Jiaoqiu y Mortenax Blade.' where id = 'hsr-lc-21015'; -- Determinación reluciente
update public.weapons set good_for = 'Herta, Himeko, Jing Yuan, Qingque, Serval, Argenti, The Herta (La Herta), Anaxa y Rin Tohsaka (Collab).' where id = 'hsr-lc-21040'; -- Día del colapso cósmico
update public.weapons set good_for = 'Dan Heng, Seele, Sushang, Yanqing, Topaz y Numby, Dr. Ratio, Boothill, March 7th (Imaginaria) y Moze.' where id = 'hsr-lc-23012'; -- Dormir como un tronco
update public.weapons set good_for = 'Luocha y Lingsha.' where id = 'hsr-lc-23008'; -- Ecos del ataúd
update public.weapons set good_for = 'Ideal para Dr. Ratio. También va bien con March 7th (Imaginaria), Feixiao y Moze.' where id = 'hsr-lc-23020'; -- El bautismo del pensamiento puro
update public.weapons set good_for = 'Chispa (Sparxie).' where id = 'hsr-lc-23053'; -- El cautivador mundochispa
update public.weapons set good_for = 'Ideal para Aventurino (Aventurine). También va bien con March 7th.' where id = 'hsr-lc-23023'; -- El destino nunca es justo
update public.weapons set good_for = 'Ideal para Ashveil. También va bien con Moze, Topaz y Numby, Dr. Ratio, March 7th (Imaginaria) y Feixiao.' where id = 'hsr-lc-23056'; -- El final de una mentira
update public.weapons set good_for = 'Anaxa.' where id = 'hsr-lc-22004'; -- El gran negocio cósmico
update public.weapons set good_for = 'Fugue (Tingyun 5⭐).' where id = 'hsr-lc-23035'; -- El largo camino a casa
update public.weapons set good_for = 'Ideal para Gepard, March 7th y Trazacaminos (Fuego). También va bien con Fu Xuan, Aventurino (Aventurine) y Dan Heng (Permanser Terrae).' where id = 'hsr-lc-23005'; -- El momento de la victoria
update public.weapons set good_for = 'Luocha, Lynx, Huohuo y Gallagher.' where id = 'hsr-lc-21014'; -- El momento oportuno
update public.weapons set good_for = 'Herta, Himeko y Jing Yuan.' where id = 'hsr-lc-21006'; -- El nacimiento del yo
update public.weapons set good_for = 'Bronya, Yukong, Hanya, Sparkle (Hanabi), Robin y Sunday.' where id = 'hsr-lc-21025'; -- El pasado y el futuro
update public.weapons set good_for = 'Fu Xuan, Gepard, March 7th, Trazacaminos (Fuego) y Aventurino (Aventurine).' where id = 'hsr-lc-21002'; -- El primer día del resto de mi vida
update public.weapons set good_for = 'Herta, Himeko, Jing Yuan, Qingque, Serval, Argenti, Jade, The Herta (La Herta) e Himeko (Nova).' where id = 'hsr-lc-21020'; -- El reposo de los genios
update public.weapons set good_for = 'Dan Heng, Seele, Sushang, Yanqing, Dr. Ratio, Boothill y March 7th (Imaginaria).' where id = 'hsr-lc-21024'; -- El río nace en primavera
update public.weapons set good_for = 'Bailu, Luocha, Natasha, Lynx, Huohuo, Gallagher y Robin (Summeretto).' where id = 'hsr-lc-23013'; -- El tiempo no espera
update public.weapons set good_for = 'Ideal para Seele, Yanqing, Sushang, Dan Heng y March 7th (Imaginaria). También va bien con Dr. Ratio.' where id = 'hsr-lc-23001'; -- En la noche
update public.weapons set good_for = 'Ideal para Acheron. También va bien con Welt.' where id = 'hsr-lc-23024'; -- En las orillas transitorias
update public.weapons set good_for = 'Ideal para Welt. También va bien con Kafka, Pela, Sampo, Silver Wolf, Luka y Acheron.' where id = 'hsr-lc-23004'; -- En nombre del mundo
update public.weapons set good_for = 'Evanescia.' where id = 'hsr-lc-23058'; -- Encuentro en la próxima primavera
update public.weapons set good_for = 'Asta, Yukong, Hanya, Ruan Mei, Sparkle (Hanabi) y Trazacaminos (Imag.).' where id = 'hsr-lc-21011'; -- Encuentro planetario
update public.weapons set good_for = 'Cerydra.' where id = 'hsr-lc-23048'; -- Era grabada en sangre dorada
update public.weapons set good_for = 'Ideal para Jiaoqiu. También va bien con Pela, Sampo, Luka, Guinaifen y Black Swan.' where id = 'hsr-lc-23029'; -- Esas incontables primaveras
update public.weapons set good_for = 'Asta, Bronya, Tingyun, Yukong, Hanya, Ruan Mei, Sparkle (Hanabi) y Robin.' where id = 'hsr-lc-21032'; -- Esculpir la luna y tejer las nubes
update public.weapons set good_for = 'Trazacaminos (Exultación).' where id = 'hsr-lc-24006'; -- Exultación desbordante de bendiciones
update public.weapons set good_for = 'Huohuo y Gallagher.' where id = 'hsr-lc-22001'; -- Ey, estoy aquí
update public.weapons set good_for = 'Arlan y Blade.' where id = 'hsr-lc-20016'; -- Final mutuo
update public.weapons set good_for = 'Seele, Topaz y Numby y Dr. Ratio.' where id = 'hsr-lc-20007'; -- Flecha voladora
update public.weapons set good_for = 'Dan Heng.' where id = 'hsr-lc-20000'; -- Flechas
update public.weapons set good_for = 'Bailu, Luocha, Natasha y Lynx.' where id = 'hsr-lc-20008'; -- Fruto excelente
update public.weapons set good_for = 'Dan Heng, Seele, Sushang, Yanqing, Topaz y Numby, Feixiao y Moze.' where id = 'hsr-lc-21037'; -- Ganador final
update public.weapons set good_for = 'Mydei, Blade, Jingliu, Clara y Arlan.' where id = 'hsr-lc-22003'; -- Grabación ninja: Cacería del Sonido
update public.weapons set good_for = 'Ashveil, Dr. Ratio, Feixiao, Moze y Topaz y Numby.' where id = 'hsr-lc-22008'; -- Hacia el final del horizonte
update public.weapons set good_for = 'Ideal para The Herta (La Herta) y Argenti. También va bien con Anaxa, Himeko, Serval, Himeko (Nova) y Rin Tohsaka (Collab).' where id = 'hsr-lc-23037'; -- Hacia lo inescrutable
update public.weapons set good_for = 'Ideal para Boothill y March 7th (Imaginaria). También va bien con Sushang.' where id = 'hsr-lc-23027'; -- Hacia una segunda vida
update public.weapons set good_for = 'Huohuo, Bailu, Luocha, Lingsha, Gallagher, Lynx y Natasha.' where id = 'hsr-lc-21055'; -- Hasta pasado mañana
update public.weapons set good_for = 'Clara.' where id = 'hsr-lc-20009'; -- Hogar destrozado
update public.weapons set good_for = 'Herta, Himeko, Jing Yuan, Qingque, Serval, Argenti, Jade, Himeko (Nova) y Rin Tohsaka (Collab).' where id = 'hsr-lc-21034'; -- Hoy es otro día tranquilo
update public.weapons set good_for = 'Ideal para Ruan Mei, Trazacaminos (Imag.) y Yukong. También va bien con Asta, Tingyun, Hanya, Robin y Tribbie.' where id = 'hsr-lc-21004'; -- Imagen en el recuerdo
update public.weapons set good_for = 'Trazacaminos (Hielo) y Aglaea.' where id = 'hsr-lc-20021'; -- Imágenes quemadas
update public.weapons set good_for = 'Ideal para Archer (Collab). También va bien con Seele, Dr. Ratio y Sparkle (Hanabi).' where id = 'hsr-lc-23046'; -- Infierno donde arden los ideales
update public.weapons set good_for = 'Herta, Qingque, Serval y Argenti.' where id = 'hsr-lc-23018'; -- Instante grabado a fuego
update public.weapons set good_for = 'Bailu, Luocha, Natasha, Lynx y Gallagher.' where id = 'hsr-lc-21021'; -- Intercambio equivalente
update public.weapons set good_for = 'Dan Heng, Seele, Sushang, Yanqing, Topaz y Numby, Dr. Ratio, Boothill, March 7th (Imaginaria), Feixiao y Moze.' where id = 'hsr-lc-21010'; -- Juego de espadas
update public.weapons set good_for = 'Trazacaminos (Exultación), Yao Guang, Evanescia, Chispa (Sparxie) y Silver Wolf Lv.999.' where id = 'hsr-lc-22007'; -- Juntos hacia el futuro
update public.weapons set good_for = 'Arlan, Blade, Clara, Dan Heng (Imbibitor Lunae), Jingliu, Xueyi y Misha.' where id = 'hsr-lc-21012'; -- Juramento secreto
update public.weapons set good_for = 'Robin.' where id = 'hsr-lc-21046'; -- Juventud por florecer
update public.weapons set good_for = 'Ideal para Bronya, Tingyun y Asta. También va bien con Hanya, Ruan Mei, Sparkle (Hanabi), Robin, Trazacaminos (Imag.), Sunday y Yukong.' where id = 'hsr-lc-23003'; -- La batalla no ha terminado
update public.weapons set good_for = 'Yao Guang, Chispa (Sparxie), Silver Wolf Lv.999 y Evanescia.' where id = 'hsr-lc-21065'; -- La buena suerte de hoy
update public.weapons set good_for = 'Fu Xuan, Gepard, March 7th, Trazacaminos (Fuego) y Dan Heng (Permanser Terrae).' where id = 'hsr-lc-21009'; -- La elección de Landau
update public.weapons set good_for = 'Jade, Himeko, Herta y Jing Yuan.' where id = 'hsr-lc-23028'; -- La esperanza no tiene precio
update public.weapons set good_for = 'Hyacine y Robin (Summeretto).' where id = 'hsr-lc-21054'; -- La siguiente página de la historia
update public.weapons set good_for = 'Herta, Himeko, Jing Yuan, Qingque, Serval, Argenti y The Herta (La Herta).' where id = 'hsr-lc-21027'; -- La solemnidad del desayuno
update public.weapons set good_for = 'March 7th (Imaginaria) y Boothill.' where id = 'hsr-lc-21047'; -- La sombra de la noche
update public.weapons set good_for = 'Fu Xuan, Gepard, Trazacaminos (Fuego) y Dan Heng (Permanser Terrae).' where id = 'hsr-lc-24002'; -- La textura de los recuerdos
update public.weapons set good_for = 'Ideal para Anaxa. También va bien con Himeko (Nova) y Rin Tohsaka (Collab).' where id = 'hsr-lc-23041'; -- La vida en llamas
update public.weapons set good_for = 'Yao Guang, Silver Wolf Lv.999, Evanescia, Trazacaminos (Exultación) y Chispa (Sparxie).' where id = 'hsr-lc-21064'; -- Las aventuras de Champigaga
update public.weapons set good_for = 'Castorice y Evernight.' where id = 'hsr-lc-21057'; -- Las flores nunca olvidan
update public.weapons set good_for = 'Personajes DPS de la Exultación.' where id = 'hsr-lc-20024'; -- Las lágrimas que quedan
update public.weapons set good_for = 'Natasha, Lynx y Gallagher.' where id = 'hsr-lc-21028'; -- Las noches cálidas no duran
update public.weapons set good_for = 'Blade.' where id = 'hsr-lc-21038'; -- Lejos del fuego
update public.weapons set good_for = 'Robin (Summeretto).' where id = 'hsr-lc-23063'; -- Levántate y canta
update public.weapons set good_for = 'Jing Yuan, Serval y Argenti.' where id = 'hsr-lc-20013'; -- Llave maestra
update public.weapons set good_for = 'Ideal para Silver Wolf. También va bien con Kafka, Pela, Welt, Luka, Guinaifen, Black Swan, Acheron y Jiaoqiu.' where id = 'hsr-lc-23007'; -- Lluvia incesante
update public.weapons set good_for = 'Aventurino (Aventurine).' where id = 'hsr-lc-21039'; -- Los hilos del destino
update public.weapons set good_for = 'Arlan, Clara, Hook, Trazacaminos (Físico), Dan Heng (Imbibitor Lunae), Jingliu, Xueyi, Misha y Firefly (Sam).' where id = 'hsr-lc-21005'; -- Los Topos te dan la bienvenida
update public.weapons set good_for = 'Ideal para Robin. También va bien con Tingyun.' where id = 'hsr-lc-23026'; -- Luces de la noche
update public.weapons set good_for = 'Dan Heng (Imbibitor Lunae).' where id = 'hsr-lc-23015'; -- Más brillante que el sol
update public.weapons set good_for = 'Aglaea, Castorice y Evernight.' where id = 'hsr-lc-21052'; -- Más sudor y menos lágrimas
update public.weapons set good_for = 'Ideal para Feixiao. También va bien con Yanqing, Dr. Ratio, March 7th (Imaginaria) y Moze.' where id = 'hsr-lc-23031'; -- Me voy de caza
update public.weapons set good_for = 'Ideal para Cipher y Welt. También va bien con Jiaoqiu, Pela y Mortenax Blade.' where id = 'hsr-lc-23043'; -- Mentiras que vuelan en el viento
update public.weapons set good_for = 'Ruan Mei, Robin y Trazacaminos (Imag.).' where id = 'hsr-lc-23019'; -- Mi pasado en el espejo
update public.weapons set good_for = 'Gallagher y Lingsha.' where id = 'hsr-lc-21048'; -- Montaje de sueños
update public.weapons set good_for = 'Huohuo y Gallagher.' where id = 'hsr-lc-20015'; -- Multiplicación
update public.weapons set good_for = 'Ideal para Sparkle (Hanabi), Hanya y Bronya. También va bien con Tingyun y Sunday.' where id = 'hsr-lc-23021'; -- Mundo de juegos
update public.weapons set good_for = 'Ideal para La Dalia (The Dahlia). También va bien con Fugue (Tingyun 5⭐).' where id = 'hsr-lc-23050'; -- No olvides su fuego
update public.weapons set good_for = 'Herta, Himeko, Jing Yuan, Qingque, Serval, Argenti, Jade, The Herta (La Herta) e Himeko (Nova).' where id = 'hsr-lc-23000'; -- Noche en la Vía Láctea
update public.weapons set good_for = 'Ideal para Huohuo, Bailu, Natasha, Lynx, Blade y Gallagher. También va bien con Luocha y Lingsha.' where id = 'hsr-lc-23017'; -- Noche terrorífica
update public.weapons set good_for = 'Dr. Ratio, Feixiao, Yanqing, Topaz y Numby y Moze.' where id = 'hsr-lc-21062'; -- Nos vemos al final
update public.weapons set good_for = 'Mortenax Blade.' where id = 'hsr-lc-23059'; -- Nuevo cuerpo del averno ardiente
update public.weapons set good_for = 'Ideal para Blade. También va bien con Yunli, Clara y Arlan.' where id = 'hsr-lc-23009'; -- Orilla inalcanzable
update public.weapons set good_for = 'Robin.' where id = 'hsr-lc-22002'; -- Para el viaje de mañana
update public.weapons set good_for = 'Ideal para Rappa. También va bien con Serval.' where id = 'hsr-lc-23033'; -- Pergamino ninja: Azote deslumbrante del mal
update public.weapons set good_for = 'Ideal para Hysilens. También va bien con Kafka, Black Swan, Sampo, Guinaifen y Luka.' where id = 'hsr-lc-23047'; -- Por qué canta el océano
update public.weapons set good_for = 'Ideal para Topaz y Numby. También va bien con Dr. Ratio, Feixiao y Moze.' where id = 'hsr-lc-23016'; -- Preocupaciones y felicidad
update public.weapons set good_for = 'Xueyi, Misha y Firefly (Sam).' where id = 'hsr-lc-21042'; -- Promesa grabada
update public.weapons set good_for = 'Ideal para Phainon. También va bien con Clara, Yunli y Gilgamesh (Collab).' where id = 'hsr-lc-23044'; -- Que arda el alba
update public.weapons set good_for = 'Ideal para Hyacine. También va bien con Trazacaminos (Hielo) y Robin (Summeretto).' where id = 'hsr-lc-23042'; -- Que el arcoíris siempre esté en el cielo
update public.weapons set good_for = 'Argenti y Rappa.' where id = 'hsr-lc-21013'; -- Que el mundo clame
update public.weapons set good_for = 'Aventurino (Aventurine), Gepard, March 7th, Dan Heng (Permanser Terrae) y Trazacaminos (Fuego).' where id = 'hsr-lc-21053'; -- Que tu viaje sea siempre pacífico
update public.weapons set good_for = 'Ideal para Black Swan. También va bien con Kafka y Guinaifen.' where id = 'hsr-lc-23022'; -- Recuerdos reconstruidos
update public.weapons set good_for = 'Dan Heng, Topaz y Numby, Dr. Ratio y Moze.' where id = 'hsr-lc-21031'; -- Regreso a la oscuridad
update public.weapons set good_for = 'Aglaea.' where id = 'hsr-lc-20022'; -- Retrospección
update public.weapons set good_for = 'Yao Guang.' where id = 'hsr-lc-20023'; -- Risita burlona
update public.weapons set good_for = 'Asta, Bronya, Tingyun, Yukong, Hanya, Ruan Mei, Sparkle (Hanabi), Robin, Trazacaminos (Imag.) y Tribbie.' where id = 'hsr-lc-20012'; -- Rueda mecánica
update public.weapons set good_for = 'Herta, Jing Yuan y Argenti.' where id = 'hsr-lc-20020'; -- Sagacidad
update public.weapons set good_for = 'Aglaea.' where id = 'hsr-lc-21051'; -- Saludo entre genios
update public.weapons set good_for = 'Sampo, Luka, Guinaifen, Black Swan, Jiaoqiu y Fugue (Tingyun 5⭐).' where id = 'hsr-lc-24003'; -- Sanación solitaria
update public.weapons set good_for = 'Jingliu, Phainon, Mydei, Yunli, Misha, Xueyi y Gilgamesh (Collab).' where id = 'hsr-lc-21058'; -- Sangre del pasado
update public.weapons set good_for = 'Mydei, Blade, Arlan y Jingliu.' where id = 'hsr-lc-23039'; -- Sangre y fuego, abran camino
update public.weapons set good_for = 'Bailu, Luocha, Natasha, Lynx, Huohuo, Gallagher y Lingsha.' where id = 'hsr-lc-21007'; -- Sentimiento compartido
update public.weapons set good_for = 'Tribbie.' where id = 'hsr-lc-23038'; -- Si el tiempo fuera una flor
update public.weapons set good_for = 'Arlan, Blade, Clara, Trazacaminos (Físico), Dan Heng (Imbibitor Lunae), Jingliu, Xueyi, Misha, Firefly (Sam) y Yunli.' where id = 'hsr-lc-21033'; -- Sin escapatoria
update public.weapons set good_for = 'Ideal para Hook, Trazacaminos (Físico), Xueyi y Misha. También va bien con Arlan, Blade, Clara, Dan Heng (Imbibitor Lunae), Jingliu, Firefly (Sam), Yunli y Gilgamesh (Collab).' where id = 'hsr-lc-24000'; -- Sobre la caída de un Eón
update public.weapons set good_for = 'Trazacaminos (Hielo) y Robin (Summeretto).' where id = 'hsr-lc-24005'; -- Sobre los recuerdos nunca cae el telón
update public.weapons set good_for = 'Ideal para Kafka. También va bien con Guinaifen, Black Swan y Acheron.' where id = 'hsr-lc-23006'; -- Solo hay que esperar
update public.weapons set good_for = 'Lingsha, Gallagher y Luocha.' where id = 'hsr-lc-23032'; -- Solo la fragancia perdura
update public.weapons set good_for = 'Dan Heng, Seele, Sushang, Yanqing, Topaz y Numby, Dr. Ratio y March 7th (Imaginaria).' where id = 'hsr-lc-21003'; -- Solo queda silencio
update public.weapons set good_for = 'Pela, Sampo y Luka.' where id = 'hsr-lc-20018'; -- Sombra oculta
update public.weapons set good_for = 'Fu Xuan y Gepard.' where id = 'hsr-lc-21023'; -- Somos Llamarada
update public.weapons set good_for = 'Ideal para Gilgamesh (Collab). También va bien con Saber (Collab).' where id = 'hsr-lc-23062'; -- Soy lo que ves
update public.weapons set good_for = 'Jade, Himeko, Jing Yuan y Herta.' where id = 'hsr-lc-21060'; -- Sueños de trigo fragante
update public.weapons set good_for = 'Acheron y Welt.' where id = 'hsr-lc-21044'; -- Tango ilimitado
update public.weapons set good_for = 'Gepard, March 7th, Trazacaminos (Fuego) y Aventurino (Aventurine).' where id = 'hsr-lc-21016'; -- Tendencias del mercado universal
update public.weapons set good_for = 'Aglaea.' where id = 'hsr-lc-23036'; -- Tiempo urdido en oro
update public.weapons set good_for = 'Himeko y Rappa.' where id = 'hsr-lc-21045'; -- Tras el silencio de La Armonía
update public.weapons set good_for = 'Chispa (Sparxie), Silver Wolf Lv.999 y Evanescia.' where id = 'hsr-lc-21066'; -- Un breve descanso
update public.weapons set good_for = 'Cipher, Silver Wolf, Pela, Jiaoqiu, La Dalia (The Dahlia), Fugue (Tingyun 5⭐) y Mortenax Blade.' where id = 'hsr-lc-21061'; -- Vacaciones en las termas
update public.weapons set good_for = 'Pela, Sampo, Silver Wolf y Welt.' where id = 'hsr-lc-20004'; -- Vacío
update public.weapons set good_for = 'Robin y Tingyun.' where id = 'hsr-lc-22005'; -- Viandas sin fin
update public.weapons set good_for = 'Trazacaminos (Hielo) y Aglaea.' where id = 'hsr-lc-21050'; -- Victoria disputada
update public.weapons set good_for = 'Kafka, Sampo, Luka, Guinaifen, Black Swan y Jiaoqiu.' where id = 'hsr-lc-21008'; -- Visión de presa
update public.weapons set good_for = 'Trazacaminos (Hielo).' where id = 'hsr-lc-22006'; -- Volando hacia un mañana rosado
update public.weapons set good_for = 'Pela, Silver Wolf, Welt y Luka.' where id = 'hsr-lc-21029'; -- Volveremos a encontrarnos
update public.weapons set good_for = 'Ideal para Fu Xuan. También va bien con Trazacaminos (Fuego) y Dan Heng (Permanser Terrae).' where id = 'hsr-lc-23011'; -- Ya ha cerrado los ojos
update public.weapons set good_for = 'Jingliu.' where id = 'hsr-lc-23014'; -- Yo seré mi propia espada

-- Genshin Impact (armas): 246
update public.weapons set good_for = 'Sobre todo para Klee, Trotamundos (Wanderer), Yanfei y Wriothesley. También va bien con Lisa, Ningguang, Yae Miko, Shikanoin Heizou, Varesa y Nefer.' where id = 'gi-w-14408'; -- Ágata del Peñasco Oscuro
update public.weapons set good_for = 'Amber, Fischl, Tartaglia (Childe), Ganyu, Yoimiya, Kujou Sara, Aloy, Lyney, Tignari (Tighnari), Collei y Sethos.' where id = 'gi-w-15509'; -- Agitador del Relámpago
update public.weapons set good_for = 'Xiao y Rosaria.' where id = 'gi-w-13302'; -- Alabarda
update public.weapons set good_for = 'Cyno, Shenhe, Xiangling, Rosaria y Thoma.' where id = 'gi-w-13419'; -- Alabarda del Viento Epistolar
update public.weapons set good_for = 'Sobre todo para Amber, Fischl y Kujou Sara. También va bien con Venti (Arconte Anemo), Tartaglia (Childe), Ganyu, Yoimiya, Aloy, Lyney, Yelan, Tignari (Tighnari), Collei, Faruzán y Linnea.' where id = 'gi-w-15501'; -- Alas Celestiales
update public.weapons set good_for = 'Clorinde, Skirk, Keqing, Bennett, Kaeya y Jean.' where id = 'gi-w-11434'; -- Alba de la Tejelunas
update public.weapons set good_for = 'Chasca, Ganyu, Lyney, Tartaglia (Childe), Tignari (Tighnari), Venti (Arconte Anemo), Yelan, Yoimiya, Fischl, Jahoda, Ororon, Kujou Sara y Sethos.' where id = 'gi-w-15515'; -- Albores de la Historia
update public.weapons set good_for = 'Xiangling, Zhongli (Arconte Geo), Rosaria, Thoma, Shogun Raiden (Arconte), Iansán, Shenhe, Candace, Chevreuse y Flins.' where id = 'gi-w-13416'; -- Aleta Cortaolas
update public.weapons set good_for = 'Lisa, Mona, Yae Miko, Sangonomiya Kokomi, Baizhu, Xianyun (Preservadora) y Varesa.' where id = 'gi-w-14414'; -- Anillo de Hakushin
update public.weapons set good_for = 'Mualani, Sangonomiya Kokomi y Bárbara.' where id = 'gi-w-14431'; -- Anillo del Yaxché
update public.weapons set good_for = 'Solo sirve al principio del juego, hasta que consigas un arma de 3★ o más del mismo tipo. Después úsala como material para mejorar otras armas.' where id = 'gi-w-14101'; -- Apuntes del Aprendiz
update public.weapons set good_for = 'Amber, Venti (Arconte Anemo), Fischl, Tartaglia (Childe), Ganyu, Yoimiya, Aloy, Lyney, Yelan, Tignari (Tighnari), Collei, Sigewinne, Sethos, Chasca, Ororon, Jahoda y Linnea.' where id = 'gi-w-15508'; -- Aqua Simulacra
update public.weapons set good_for = 'Sobre todo para Jean, Bennett y Qiqi. También va bien con Keqing y Odette.' where id = 'gi-w-11501'; -- Aquila Favonia
update public.weapons set good_for = 'Fischl.' where id = 'gi-w-15407'; -- Arco Compuesto
update public.weapons set good_for = 'Sobre todo para Ganyu y Tignari (Tighnari). También va bien con Lyney, Tartaglia (Childe), Yoimiya, Amber, Fischl y Ororon.' where id = 'gi-w-15502'; -- Arco de Amos
update public.weapons set good_for = 'Tartaglia (Childe).' where id = 'gi-w-15301'; -- Arco de Cuervo
update public.weapons set good_for = 'Fischl, Venti (Arconte Anemo), Diona, Kujou Sara, Gorou, Yelan, Collei, Faruzán, Amber, Sigewinne, Ororon, Jahoda y Linnea.' where id = 'gi-w-15401'; -- Arco de Favonius
update public.weapons set good_for = 'Ganyu, Lyney, Tartaglia (Childe), Tignari (Tighnari), Yelan, Yoimiya y Fischl.' where id = 'gi-w-15409'; -- Arco de la Cazadora Esmeralda
update public.weapons set good_for = 'Solo sirve al principio del juego, hasta que consigas un arma de 3★ o más del mismo tipo. Después úsala como material para mejorar otras armas.' where id = 'gi-w-15101'; -- Arco del Cazador
update public.weapons set good_for = 'Solo sirve al principio del juego, hasta que consigas un arma de 3★ o más del mismo tipo. Después úsala como material para mejorar otras armas.' where id = 'gi-w-15201'; -- Arco del Cazador Estacional
update public.weapons set good_for = 'Sobre todo para Tartaglia (Childe) y Ganyu. También va bien con Amber, Venti (Arconte Anemo), Fischl, Yoimiya, Aloy, Lyney, Sethos y Chasca.' where id = 'gi-w-15408'; -- Arco del Peñasco Oscuro
update public.weapons set good_for = 'Fischl, Diona, Kujou Sara, Gorou, Yelan, Faruzán, Sigewinne, Ororon y Jahoda.' where id = 'gi-w-15403'; -- Arco del Sacrificio
update public.weapons set good_for = 'Venti (Arconte Anemo), Fischl, Tartaglia (Childe), Yoimiya, Kujou Sara, Aloy, Lyney, Chasca y Ororon.' where id = 'gi-w-15404'; -- Arco Real
update public.weapons set good_for = 'Diona, Yelan y Sigewinne.' where id = 'gi-w-15303'; -- Arco Recurvo
update public.weapons set good_for = 'Razor, Xinyan, Eula y Fréminet.' where id = 'gi-w-12411'; -- Argento Estelar de las Nieves
update public.weapons set good_for = 'Beidou, Chongyun, Sayu, Dori, Dehya, Kaveh, Gaming y Kinich.' where id = 'gi-w-12414'; -- Asesinato de Katsuragi
update public.weapons set good_for = 'Albedo, Alhacén (Alhaitham), Kamisato Ayaka, Kamisato Ayato, Clorinde, Durin, Jean, Keqing, Qiqi, Skirk, Bennett y Xingchiu (Xingqiu).' where id = 'gi-w-11518'; -- Athame Artis
update public.weapons set good_for = 'Trotamundos (Wanderer), Yae Miko, Nahida (Arconte Dendro), Varesa, Lisa, Ningguang, Yanfei y Charlotte.' where id = 'gi-w-14509'; -- Axioma de la Kagura
update public.weapons set good_for = 'Flins, Ineffa, Iansán, Shogun Raiden (Arconte) y Cyno.' where id = 'gi-w-13433'; -- Azada Excavatesoros
update public.weapons set good_for = 'Sobre todo para Hu Tao, Xiao, Zhongli (Arconte Geo) y Candace. También va bien con Cyno, Emilie, Shogun Raiden (Arconte), Rosaria, Xiangling y Yaoyao.' where id = 'gi-w-13501'; -- Báculo de Homa
update public.weapons set good_for = 'Sobre todo para Hu Tao y Cyno. También va bien con Xiangling, Rosaria, Arlecchino, Candace, Yaoyao, Emilie, Chevreuse, Ineffa y Flins.' where id = 'gi-w-13511'; -- Báculo de las Arenas Escarlatas
update public.weapons set good_for = 'Ineffa, Flins, Escoffier, Emilie, Cyno, Arlecchino y Candace.' where id = 'gi-w-13434'; -- Báculo Rutilante de la Sacerdotisa
update public.weapons set good_for = 'Alyosha.' where id = 'gi-w-13436'; -- Balada de la Custodia
update public.weapons set good_for = 'Cyno, Hu Tao, Shogun Raiden (Arconte), Thoma y Xiangling.' where id = 'gi-w-13424'; -- Balada de los Fiordos
update public.weapons set good_for = 'Xiao, Hu Tao, Rosaria, Cyno, Arlecchino y Flins.' where id = 'gi-w-13301'; -- Borla Blanca
update public.weapons set good_for = 'Thoma, Yaoyao, Mika, Zhongli (Arconte Geo) y Chevreuse.' where id = 'gi-w-13303'; -- Borla Negra
update public.weapons set good_for = 'Sigewinne, Yelan y Diona.' where id = 'gi-w-15432'; -- Cadencia de la Soledad
update public.weapons set good_for = 'Clorinde, Kamisato Ayato, Kamisato Ayaka y Keqing.' where id = 'gi-w-11432'; -- Calamidad de Eshu
update public.weapons set good_for = 'Klee, Ningguang, Yanfei, Yae Miko, Shikanoin Heizou, Xianyun (Preservadora) y Lan Yan.' where id = 'gi-w-14504'; -- Candado Terrenal
update public.weapons set good_for = 'Varka, Navia, Mavuika (Arconte Pyro), Kinich, Eula, Diluc, Dehya, Razor, Gaming, Fréminet, Chongyun y Beidou.' where id = 'gi-w-12515'; -- Cantar de Gesta del Lobo
update public.weapons set good_for = 'Lisa, Klee, Sacarosa (Sucrose), Mona, Ningguang, Trotamundos (Wanderer), Yae Miko, Shikanoin Heizou, Baizhu, Nahida (Arconte Dendro), Citlalí, Ifa, Mizuki, Varesa y Lauma.' where id = 'gi-w-14407'; -- Carta Náutica
update public.weapons set good_for = 'Aloy, Venti (Arconte Anemo), Collei, Faruzán, Fischl y Kujou Sara.' where id = 'gi-w-15410'; -- Cazador del Callejón
update public.weapons set good_for = 'Baizhu, Sangonomiya Kokomi y Bárbara.' where id = 'gi-w-14505'; -- Centelleo Jadecaído
update public.weapons set good_for = 'Sobre todo para Shenhe, Shogun Raiden (Arconte) y Xiangling. También va bien con Thoma, Rosaria y Xiao.' where id = 'gi-w-13432'; -- Charla en el Pabellón
update public.weapons set good_for = 'Klee, Nefer, Neuvillette, Trotamundos (Wanderer), Wriothesley y Yanfei.' where id = 'gi-w-14435'; -- Choque de Reyes
update public.weapons set good_for = 'Sobre todo para Sethos.' where id = 'gi-w-15426'; -- Cimentador de Nubes
update public.weapons set good_for = 'Keqing, Alhacén (Alhaitham) y Clorinde.' where id = 'gi-w-11512'; -- Clorofilo Refulgente
update public.weapons set good_for = 'Mona, Lisa, Bárbara, Sacarosa (Sucrose), Yanfei, Yae Miko, Baizhu, Charlotte, Xianyun (Preservadora), Citlalí, Lan Yan, Columbina y Nicole.' where id = 'gi-w-14401'; -- Códice de Favonius
update public.weapons set good_for = 'Kinich, Gaming, Dehya y Diluc.' where id = 'gi-w-12513'; -- Colmillo del Rey de la Montaña
update public.weapons set good_for = 'Albedo, Alhacén (Alhaitham), Kamisato Ayato, Furina, Keqing, Viajero (Traveler), Kaeya y Xingchiu (Xingqiu).' where id = 'gi-w-11424'; -- Colmillo Lupino
update public.weapons set good_for = 'Sigewinne, Yelan y Diona.' where id = 'gi-w-15513'; -- Corazón de la Lluvia
update public.weapons set good_for = 'Viajero (Traveler), Jean, Kaeya, Bennett, Xingchiu (Xingqiu), Qiqi, Keqing, Albedo, Kamisato Ayaka, Kaedehara Kazuha, Skirk, Lynette, Kamisato Ayato, Kuki Shinobu, Alhacén (Alhaitham), Nilou, Laila (Layla), Furina, Clorinde, Chiori, Dahlia y Durin.' where id = 'gi-w-11505'; -- Cortador de Jade Primordial
update public.weapons set good_for = 'Zibai, Xilonen, Chiori, Clorinde, Alhacén (Alhaitham), Skirk y Albedo.' where id = 'gi-w-11514'; -- Cortatelones de Urakusai
update public.weapons set good_for = 'Xiangling, Cyno, Thoma, Shogun Raiden (Arconte), Mika, Yaoyao, Emilie, Chevreuse, Escoffier, Ineffa y Flins.' where id = 'gi-w-13414'; -- Cruz de Kitain
update public.weapons set good_for = 'Mona, Sacarosa (Sucrose), Lisa, Bárbara, Sangonomiya Kokomi, Yanfei, Ningguang, Baizhu, Neuvillette, Xianyun (Preservadora), Citlalí, Lan Yan y Nicole.' where id = 'gi-w-14302'; -- Cuentos de Cazadores de Dragones
update public.weapons set good_for = 'Klee, Ningguang, Trotamundos (Wanderer), Yanfei, Wriothesley y Xianyun (Preservadora).' where id = 'gi-w-14413'; -- Cuentos de Dodoco
update public.weapons set good_for = 'Mualani, Sangonomiya Kokomi y Bárbara.' where id = 'gi-w-14427'; -- Cuerno Veteazulado
update public.weapons set good_for = 'Sobre todo para Aloy y Ganyu.' where id = 'gi-w-15415'; -- Depredador
update public.weapons set good_for = 'Arlecchino, Cyno, Flins, Lohen y Shogun Raiden (Arconte).' where id = 'gi-w-13517'; -- Desastre y Arrepentimiento
update public.weapons set good_for = 'Sobre todo para Lyney y Tignari (Tighnari). También va bien con Ganyu, Tartaglia (Childe), Amber y Sethos.' where id = 'gi-w-15424'; -- Descendientes del Sol Abrasador
update public.weapons set good_for = 'Viajero (Traveler), Jean, Kaeya, Xingchiu (Xingqiu), Albedo, Kuki Shinobu, Laila (Layla), Kirara, Furina, Chiori y Dahlia.' where id = 'gi-w-11413'; -- Deseo Ponzoñoso
update public.weapons set good_for = 'Sobre todo para Jean, Kaedehara Kazuha, Qiqi, Bennett, Kirara y Kuki Shinobu.' where id = 'gi-w-11410'; -- Destello en la Oscuridad
update public.weapons set good_for = 'Venti (Arconte Anemo), Fischl, Kujou Sara, Gorou, Yelan, Faruzán y Sigewinne.' where id = 'gi-w-15411'; -- Desvanecimiento del Crepúsculo
update public.weapons set good_for = 'Alhacén (Alhaitham), Kaedehara Kazuha, Keqing, Nilou, Viajero (Traveler) y Kuki Shinobu.' where id = 'gi-w-11422'; -- Diluvio Florífero
update public.weapons set good_for = 'Zhongli (Arconte Geo), Mika, Yaoyao y Chevreuse.' where id = 'gi-w-13426'; -- Discusión de los Sabios del Desierto
update public.weapons set good_for = 'Mizuki y Yae Miko.' where id = 'gi-w-14436'; -- Eco del Corazón
update public.weapons set good_for = 'Tignari (Tighnari), Lyney, Ganyu, Tartaglia (Childe) y Amber.' where id = 'gi-w-15512'; -- El Primer Gran Número de Magia
update public.weapons set good_for = 'Venti (Arconte Anemo), Yelan, Amber, Collei, Diona, Faruzán, Fischl, Gorou y Kujou Sara.' where id = 'gi-w-15503'; -- Elegía del Fin
update public.weapons set good_for = 'Emilie y Xiangling.' where id = 'gi-w-13513'; -- Elegía Lumidulce
update public.weapons set good_for = 'Mavuika (Arconte Pyro), Kinich, Navia, Dehya, Eula, Diluc, Gaming, Fréminet, Kaveh, Dori, Sayu, Xinyan, Chongyun, Beidou, Noelle y Razor.' where id = 'gi-w-12511'; -- Emblema del Mar de Juncos
update public.weapons set good_for = 'Wriothesley, Trotamundos (Wanderer), Neuvillette, Nefer y Klee.' where id = 'gi-w-14434'; -- Escarcha del Albor
update public.weapons set good_for = 'Sobre todo para Neuvillette.' where id = 'gi-w-14514'; -- Escrituras del Fluir Sempiterno
update public.weapons set good_for = 'Kamisato Ayaka, Kamisato Ayato, Jean, Keqing, Qiqi, Viajero (Traveler), Kaeya y Xingchiu (Xingqiu).' where id = 'gi-w-11414'; -- Espada Amenoma Gemela
update public.weapons set good_for = 'Kamisato Ayaka, Kamisato Ayato, Jean, Kaedehara Kazuha, Qiqi, Viajero (Traveler), Bennett, Kaeya y Xingchiu (Xingqiu).' where id = 'gi-w-11428'; -- Espada Cruz de los Narcisos
update public.weapons set good_for = 'Furina, Jean, Kaedehara Kazuha, Nilou, Qiqi, Viajero (Traveler), Bennett, Kaeya, Kirara, Laila (Layla), Lynette, Kuki Shinobu y Xingchiu (Xingqiu).' where id = 'gi-w-11401'; -- Espada de Favonius
update public.weapons set good_for = 'Sobre todo para Arataki Itto y Noelle.' where id = 'gi-w-12303'; -- Espada de Hierro Blanco
update public.weapons set good_for = 'Alhacén (Alhaitham), Keqing, Viajero (Traveler), Kirara y Kuki Shinobu.' where id = 'gi-w-11304'; -- Espada de Hierro Oscuro
update public.weapons set good_for = 'Diluc, Noelle, Beidou, Xinyan, Eula, Arataki Itto, Navia, Gaming y Mavuika (Arconte Pyro).' where id = 'gi-w-12504'; -- Espada de la Desidia
update public.weapons set good_for = 'Bennett, Lynette, Kuki Shinobu, Viajero (Traveler), Nilou y Kirara.' where id = 'gi-w-11417'; -- Espada de Madera
update public.weapons set good_for = 'Jean, Kaedehara Kazuha, Nilou, Qiqi, Viajero (Traveler), Bennett, Kaeya, Kirara, Laila (Layla) y Xingchiu (Xingqiu).' where id = 'gi-w-11403'; -- Espada de Sacrificio
update public.weapons set good_for = 'Albedo, Kaeya, Xingchiu (Xingqiu), Laila (Layla), Alhacén (Alhaitham), Chiori, Clorinde, Viajero (Traveler), Kamisato Ayaka, Skirk y Zibai.' where id = 'gi-w-11302'; -- Espada del Alba
update public.weapons set good_for = 'Viajero (Traveler).' where id = 'gi-w-11412'; -- Espada del Descenso
update public.weapons set good_for = 'Solo sirve al principio del juego, hasta que consigas un arma de 3★ o más del mismo tipo. Después úsala como material para mejorar otras armas.' where id = 'gi-w-12201'; -- Espada del Mercenario
update public.weapons set good_for = 'Dehya, Beidou y Dori.' where id = 'gi-w-12402'; -- Espada del Tiempo
update public.weapons set good_for = 'Albedo, Chiori y Xilonen.' where id = 'gi-w-11303'; -- Espada del Viajero
update public.weapons set good_for = 'Jean, Kaeya, Xingchiu (Xingqiu), Keqing, Kamisato Ayaka, Kamisato Ayato, Alhacén (Alhaitham), Clorinde y Viajero (Traveler).' where id = 'gi-w-11408'; -- Espada Larga del Peñasco Oscuro
update public.weapons set good_for = 'Gaming, Eula, Xinyan, Beidou y Diluc.' where id = 'gi-w-12410'; -- Espada Lítica
update public.weapons set good_for = 'Viajero (Traveler), Kaeya, Keqing, Kamisato Ayaka, Skirk, Kamisato Ayato, Alhacén (Alhaitham) y Clorinde.' where id = 'gi-w-11409'; -- Espada Negra
update public.weapons set good_for = 'Solo sirve al principio del juego, hasta que consigas un arma de 3★ o más del mismo tipo. Después úsala como material para mejorar otras armas.' where id = 'gi-w-11201'; -- Espada Plateada
update public.weapons set good_for = 'Sobre todo para Dori y Dehya. También va bien con Sayu y Kaveh.' where id = 'gi-w-12417'; -- Espada Real del Bosque
update public.weapons set good_for = 'Sobre todo para Qiqi y Jean. También va bien con Viajero (Traveler), Kaeya, Xingchiu (Xingqiu), Keqing y Kamisato Ayato.' where id = 'gi-w-11404'; -- Espada Real Larga
update public.weapons set good_for = 'Jean, Qiqi, Bennett, Laila (Layla), Lynette y Xingchiu (Xingqiu).' where id = 'gi-w-11306'; -- Espada Surcacielos
update public.weapons set good_for = 'Diluc, Razor, Noelle, Xinyan, Arataki Itto, Dehya y Gaming.' where id = 'gi-w-12510'; -- Espadón Cornirrojo
update public.weapons set good_for = 'Sangonomiya Kokomi, Lauma, Mona y Nahida (Arconte Dendro).' where id = 'gi-w-14520'; -- Espejo Tejenoches
update public.weapons set good_for = 'Viajero (Traveler), Jean, Kaeya, Xingchiu (Xingqiu), Kaedehara Kazuha, Lynette, Kuki Shinobu, Alhacén (Alhaitham), Nilou y Kirara.' where id = 'gi-w-11407'; -- Espina de Hierro
update public.weapons set good_for = 'Kachina y Yun Jin.' where id = 'gi-w-13431'; -- Estela Iridiscente
update public.weapons set good_for = 'Yae Miko, Sangonomiya Kokomi, Nahida (Arconte Dendro), Citlalí, Lisa, Bárbara, Sacarosa (Sucrose) y Shikanoin Heizou.' where id = 'gi-w-14416'; -- Estrella Errabunda
update public.weapons set good_for = 'Venti (Arconte Anemo), Fischl, Tartaglia (Childe), Ganyu, Yoimiya, Kujou Sara, Aloy, Lyney, Tignari (Tighnari), Collei, Sigewinne, Sethos, Chasca, Ororon y Linnea.' where id = 'gi-w-15507'; -- Estrella Invernal
update public.weapons set good_for = 'Sobre todo para Clorinde.' where id = 'gi-w-11515'; -- Expiadora
update public.weapons set good_for = 'Dehya, Diluc, Sandrone, Beidou, Razor y Sayu.' where id = 'gi-w-12418'; -- Fierro Floriorlado
update public.weapons set good_for = 'Alhacén (Alhaitham), Clorinde, Keqing, Odette y Lynette.' where id = 'gi-w-11435'; -- Filo de la Caza de los Herejes
update public.weapons set good_for = 'Venti (Arconte Anemo), Fischl, Ganyu, Yelan, Collei y Faruzán.' where id = 'gi-w-15418'; -- Fin de las Aguas
update public.weapons set good_for = 'Keqing y Qiqi.' where id = 'gi-w-11402'; -- Flauta
update public.weapons set good_for = 'Zibai, Xilonen, Chiori y Albedo.' where id = 'gi-w-11431'; -- Flauta de Ezpitzal
update public.weapons set good_for = 'Klee, Mona, Trotamundos (Wanderer), Wriothesley, Yae Miko, Shikanoin Heizou, Ningguang y Yanfei.' where id = 'gi-w-14425'; -- Fluencia Impoluta
update public.weapons set good_for = 'Klee, Yanfei, Wriothesley, Lan Yan y Varesa.' where id = 'gi-w-14412'; -- Frío Eterno
update public.weapons set good_for = 'Lisa, Mona y Yae Miko.' where id = 'gi-w-14417'; -- Fruto de la Culminación
update public.weapons set good_for = 'Odette, Qiqi y Viajero (Traveler).' where id = 'gi-w-11436'; -- Fuente de Ignición
update public.weapons set good_for = 'Sobre todo para Skirk.' where id = 'gi-w-11517'; -- Fulgor Cerúleo
update public.weapons set good_for = 'Sobre todo para Furina.' where id = 'gi-w-11513'; -- Fulgor de las Aguas Calmas
update public.weapons set good_for = 'Diluc, Gaming, Kaveh y Noelle.' where id = 'gi-w-12430'; -- Gancho del Triunfo
update public.weapons set good_for = 'Ororon, Sethos, Collei, Tignari (Tighnari), Diona y Venti (Arconte Anemo).' where id = 'gi-w-15433'; -- Gancho Trampero
update public.weapons set good_for = 'Noelle, Xinyan y Eula.' where id = 'gi-w-12305'; -- Garrote del Debate
update public.weapons set good_for = 'Sobre todo para Razor. También va bien con Mavuika (Arconte Pyro), Navia, Dehya, Diluc, Gaming, Kaveh, Chongyun y Beidou.' where id = 'gi-w-12424'; -- Garrote del Diálogo
update public.weapons set good_for = 'Noelle, Beidou, Chongyun, Sayu, Dori, Dehya y Kaveh.' where id = 'gi-w-12401'; -- Gran Espada de Favonius
update public.weapons set good_for = 'Xinyan, Beidou, Chongyun, Sayu, Kaveh y Aino.' where id = 'gi-w-12403'; -- Gran Espada de Sacrificio
update public.weapons set good_for = 'Solo sirve al principio del juego, hasta que consigas un arma de 3★ o más del mismo tipo. Después úsala como material para mejorar otras armas.' where id = 'gi-w-12101'; -- Gran Espada del Guerrero
update public.weapons set good_for = 'Sobre todo para Sayu. También va bien con Diluc, Beidou, Xinyan, Eula y Fréminet.' where id = 'gi-w-12404'; -- Gran Espada Real
update public.weapons set good_for = 'Dehya, Diluc, Beidou, Dori, Razor y Sayu.' where id = 'gi-w-12302'; -- Gran Espada Sangrienta
update public.weapons set good_for = 'Xinyan y Eula.' where id = 'gi-w-12306'; -- Gran Espada Surcacielos
update public.weapons set good_for = 'Sobre todo para Diluc. También va bien con Beidou, Eula, Arataki Itto, Navia, Fréminet, Kinich y Mavuika (Arconte Pyro).' where id = 'gi-w-12408'; -- Gran Hoja del Peñasco Oscuro
update public.weapons set good_for = 'Solo sirve al principio del juego, hasta que consigas un arma de 3★ o más del mismo tipo. Después úsala como material para mejorar otras armas.' where id = 'gi-w-14201'; -- Grimorio de Bolsillo
update public.weapons set good_for = 'Lisa, Klee, Ningguang, Yanfei, Yae Miko, Shikanoin Heizou, Charlotte, Wriothesley y Xianyun (Preservadora).' where id = 'gi-w-14404'; -- Grimorio Real
update public.weapons set good_for = 'Klee, Nahida (Arconte Dendro), Yae Miko, Lisa, Sacarosa (Sucrose) y Yanfei.' where id = 'gi-w-14301'; -- Guía Mágica
update public.weapons set good_for = 'Cyno, Hu Tao, Shogun Raiden (Arconte) y Xiao.' where id = 'gi-w-13505'; -- Halcón de Jade
update public.weapons set good_for = 'Escoffier, Ineffa, Shenhe y Xiangling.' where id = 'gi-w-13435'; -- Hálito Glacial
update public.weapons set good_for = 'Ineffa.' where id = 'gi-w-13515'; -- Halo Fracturado
update public.weapons set good_for = 'Nicole y Lan Yan.' where id = 'gi-w-14523'; -- Heptadas de los Ángeles
update public.weapons set good_for = 'Sobre todo para Tartaglia (Childe) y Yoimiya. También va bien con Fischl y Aloy.' where id = 'gi-w-15405'; -- Herrumbre
update public.weapons set good_for = 'Mizuki, Lan Yan y Sacarosa (Sucrose).' where id = 'gi-w-14518'; -- Hibernación Matutina de Año Nuevo
update public.weapons set good_for = 'Xilonen, Chiori y Albedo.' where id = 'gi-w-11516'; -- Himno de las Cumbres
update public.weapons set good_for = 'Baizhu, Sangonomiya Kokomi, Bárbara, Charlotte, Lisa y Sacarosa (Sucrose).' where id = 'gi-w-14303'; -- Historias de Otros Mundos
update public.weapons set good_for = 'Sobre todo para Jean, Kaeya, Bennett, Kaedehara Kazuha y Furina. También va bien con Viajero (Traveler), Xingchiu (Xingqiu), Qiqi, Lynette, Kamisato Ayato, Laila (Layla), Xilonen y Dahlia.' where id = 'gi-w-11502'; -- Hoja Afilada Celestial
update public.weapons set good_for = 'Viajero (Traveler).' where id = 'gi-w-11521'; -- Hoja de Exáifanes
update public.weapons set good_for = 'Viajero (Traveler), Jean, Kaeya, Qiqi, Keqing, Kamisato Ayaka y Kamisato Ayato.' where id = 'gi-w-11305'; -- Hoja de Filetear
update public.weapons set good_for = 'Solo sirve al principio del juego, hasta que consigas un arma de 3★ o más del mismo tipo. Después úsala como material para mejorar otras armas.' where id = 'gi-w-11101'; -- Hoja Desafilada
update public.weapons set good_for = 'Kaeya y Xingchiu (Xingqiu).' where id = 'gi-w-11301'; -- Hoja Fría
update public.weapons set good_for = 'Mualani.' where id = 'gi-w-14516'; -- Hora de Surfear
update public.weapons set good_for = 'Kamisato Ayaka, Keqing y Kaeya.' where id = 'gi-w-11430'; -- Hueso Recio
update public.weapons set good_for = 'Xilonen, Chiori y Albedo.' where id = 'gi-w-11415'; -- Huso de Cinabrio
update public.weapons set good_for = 'Sobre todo para Baizhu. También va bien con Nahida (Arconte Dendro), Neuvillette, Yae Miko, Lisa y Sacarosa (Sucrose).' where id = 'gi-w-14424'; -- Jade Sacrificial
update public.weapons set good_for = 'Linnea y Gorou.' where id = 'gi-w-15436'; -- Juramento de la Escarcha
update public.weapons set good_for = 'Ganyu, Lyney y Tignari (Tighnari).' where id = 'gi-w-15302'; -- Juramento del Arquero
update public.weapons set good_for = 'Viajero (Traveler), Jean, Kaeya, Bennett, Albedo, Kaedehara Kazuha, Lynette, Kuki Shinobu, Nilou, Laila (Layla), Kirara, Xilonen y Durin.' where id = 'gi-w-11503'; -- Juramento por la Libertad
update public.weapons set good_for = 'Kaeya, Keqing, Kamisato Ayaka, Kaedehara Kazuha, Kamisato Ayato y Alhacén (Alhaitham).' where id = 'gi-w-11416'; -- Kagotsurube Isshin
update public.weapons set good_for = 'Shogun Raiden (Arconte), Shenhe, Zhongli (Arconte Geo), Candace, Rosaria, Thoma, Xiangling, Yaoyao y Yun Jin.' where id = 'gi-w-13415'; -- La Captura
update public.weapons set good_for = 'Lauma, Mualani, Nahida (Arconte Dendro), Baizhu, Sangonomiya Kokomi y Mona.' where id = 'gi-w-14433'; -- Lámpara Medulaoscura
update public.weapons set good_for = 'Xiao, Xiangling, Hu Tao, Cyno y Shenhe.' where id = 'gi-w-13408'; -- Lanza de Caza Real
update public.weapons set good_for = 'Sobre todo para Rosaria.' where id = 'gi-w-13409'; -- Lanza de Espinadragón
update public.weapons set good_for = 'Xiangling, Xiao, Shogun Raiden (Arconte), Thoma, Shenhe, Yun Jin, Candace, Yaoyao, Mika, Zhongli (Arconte Geo), Chevreuse, Rosaria, Kachina, Iansán, Escoffier, Ineffa y Alyosha.' where id = 'gi-w-13407'; -- Lanza de Favonius
update public.weapons set good_for = 'Xiao, Xiangling, Hu Tao, Cyno, Shogun Raiden (Arconte), Yun Jin, Arlecchino, Candace, Emilie, Kachina, Escoffier, Ineffa y Flins.' where id = 'gi-w-13405'; -- Lanza del Duelo
update public.weapons set good_for = 'Sobre todo para Xiao. También va bien con Xiangling, Hu Tao, Rosaria, Cyno, Arlecchino, Emilie y Flins.' where id = 'gi-w-13404'; -- Lanza del Peñasco Oscuro
update public.weapons set good_for = 'Solo sirve al principio del juego, hasta que consigas un arma de 3★ o más del mismo tipo. Después úsala como material para mejorar otras armas.' where id = 'gi-w-13101'; -- Lanza del Principiante
update public.weapons set good_for = 'Xiao, Xiangling, Shenhe y Mika.' where id = 'gi-w-13406'; -- Lanza Lítica
update public.weapons set good_for = 'Rosaria, Iansán, Shenhe, Yun Jin, Kachina e Ineffa.' where id = 'gi-w-13504'; -- Lanza Perforanubes
update public.weapons set good_for = 'Sobre todo para Eula y Sayu. También va bien con Diluc, Razor, Beidou, Chongyun, Xinyan, Dori, Sandrone, Dehya, Navia, Fréminet, Gaming y Mavuika (Arconte Pyro).' where id = 'gi-w-12502'; -- Lápida del Lobo
update public.weapons set good_for = 'Lauma, Mizuki, Ifa, Citlalí, Nahida (Arconte Dendro), Yae Miko y Sacarosa (Sucrose).' where id = 'gi-w-14432'; -- Laúd de la Luz Celestial
update public.weapons set good_for = 'Kuki Shinobu, Nilou, Laila (Layla), Kirara, Furina y Dahlia.' where id = 'gi-w-11511'; -- Llave de la Coronación
update public.weapons set good_for = 'Sandrone.' where id = 'gi-w-12516'; -- Llave de la Trascendencia
update public.weapons set good_for = 'Aino, Kinich, Gaming, Kaveh, Dehya y Sayu.' where id = 'gi-w-12433'; -- Llave Maestra
update public.weapons set good_for = 'Venti (Arconte Anemo), Tartaglia (Childe), Ganyu, Kujou Sara, Aloy, Yelan, Collei y Ororon.' where id = 'gi-w-15416'; -- Luna de Mouun
update public.weapons set good_for = 'Bárbara, Sangonomiya Kokomi y Baizhu.' where id = 'gi-w-14506'; -- Luna Inalterable
update public.weapons set good_for = 'Alhacén (Alhaitham), Kamisato Ayaka, Kamisato Ayato, Keqing, Kaeya y Lynette.' where id = 'gi-w-11510'; -- Luna Ondulante de Futsu
update public.weapons set good_for = 'Xiangling, Zhongli (Arconte Geo), Rosaria, Shogun Raiden (Arconte), Iansán, Shenhe, Yun Jin, Candace, Mika, Chevreuse, Kachina, Escoffier e Ineffa.' where id = 'gi-w-13509'; -- Luz del Segador
update public.weapons set good_for = 'Jean, Xingchiu (Xingqiu), Kaedehara Kazuha, Lynette, Kuki Shinobu, Viajero (Traveler), Alhacén (Alhaitham), Nilou y Kirara.' where id = 'gi-w-11418'; -- Luz Lunar de Xifos
update public.weapons set good_for = 'Dehya, Diluc, Beidou, Dori, Kaveh y Sayu.' where id = 'gi-w-12415'; -- Májaira Aguamarina
update public.weapons set good_for = 'Ganyu, Lyney, Tartaglia (Childe), Tignari (Tighnari), Yoimiya y Amber.' where id = 'gi-w-15414'; -- Masacrademonios
update public.weapons set good_for = 'Sobre todo para Lyney y Kujou Sara. También va bien con Ganyu, Tartaglia (Childe) y Fischl.' where id = 'gi-w-15427'; -- Medidor Telemétrico
update public.weapons set good_for = 'Diluc, Razor, Noelle, Beidou, Chongyun, Xinyan, Eula, Arataki Itto, Dehya, Kaveh, Navia, Fréminet, Gaming, Kinich y Mavuika (Arconte Pyro).' where id = 'gi-w-12409'; -- Médula de la Serpiente Marina
update public.weapons set good_for = 'Sacarosa (Sucrose), Klee, Shikanoin Heizou, Lisa, Nahida (Arconte Dendro), Baizhu, Sangonomiya Kokomi, Citlalí, Lan Yan, Mizuki, Ifa y Lauma.' where id = 'gi-w-14403'; -- Memorias de Sacrificios
update public.weapons set good_for = 'Ganyu, Lyney y Tignari (Tighnari).' where id = 'gi-w-15305'; -- Mensajero
update public.weapons set good_for = 'Mavuika (Arconte Pyro), Kinich y Sandrone.' where id = 'gi-w-12514'; -- Mil Soles Abrasadores
update public.weapons set good_for = 'Sobre todo para Dehya, Dori y Sayu.' where id = 'gi-w-12427'; -- Motosierra Transportable
update public.weapons set good_for = 'Klee, Ningguang, Trotamundos (Wanderer) y Shikanoin Heizou.' where id = 'gi-w-14305'; -- Nefrita Gemela
update public.weapons set good_for = 'Columbina y Lauma.' where id = 'gi-w-14522'; -- Nocturno tras el Velo
update public.weapons set good_for = 'Amber, Venti (Arconte Anemo), Fischl, Ganyu, Aloy y Tignari (Tighnari).' where id = 'gi-w-15413'; -- Oda a las Flores de Viento
update public.weapons set good_for = 'Sobre todo para Klee, Neuvillette y Yanfei. También va bien con Trotamundos (Wanderer), Wriothesley, Shikanoin Heizou y Ningguang.' where id = 'gi-w-14426'; -- Oda al Vasto Azul
update public.weapons set good_for = 'Razor, Xinyan, Eula y Fréminet.' where id = 'gi-w-12503'; -- Oda de los Pinos
update public.weapons set good_for = 'Klee, Trotamundos (Wanderer), Shikanoin Heizou, Ningguang y Yanfei.' where id = 'gi-w-14409'; -- Ojo de la Perspicacia
update public.weapons set good_for = 'Klee, Mona, Yae Miko, Xianyun (Preservadora), Nicole, Lisa, Ningguang y Yanfei.' where id = 'gi-w-14415'; -- Ojo del Juramento
update public.weapons set good_for = 'Klee, Mona, Nahida (Arconte Dendro), Neuvillette, Trotamundos (Wanderer), Wriothesley, Yae Miko, Shikanoin Heizou, Lisa, Ningguang y Yanfei.' where id = 'gi-w-14502'; -- Oración Perdida a los Vientos Sagrados
update public.weapons set good_for = 'Mona, Yae Miko y Nahida (Arconte Dendro).' where id = 'gi-w-14304'; -- Orbe Esmeralda
update public.weapons set good_for = 'Diluc, Razor, Noelle, Beidou, Chongyun, Xinyan, Eula, Sayu, Arataki Itto, Dehya, Kaveh, Navia, Gaming, Kinich y Aino.' where id = 'gi-w-12501'; -- Orgullo Celestial
update public.weapons set good_for = 'Xiao, Xiangling, Zhongli (Arconte Geo), Rosaria, Shogun Raiden (Arconte), Iansán, Shenhe, Emilie, Chevreuse, Escoffier e Ineffa.' where id = 'gi-w-13507'; -- Pacificadora del Desastre
update public.weapons set good_for = 'Ororon, Chasca, Tignari (Tighnari), Lyney, Ganyu y Amber.' where id = 'gi-w-15430'; -- Penacho Engalanado
update public.weapons set good_for = 'Xiangling, Hu Tao, Candace, Yaoyao, Thoma, Shogun Raiden (Arconte), Chevreuse, Emilie, Escoffier e Ineffa.' where id = 'gi-w-13401'; -- Perdición del Dragón
update public.weapons set good_for = 'Sobre todo para Ganyu, Tartaglia (Childe), Tignari (Tighnari) y Amber.' where id = 'gi-w-15419'; -- Perforaibis
update public.weapons set good_for = 'Xiangling, Thoma y Yaoyao.' where id = 'gi-w-13417'; -- Perforalunas
update public.weapons set good_for = 'Sobre todo para Shikanoin Heizou, Charlotte y Wriothesley. También va bien con Lisa, Klee, Mona, Ningguang, Trotamundos (Wanderer), Yanfei, Yae Miko, Xianyun (Preservadora), Lan Yan, Varesa y Nicole.' where id = 'gi-w-14501'; -- Pergamino Celestial
update public.weapons set good_for = 'Lisa, Klee, Mona, Ningguang, Trotamundos (Wanderer), Yanfei, Yae Miko, Shikanoin Heizou, Nahida (Arconte Dendro), Wriothesley, Varesa y Nefer.' where id = 'gi-w-14405'; -- Perla Solar
update public.weapons set good_for = 'Sobre todo para Rosaria.' where id = 'gi-w-13403'; -- Pica Luna Creciente
update public.weapons set good_for = 'Chasca, Tignari (Tighnari), Lyney y Ganyu.' where id = 'gi-w-15514'; -- Pluma Carmesí Buitreastral
update public.weapons set good_for = 'Odette.' where id = 'gi-w-11520'; -- Pluma Invernal Lagoblanco
update public.weapons set good_for = 'Jahoda, Ororon, Faruzán, Collei y Fischl.' where id = 'gi-w-15434'; -- Pluvioarco de la Serpiente Arcoíris
update public.weapons set good_for = 'Sobre todo para Baizhu, Sangonomiya Kokomi, Neuvillette y Bárbara.' where id = 'gi-w-14406'; -- Prototipo Ámbar
update public.weapons set good_for = 'Diluc, Razor, Chongyun, Xinyan, Eula y Dehya.' where id = 'gi-w-12406'; -- Prototipo Arcaico
update public.weapons set good_for = 'Xiao, Xiangling, Zhongli (Arconte Geo), Hu Tao, Yun Jin y Candace.' where id = 'gi-w-13402'; -- Prototipo Estelar
update public.weapons set good_for = 'Tartaglia (Childe), Ganyu, Kujou Sara, Aloy, Lyney, Tignari (Tighnari), Collei, Sethos y Chasca.' where id = 'gi-w-15406'; -- Prototipo Luz de Luna
update public.weapons set good_for = 'Jean, Kaeya, Bennett, Qiqi y Keqing.' where id = 'gi-w-11406'; -- Prototipo Rencor
update public.weapons set good_for = 'Xiao, Xiangling, Zhongli (Arconte Geo), Cyno, Thoma, Shogun Raiden (Arconte), Iansán, Shenhe, Yun Jin, Candace, Mika, Kachina, Escoffier, Ineffa y Alyosha.' where id = 'gi-w-13502'; -- Púa Celestial
update public.weapons set good_for = 'Kachina y Emilie.' where id = 'gi-w-13430'; -- Púa Sustentamontañas
update public.weapons set good_for = 'Solo sirve al principio del juego, hasta que consigas un arma de 3★ o más del mismo tipo. Después úsala como material para mejorar otras armas.' where id = 'gi-w-13201'; -- Punta de Hierro
update public.weapons set good_for = 'Linnea.' where id = 'gi-w-15516'; -- Rama del Juramento Escarchado
update public.weapons set good_for = 'Sobre todo para Alhacén (Alhaitham), Kamisato Ayaka, Kamisato Ayato y Keqing. También va bien con Albedo, Jean, Kaedehara Kazuha, Viajero (Traveler), Bennett, Kaeya, Laila (Layla) y Xingchiu (Xingqiu).' where id = 'gi-w-11509'; -- Reflejo de las Tinieblas
update public.weapons set good_for = 'Sobre todo para Varesa.' where id = 'gi-w-14519'; -- Reflexión Iridiscente
update public.weapons set good_for = 'Zibai, Chiori y Albedo.' where id = 'gi-w-11519'; -- Refulgencia de la Luna
update public.weapons set good_for = 'Nefer, Lauma y Columbina.' where id = 'gi-w-14521'; -- Relicario de la Verdad
update public.weapons set good_for = 'Trotamundos (Wanderer), Shikanoin Heizou y Ningguang.' where id = 'gi-w-14512'; -- Reminiscencia de Tulaytulah
update public.weapons set good_for = 'Sobre todo para Kamisato Ayaka, Kamisato Ayato, Jean, Keqing y Qiqi. También va bien con Clorinde y Xingchiu (Xingqiu).' where id = 'gi-w-11425'; -- Réquiem Abisal
update public.weapons set good_for = 'Sobre todo para Zhongli (Arconte Geo), Candace y Thoma. También va bien con Chevreuse, Mika y Yaoyao.' where id = 'gi-w-13425'; -- Retribución de la Justicia
update public.weapons set good_for = 'Sobre todo para Xianyun (Preservadora).' where id = 'gi-w-14515'; -- Reverberación de la Grulla
update public.weapons set good_for = 'Sobre todo para Diluc y Eula. También va bien con Noelle, Beidou, Chongyun, Xinyan, Dehya y Mavuika (Arconte Pyro).' where id = 'gi-w-12412'; -- Rey de los Mares
update public.weapons set good_for = 'Diluc, Razor, Beidou, Chongyun, Xinyan, Eula y Dehya.' where id = 'gi-w-12416'; -- Rey del Mal
update public.weapons set good_for = 'Sethos, Aloy, Kujou Sara, Yoimiya, Ganyu, Tartaglia (Childe), Fischl, Venti (Arconte Anemo) y Amber.' where id = 'gi-w-15431'; -- Rompecadenas
update public.weapons set good_for = 'Viajero (Traveler), Kaeya, Bennett, Qiqi, Keqing, Kamisato Ayaka y Kamisato Ayato.' where id = 'gi-w-11504'; -- Rompemontañas
update public.weapons set good_for = 'Keqing, Kamisato Ayato, Kuki Shinobu y Durin.' where id = 'gi-w-11405'; -- Rugido del León
update public.weapons set good_for = 'Cyno, Flins y Shogun Raiden (Arconte).' where id = 'gi-w-13516'; -- Ruinas Ensangrentadas
update public.weapons set good_for = 'Aino, Gaming, Kaveh, Dehya, Dori y Sayu.' where id = 'gi-w-12432'; -- Sabiduría Fraguada
update public.weapons set good_for = 'Nilou, Kirara, Laila (Layla) y Kuki Shinobu.' where id = 'gi-w-11427'; -- Sable de la Dársena
update public.weapons set good_for = 'Sobre todo para Beidou y Kaveh. También va bien con Diluc, Razor, Gaming, Mavuika (Arconte Pyro) y Dehya.' where id = 'gi-w-12405'; -- Segadora de la Lluvia
update public.weapons set good_for = 'Arlecchino.' where id = 'gi-w-13512'; -- Semblante de la Luna Carmesí
update public.weapons set good_for = 'Sobre todo para Tartaglia (Childe), Ganyu, Lyney y Tignari (Tighnari). También va bien con Sethos y Chasca.' where id = 'gi-w-15511'; -- Senda de la Cazadora
update public.weapons set good_for = 'Dehya, Diluc, Mavuika (Arconte Pyro), Navia, Beidou, Noelle y Razor.' where id = 'gi-w-12512'; -- Sentenciadora
update public.weapons set good_for = 'Tartaglia (Childe), Fischl y Kujou Sara.' where id = 'gi-w-15425'; -- Serenata del Sosiego
update public.weapons set good_for = 'Dahlia, Furina, Laila (Layla), Nilou, Kuki Shinobu y Bennett.' where id = 'gi-w-11433'; -- Silbido Melifluo
update public.weapons set good_for = 'Klee, Mona, Nahida (Arconte Dendro), Neuvillette, Varesa, Trotamundos (Wanderer), Wriothesley, Yae Miko, Shikanoin Heizou, Lisa, Ningguang, Sacarosa (Sucrose) y Yanfei.' where id = 'gi-w-14402'; -- Sinfonía de los Merodeadores
update public.weapons set good_for = 'Escoffier y Iansán.' where id = 'gi-w-13514'; -- Sinfonista de Aromas
update public.weapons set good_for = 'Noelle, Xinyan y Arataki Itto.' where id = 'gi-w-12407'; -- Sombra Blanca
update public.weapons set good_for = 'Sandrone, Beidou, Chongyun y Sayu.' where id = 'gi-w-12425'; -- Sombra de la Marea
update public.weapons set good_for = 'Sandrone y Beidou.' where id = 'gi-w-12435'; -- Sombra de la Melodía Dorada
update public.weapons set good_for = 'Xinyan y Dehya.' where id = 'gi-w-12301'; -- Sombra Férrea
update public.weapons set good_for = 'Mualani, Nahida (Arconte Dendro), Yae Miko, Lisa y Sacarosa (Sucrose).' where id = 'gi-w-14511'; -- Sueños de las Mil Noches
update public.weapons set good_for = 'Dehya, Navia, Beidou y Chongyun.' where id = 'gi-w-12426'; -- Superespada Mágica Suprema
update public.weapons set good_for = 'Sobre todo para Wriothesley.' where id = 'gi-w-14513'; -- Supervisor Flujoáurico
update public.weapons set good_for = 'Sandrone y Beidou.' where id = 'gi-w-12436'; -- Tajo Redentor
update public.weapons set good_for = 'Cyno, Escoffier, Hu Tao, Shogun Raiden (Arconte), Shenhe, Xiao, Rosaria y Xiangling.' where id = 'gi-w-13427'; -- Taladradora de Prospección
update public.weapons set good_for = 'Kinich, Navia, Dehya y Diluc.' where id = 'gi-w-12431'; -- Terragitador
update public.weapons set good_for = 'Ganyu, Linnea, Lyney, Tartaglia (Childe), Tignari (Tighnari), Yelan y Yoimiya.' where id = 'gi-w-15304'; -- Tirachinas
update public.weapons set good_for = 'Sobre todo para Tignari (Tighnari) y Venti (Arconte Anemo). También va bien con Aloy, Ganyu, Tartaglia (Childe), Yelan, Amber, Collei, Faruzán, Fischl y Ororon.' where id = 'gi-w-15402'; -- Último Acorde
update public.weapons set good_for = 'Sobre todo para Bennett, Kaeya, Laila (Layla) y Xingchiu (Xingqiu). También va bien con Albedo, Kamisato Ayato, Furina, Jean y Viajero (Traveler).' where id = 'gi-w-11426'; -- Vado del Río Ceniciento
update public.weapons set good_for = 'Fischl.' where id = 'gi-w-15412'; -- Vals Nocturno
update public.weapons set good_for = 'Tartaglia (Childe), Yoimiya, Lyney y Tignari (Tighnari).' where id = 'gi-w-15417'; -- Vasalla del Rey
update public.weapons set good_for = 'Nicole, Lan Yan, Citlalí, Nahida (Arconte Dendro) y Baizhu.' where id = 'gi-w-14517'; -- Vigía de las Estrellas
update public.weapons set good_for = 'Klee, Shikanoin Heizou, Lisa, Ningguang y Yanfei.' where id = 'gi-w-14410'; -- Vino y Poesía
update public.weapons set good_for = 'Chasca, Ganyu, Tartaglia (Childe), Tignari (Tighnari), Venti (Arconte Anemo), Yelan, Yoimiya, Fischl y Sethos.' where id = 'gi-w-15435'; -- Visión de Jade
update public.weapons set good_for = 'Neuvillette, Baizhu, Sangonomiya Kokomi y Bárbara.' where id = 'gi-w-14430'; -- Volver de las Olas

-- Zenless Zone Zero (amplificadores): 99
update public.weapons set good_for = 'Ideal para Evelyn. También va bien con Orfia y Magas (Orphie & Magus), Soldado 11 y Pyrois.' where id = 'zzz-w-591'; -- Acordes del corazón nocturno
update public.weapons set good_for = 'Ideal para Jane Doe. También va bien con Piper Wheel y Grace Howard.' where id = 'zzz-w-377'; -- Aguijón agudo
update public.weapons set good_for = 'Ideal para Nekomata. También va bien con Corin Wickes y Billy Kid.' where id = 'zzz-w-80'; -- Almohadillas férreas
update public.weapons set good_for = 'Ideal para Corin Wickes. También va bien con Billy Kid.' where id = 'zzz-w-72'; -- Amo de llaves
update public.weapons set good_for = 'Ideal para Harumasa. También va bien con Zhu Yuan, Ellen Joe, Soldado 11, Nekomata, Anton Ivanov, Corin Wickes y Billy Kid.' where id = 'zzz-w-539'; -- Anhelo marcato
update public.weapons set good_for = 'Ideal para Zhu Yuan. También va bien con Pyrois.' where id = 'zzz-w-87'; -- Antidisturbios (VI)
update public.weapons set good_for = 'Ideal para Claret. También va bien con Ben Bigger.' where id = 'zzz-w-1190'; -- Arca de médula ósea
update public.weapons set good_for = 'Ideal para Lycaon (Von Lycaon). También va bien con Koleda Belobog y Anby Demara.' where id = 'zzz-w-79'; -- Barril giratorio
update public.weapons set good_for = 'Ideal para Anby Demara. También va bien con Qingyi.' where id = 'zzz-w-3'; -- Batería de Demara (II)
update public.weapons set good_for = 'Ideal para Rina (Alexandrina). También va bien con Nicole Demara y Lucy.' where id = 'zzz-w-78'; -- Bola de juego desenfrenada
update public.weapons set good_for = 'Ideal para Grace Howard. También va bien con Piper Wheel.' where id = 'zzz-w-67'; -- Brillo labial electrizante
update public.weapons set good_for = 'Ideal para Lighter. También va bien con Nangong Yu, Dialyn, Ju Fufu, Gatillo (Trigger), Qingyi, Lycaon (Von Lycaon), Koleda Belobog, Pulchra y Anby Demara.' where id = 'zzz-w-1068'; -- Caldero ardiente
update public.weapons set good_for = 'Ideal para Banyue. También va bien con Yixuan, Yidhari y Manato.' where id = 'zzz-w-984'; -- Caldero de la claridad
update public.weapons set good_for = 'Ideal para Nicole Demara. También va bien con Astra Yao y Lucía.' where id = 'zzz-w-71'; -- Cámara acorazada
update public.weapons set good_for = 'Ideal para Lucy. También va bien con Sunna, Yuzuha, Astra Yao, Rina (Alexandrina), Nicole Demara y Soukaku.' where id = 'zzz-w-273'; -- Cañón bombástico
update public.weapons set good_for = 'Ideal para Yixuan.' where id = 'zzz-w-787'; -- Ceniza - Cobalto
update public.weapons set good_for = 'Ideal para Ben Bigger.' where id = 'zzz-w-68'; -- Cesta conejera
update public.weapons set good_for = 'Ideal para Ben Bigger.' where id = 'zzz-w-75'; -- Cilindro neumático de Bigger
update public.weapons set good_for = 'Ideal para Burnice White. También va bien con Piper Wheel, Jane Doe y Grace Howard.' where id = 'zzz-w-525'; -- Coctelera incandescente
update public.weapons set good_for = 'Ideal para Caesar King. También va bien con Ben Bigger y Seth Lowell.' where id = 'zzz-w-389'; -- Colmillos furibundos
update public.weapons set good_for = 'Ideal para Grace Howard. También va bien con Piper Wheel.' where id = 'zzz-w-84'; -- Compilador quimérico
update public.weapons set good_for = 'Ideal para Zhao.' where id = 'zzz-w-983'; -- Conejita semiazucarada
update public.weapons set good_for = 'Ideal para Sporos (Seed). También va bien con N.º 0: Anby (Soldier 0 - Anby), Harumasa y Anton Ivanov.' where id = 'zzz-w-910'; -- Cordis germina
update public.weapons set good_for = 'Ideal para Yidhari.' where id = 'zzz-w-937'; -- Cuna del kraken
update public.weapons set good_for = 'Ideal para Rina (Alexandrina). También va bien con Nicole Demara y Lucy.' where id = 'zzz-w-86'; -- Cuna plañidera
update public.weapons set good_for = 'Ideal para Pulchra. También va bien con Gatillo (Trigger).' where id = 'zzz-w-622'; -- Cúter
update public.weapons set good_for = 'Ideal para Nangong Yu.' where id = 'zzz-w-1067'; -- Delusiones de neón
update public.weapons set good_for = 'Ideal para Soukaku.' where id = 'zzz-w-76'; -- Demonio cohibido
update public.weapons set good_for = 'Ideal para Harumasa. También va bien con N.º 0: Anby (Soldier 0 - Anby), Cissia, Sporos (Seed), Anton Ivanov y Anby Demara.' where id = 'zzz-w-541'; -- Dispensador de fármacos zanshin
update public.weapons set good_for = 'Ideal para Velina. También va bien con Burnice White, Promeia, Aria, Alice, Vivian, Jane Doe, Yanagi, Grace Howard y Piper Wheel.' where id = 'zzz-w-1106'; -- Ecos bulliciosos
update public.weapons set good_for = 'Amplificador exclusivo de Aria. También va bien con Vivian.' where id = 'zzz-w-1047'; -- El ángel en la carcasa
update public.weapons set good_for = 'Ideal para Lycaon (Von Lycaon). También va bien con Koleda Belobog y Anby Demara.' where id = 'zzz-w-83'; -- El sometido
update public.weapons set good_for = 'Ideal para Koleda Belobog. También va bien con Lycaon (Von Lycaon), Nangong Yu y Anby Demara.' where id = 'zzz-w-82'; -- Engranaje infernal
update public.weapons set good_for = 'Ideal para Astra Yao. También va bien con Lucy y Soukaku.' where id = 'zzz-w-590'; -- Envanecimiento primoroso
update public.weapons set good_for = 'Ideal para Ye Shunguang.' where id = 'zzz-w-982'; -- Esplendor surcanimbos
update public.weapons set good_for = 'Ideal para Ellen Joe. También va bien con Soldado 11, Nekomata, Anton Ivanov, Corin Wickes y Billy Kid.' where id = 'zzz-w-59'; -- Estrella callejera
update public.weapons set good_for = 'Ideal para Sigrid. También va bien con Ellen Joe, N.º 0: Anby (Soldier 0 - Anby), Zhu Yuan, Hugo y Anby Demara.' where id = 'zzz-w-1188'; -- Exaltación de caballería
update public.weapons set good_for = 'Ideal para Alice. También va bien con Jane Doe y Piper Wheel.' where id = 'zzz-w-903'; -- Excelencia disciplinada
update public.weapons set good_for = 'Ideal para Promeia. También va bien con Miyabi.' where id = 'zzz-w-1087'; -- Falce escarchada
update public.weapons set good_for = 'Ideal para Ellen Joe.' where id = 'zzz-w-46'; -- Fase lunar - Luna menguante
update public.weapons set good_for = 'Ideal para Corin Wickes. También va bien con Soldado 11.' where id = 'zzz-w-47'; -- Fase lunar - Novilunio
update public.weapons set good_for = 'Ideal para Ellen Joe.' where id = 'zzz-w-45'; -- Fase lunar - Plenilunio
update public.weapons set good_for = 'Ideal para Claret. También va bien con Ben Bigger.' where id = 'zzz-w-1192'; -- Fase lunar - Semiluna
update public.weapons set good_for = 'Ideal para Ellen Joe. También va bien con Zhu Yuan, Soldado 11, Corin Wickes, Nekomata, Billy Kid y Anton Ivanov.' where id = 'zzz-w-354'; -- Florescencia aurífera
update public.weapons set good_for = 'Ideal para Orfia y Magas (Orphie & Magus).' where id = 'zzz-w-929'; -- Fogonazo belicoso
update public.weapons set good_for = 'Ideal para Claret. También va bien con Ben Bigger.' where id = 'zzz-w-1191'; -- Fortuna felina
update public.weapons set good_for = 'Ideal para Lycaon (Von Lycaon). También va bien con Koleda Belobog y Anby Demara.' where id = 'zzz-w-64'; -- Fósil preciado
update public.weapons set good_for = 'Ideal para Piper Wheel. También va bien con Grace Howard.' where id = 'zzz-w-61'; -- Gastrónomo selvático
update public.weapons set good_for = 'Ideal para Lucía.' where id = 'zzz-w-935'; -- Hogar de ensueño
update public.weapons set good_for = 'Ideal para Ben Bigger.' where id = 'zzz-w-58'; -- Identidad - Desinencia
update public.weapons set good_for = 'Ideal para Ben Bigger.' where id = 'zzz-w-57'; -- Identidad - Raíz
update public.weapons set good_for = 'Ideal para Manato. También va bien con Banyue y Yixuan.' where id = 'zzz-w-936'; -- Ignición fatua
update public.weapons set good_for = 'Ideal para N.º 0: Anby (Soldier 0 - Anby), Harumasa y Anton Ivanov.' where id = 'zzz-w-621'; -- Inocencia sacrificada
update public.weapons set good_for = 'Amplificador exclusivo de Velina Airgid.' where id = 'zzz-w-1104'; -- Joyau doré
update public.weapons set good_for = 'Ideal para Rina (Alexandrina). También va bien con Nicole Demara y Lucy.' where id = 'zzz-w-60'; -- Lapso de tiempo
update public.weapons set good_for = 'Ideal para Lighter. También va bien con Lycaon (Von Lycaon), Qingyi, Koleda Belobog y Anby Demara.' where id = 'zzz-w-534'; -- Láurea ardiente
update public.weapons set good_for = 'Ideal para Dialyn. También va bien con Pulchra.' where id = 'zzz-w-964'; -- Llamada del ayer
update public.weapons set good_for = 'Ideal para Vivian. También va bien con Jane Doe, Grace Howard y Piper Wheel.' where id = 'zzz-w-66'; -- Llanto mielgo
update public.weapons set good_for = 'Ideal para Yuzuha.' where id = 'zzz-w-877'; -- Metanukimorfosis
update public.weapons set good_for = 'Amplificador exclusivo de Hugo Vlad. También va bien con Ellen Joe.' where id = 'zzz-w-706'; -- Miríada de eclipses
update public.weapons set good_for = 'Ideal para Ellen Joe. También va bien con Nekomata, Soldado 11, Billy Kid, Anton Ivanov y Corin Wickes.' where id = 'zzz-w-62'; -- Motor estelar
update public.weapons set good_for = 'Ideal para Yixuan.' where id = 'zzz-w-782'; -- Nidal Qingming
update public.weapons set good_for = 'Ideal para Remielle.' where id = 'zzz-w-1174'; -- Oda de alas renacidas
update public.weapons set good_for = 'Ideal para Seth Lowell. También va bien con Ben Bigger.' where id = 'zzz-w-378'; -- Pacificador especializado
update public.weapons set good_for = 'Ideal para Sunna. También va bien con Yuzuha.' where id = 'zzz-w-1015'; -- Pensamientos hechos canción
update public.weapons set good_for = 'Ideal para Soldado 11. También va bien con Ellen Joe, Zhu Yuan, Nekomata, Corin Wickes, Billy Kid y Anton Ivanov.' where id = 'zzz-w-81'; -- Petrazufre
update public.weapons set good_for = 'Ideal para Ben Bigger.' where id = 'zzz-w-69'; -- Primavera termal
update public.weapons set good_for = 'Ideal para Caesar King. También va bien con Pan Yinhu.' where id = 'zzz-w-784'; -- Proyector de celuloide
update public.weapons set good_for = 'Ideal para Cissia. También va bien con Sporos (Seed), N.º 0: Anby (Soldier 0 - Anby), Harumasa y Anton Ivanov.' where id = 'zzz-w-1078'; -- Rastreador serpentino
update public.weapons set good_for = 'Ideal para Pan Yinhu. También va bien con Caesar King, Ben Bigger, Seth Lowell y Astra Yao.' where id = 'zzz-w-783'; -- Receptáculo de trigramas sísmico
update public.weapons set good_for = 'Ideal para Koleda Belobog. También va bien con Lycaon (Von Lycaon) y Anby Demara.' where id = 'zzz-w-48'; -- Repercusión - Modelo I
update public.weapons set good_for = 'Ideal para Rina (Alexandrina). También va bien con Nicole Demara.' where id = 'zzz-w-49'; -- Repercusión - Modelo II
update public.weapons set good_for = 'Ideal para Lucy. También va bien con Rina (Alexandrina).' where id = 'zzz-w-50'; -- Repercusión - Modelo III
update public.weapons set good_for = 'Ideal para Billy Kid.' where id = 'zzz-w-73'; -- Réplica de motor estelar
update public.weapons set good_for = 'Ideal para Vivian.' where id = 'zzz-w-705'; -- Revoloteo ensoñador
update public.weapons set good_for = 'Ideal para Yixuan.' where id = 'zzz-w-785'; -- Rompecabezas ilusorio
update public.weapons set good_for = 'Ideal para Ellen Joe. También va bien con Soldado 11, Nekomata, Anton Ivanov, Pyrois, Corin Wickes y Billy Kid.' where id = 'zzz-w-77'; -- Rotor de cañón
update public.weapons set good_for = 'Ideal para Ju Fufu. También va bien con Koleda Belobog y Lighter.' where id = 'zzz-w-851'; -- Rugiente urna de la fortuna
update public.weapons set good_for = 'Ideal para Claret. También va bien con Ben Bigger.' where id = 'zzz-w-1189'; -- Sed escarlata
update public.weapons set good_for = 'Ideal para Pyrois. También va bien con Zhu Yuan.' where id = 'zzz-w-1105'; -- Sol exuvia
update public.weapons set good_for = 'Ideal para Norma. También va bien con Ju Fufu, Lighter y Koleda Belobog.' where id = 'zzz-w-1134'; -- Subalterno jefe
update public.weapons set good_for = 'Ideal para Anton Ivanov.' where id = 'zzz-w-74'; -- Taladradora giratoria - Eje rojo
update public.weapons set good_for = 'Ideal para Miyabi.' where id = 'zzz-w-540'; -- Templo a la granizada estelífera
update public.weapons set good_for = 'Ideal para Qingyi. También va bien con Lycaon (Von Lycaon) y Koleda Belobog.' where id = 'zzz-w-355'; -- Tetera esmeraldina
update public.weapons set good_for = 'Ideal para Grace Howard. También va bien con Piper Wheel.' where id = 'zzz-w-54'; -- Tormenta magnética - Alfa
update public.weapons set good_for = 'Ideal para Grace Howard. También va bien con Piper Wheel.' where id = 'zzz-w-55'; -- Tormenta magnética - Bravo
update public.weapons set good_for = 'Ideal para Grace Howard. También va bien con Piper Wheel.' where id = 'zzz-w-56'; -- Tormenta magnética - Charlie
update public.weapons set good_for = 'Ideal para Yixuan.' where id = 'zzz-w-786'; -- Tránsito herciano
update public.weapons set good_for = 'Ideal para Ben Bigger.' where id = 'zzz-w-65'; -- Transmorfer original
update public.weapons set good_for = 'Ideal para Koleda Belobog. También va bien con Lycaon (Von Lycaon) y Anby Demara.' where id = 'zzz-w-51'; -- Turbulencia - Arcabuz
update public.weapons set good_for = 'Ideal para Lycaon (Von Lycaon). También va bien con Anby Demara.' where id = 'zzz-w-52'; -- Turbulencia - Flecha
update public.weapons set good_for = 'Ideal para Nicole Demara. También va bien con Koleda Belobog, Lycaon (Von Lycaon) y Anby Demara.' where id = 'zzz-w-53'; -- Turbulencia - Hacha
update public.weapons set good_for = 'Ideal para Koleda Belobog. También va bien con Lycaon (Von Lycaon) y Anby Demara.' where id = 'zzz-w-63'; -- Última cena
update public.weapons set good_for = 'Ideal para Yanagi. También va bien con Grace Howard.' where id = 'zzz-w-531'; -- Urdidor del tiempo
update public.weapons set good_for = 'Ideal para Banyue. También va bien con Manato.' where id = 'zzz-w-965'; -- Vajra iracundo
update public.weapons set good_for = 'Ideal para Piper Wheel. También va bien con Burnice White, Velina, Yanagi y Grace Howard.' where id = 'zzz-w-274'; -- Viaje estruendoso
update public.weapons set good_for = 'Ideal para Gatillo (Trigger).' where id = 'zzz-w-701'; -- Visión espectral
update public.weapons set good_for = 'Ideal para Ellen Joe.' where id = 'zzz-w-85'; -- Visitante de altamar
update public.weapons set good_for = 'Ideal para Billy Estelar (Starlight - Billy). También va bien con Yixuan, Banyue, Yidhari y Manato.' where id = 'zzz-w-1088'; -- Yelmo de motorista estelar

commit;

-- Comprobacion: cuantas armas tienen recomendacion en cada juego.
select game_id,
       count(*) as armas,
       count(*) filter (where good_for is not null) as con_recomendacion
from public.weapons
group by game_id
order by game_id;
