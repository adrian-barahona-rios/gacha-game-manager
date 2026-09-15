-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere 01_esquema.sql, 03_personajes_hsr.sql, 07_conos_hsr.sql y
-- 13_reliquias_hsr.sql.
--
-- Build recomendada de 92 personajes de Honkai: Star Rail (la guia "General" de
-- cada uno, en la pestana de guias del personaje).
--
-- Fuentes:
--   Datos del propio juego (AvatarRelicRecommend) -> la recomendacion oficial
--     que el juego muestra en la ficha del personaje: conjuntos de reliquias,
--     ornamentos planares, stat principal de cada pieza y subestadisticas.
--     Los personajes colaboracion (Saber, Archer, Rin y Gilgamesh) no la
--     tienen en los datos del juego, asi que solo llevan conos.
--   Conos de luz -> los recomendados de las guias de Game8.
--
-- Cada fila guarda la build en dos formatos: texto (equipment_build y stats,
-- editables desde /admin) y build (jsonb con ids, para pintarla con iconos).
--
-- Sobrescribe la guia General de estos personajes.
--
-- Generado el 2026-09-15.

insert into public.character_meta_guides (
  game_id, character_id, mode, equipment_build, stats, variations, source, build
)
values
  ('honkai-star-rail', 'hsr-acheron', 'General', 'Conos ideales: En las orillas transitorias.
Otros conos que le van bien: En nombre del mundo, Lluvia incesante, Solo hay que esperar, Arriba el telón, Buenas noches, que duermas bien o Calderón.
Reliquias (4 piezas): Buceadora pionera del agua muerta, Eruditos perdidos en el mar del conocimiento o Banda del trueno crepitante.
Ornamentos planares: Izumo gensei y reino divino de Takama, Salsotto inerte o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: ATQ % o VEL.
Esfera de plano: Aumento de Daño de Rayo o ATQ %.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23024"],"alternativas":["hsr-lc-23004","hsr-lc-23007","hsr-lc-23006","hsr-lc-21041","hsr-lc-21001","hsr-lc-21022"]},"reliquias":["hsr-relic-117","hsr-relic-122","hsr-relic-109"],"ornamentos":["hsr-relic-314","hsr-relic-306","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["ATQ %","VEL"],"esfera":["Aumento de Daño de Rayo","ATQ %"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-aglaea', 'General', 'Otros conos que le van bien: Tiempo urdido en oro, Más sudor y menos lágrimas, Saludo entre genios, Victoria disputada, Imágenes quemadas o Retrospección.
Reliquias (4 piezas): Héroe de la epopeya triunfal, Pistolera de la espiga silvestre o Banda del trueno crepitante.
Ornamentos planares: Parque de Platanolandia, Flota de los eternos o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Rayo.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23036","hsr-lc-21052","hsr-lc-21051","hsr-lc-21050","hsr-lc-20021","hsr-lc-20022"]},"reliquias":["hsr-relic-123","hsr-relic-102","hsr-relic-109"],"ornamentos":["hsr-relic-318","hsr-relic-302","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño de Rayo"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-anaxa', 'General', 'Conos ideales: La vida en llamas.
Otros conos que le van bien: Hacia lo inescrutable, Día del colapso cósmico o El gran negocio cósmico.
Reliquias (4 piezas): Águila del crepúsculo, Buceadora pionera del agua muerta o Eruditos perdidos en el mar del conocimiento.
Ornamentos planares: Arena rutilante, Izumo gensei y reino divino de Takama o Vonwacq el vivaz.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño de Viento o ATQ %.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23041"],"alternativas":["hsr-lc-23037","hsr-lc-21040","hsr-lc-22004"]},"reliquias":["hsr-relic-110","hsr-relic-117","hsr-relic-122"],"ornamentos":["hsr-relic-309","hsr-relic-314","hsr-relic-308"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño de Viento","ATQ %"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-archer', 'General', 'Conos ideales: Infierno donde arden los ideales.
Otros conos que le van bien: Destelleos silentes.', null, null, null, '{"conos":{"ideales":["hsr-lc-23046"],"alternativas":["hsr-lc-23061"]},"reliquias":[],"ornamentos":[],"principales":null,"secundarias":[]}'::jsonb),
  ('honkai-star-rail', 'hsr-argenti', 'General', 'Conos ideales: Hacia lo inescrutable.
Otros conos que le van bien: Antes del amanecer, Cálculo interminable, Instante grabado a fuego, Noche en la Vía Láctea, Día del colapso cósmico o El reposo de los genios.
Reliquias (4 piezas): Eruditos perdidos en el mar del conocimiento, Campeona de boxeo callejero o Genio de las estrellas relucientes.
Ornamentos planares: Salsotto inerte, Sigonia, desolación sin dueño o Diferenciador celestial.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño Físico.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23037"],"alternativas":["hsr-lc-23010","hsr-lc-24004","hsr-lc-23018","hsr-lc-23000","hsr-lc-21040","hsr-lc-21020"]},"reliquias":["hsr-relic-122","hsr-relic-105","hsr-relic-108"],"ornamentos":["hsr-relic-306","hsr-relic-313","hsr-relic-305"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño Físico"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-arlan', 'General', 'Conos ideales: Algo insustituible.
Otros conos que le van bien: Orilla inalcanzable, Sangre y fuego, abran camino, Sobre la caída de un Eón, Bajo el cielo azul, Grabación ninja: Cacería del Sonido o Juramento secreto.
Reliquias (4 piezas): Banda del trueno crepitante, Eruditos perdidos en el mar del conocimiento o Buceadora pionera del agua muerta.
Ornamentos planares: Arena rutilante, Estación sellaespacios o Diferenciador celestial.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Rayo o ATQ %.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23002"],"alternativas":["hsr-lc-23009","hsr-lc-23039","hsr-lc-24000","hsr-lc-21019","hsr-lc-22003","hsr-lc-21012"]},"reliquias":["hsr-relic-109","hsr-relic-122","hsr-relic-117"],"ornamentos":["hsr-relic-309","hsr-relic-301","hsr-relic-305"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño de Rayo","ATQ %"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-ashveil', 'General', 'Conos ideales: El final de una mentira.
Otros conos que le van bien: Hacia el final del horizonte.
Reliquias (4 piezas): Gran duque incinerador, Buceadora pionera del agua muerta o Intrépida cabalgavientos.
Ornamentos planares: Ciudad de las mil estrellas, Duran, dinastía de lobos raudos o Sigonia, desolación sin dueño.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño de Rayo o ATQ %.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: VEL, Daño CRIT, Prob. CRIT, ATQ %.', null, null, '{"conos":{"ideales":["hsr-lc-23056"],"alternativas":["hsr-lc-22008"]},"reliquias":["hsr-relic-115","hsr-relic-117","hsr-relic-120"],"ornamentos":["hsr-relic-326","hsr-relic-315","hsr-relic-313"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño de Rayo","ATQ %"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["VEL","Daño CRIT","Prob. CRIT","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-asta', 'General', 'Conos ideales: La batalla no ha terminado.
Otros conos que le van bien: ¡A bailar!, Encuentro planetario, Esculpir la luna y tejer las nubes, Imagen en el recuerdo, Coro o Rueda mecánica.
Reliquias (4 piezas): Mensajero del espacio hackeado, Ladrón del rastro meteórico o Guardia de la nieve borrascosa.
Ornamentos planares: Flota de los eternos, Quilla rota o Vonwacq el vivaz.', 'Torso: PV % o Prob. CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Fuego o PV %.
Cuerda de unión: Recuperación de energía.
Subestadísticas: VEL, ATQ %, Prob. CRIT, Daño CRIT.', null, null, '{"conos":{"ideales":["hsr-lc-23003"],"alternativas":["hsr-lc-21018","hsr-lc-21011","hsr-lc-21032","hsr-lc-21004","hsr-lc-20005","hsr-lc-20012"]},"reliquias":["hsr-relic-114","hsr-relic-111","hsr-relic-106"],"ornamentos":["hsr-relic-302","hsr-relic-310","hsr-relic-308"],"principales":{"torso":["PV %","Prob. CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño de Fuego","PV %"],"cuerda":["Recuperación de energía"]},"secundarias":["VEL","ATQ %","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('honkai-star-rail', 'hsr-aventurine', 'General', 'Conos ideales: El destino nunca es justo.
Otros conos que le van bien: El momento de la victoria, ¡Así soy yo!, Concierto para dos, El primer día del resto de mi vida, Los hilos del destino o Que tu viaje sea siempre pacífico.
Reliquias (4 piezas): Paladina de la Iglesia de la Corte Inmaculada, Eremita aislado en las estrellas o Buceadora pionera del agua muerta.
Ornamentos planares: Salsotto inerte, La Belobog de los Arquitectos o Quilla rota.', 'Torso: DEF % o Daño CRIT.
Piernas: DEF % o VEL.
Esfera de plano: DEF % o Aumento de Daño Imaginario.
Cuerda de unión: DEF %.
Subestadísticas: DEF %, Prob. CRIT, Daño CRIT, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23023"],"alternativas":["hsr-lc-23005","hsr-lc-21030","hsr-lc-21043","hsr-lc-21002","hsr-lc-21039","hsr-lc-21053"]},"reliquias":["hsr-relic-103","hsr-relic-128","hsr-relic-117"],"ornamentos":["hsr-relic-306","hsr-relic-304","hsr-relic-310"],"principales":{"torso":["DEF %","Daño CRIT"],"piernas":["DEF %","VEL"],"esfera":["DEF %","Aumento de Daño Imaginario"],"cuerda":["DEF %"]},"secundarias":["DEF %","Prob. CRIT","Daño CRIT","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-aventurine-waveflair', 'General', 'Reliquias (4 piezas): Chica mágica de hazañas gloriosas o Genio de las estrellas relucientes.
Ornamentos planares: Etapa cero de Punklorde, Parque de Platanolandia o Sigonia, desolación sin dueño.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño Cuántico o PV %.
Cuerda de unión: Recuperación de energía.
Subestadísticas: Prob. CRIT, Daño CRIT, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":[]},"reliquias":["hsr-relic-129","hsr-relic-108"],"ornamentos":["hsr-relic-325","hsr-relic-318","hsr-relic-313"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño Cuántico","PV %"],"cuerda":["Recuperación de energía"]},"secundarias":["Prob. CRIT","Daño CRIT","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-bailu', 'General', 'Conos ideales: Noche terrorífica.
Otros conos que le van bien: El tiempo no espera, Conversación en el postoperatorio, Hasta pasado mañana, Intercambio equivalente, Sentimiento compartido o Cornucopia.
Reliquias (4 piezas): Transeúnte de la nube pasajera, Mensajero del espacio hackeado o Guardia de la nieve borrascosa.
Ornamentos planares: Flota de los eternos, Quilla rota o Lushaka, sumergido bajo el mar.', 'Torso: Bonif. curación realizada o PV %.
Piernas: VEL.
Esfera de plano: PV %.
Cuerda de unión: PV % o Recuperación de energía.
Subestadísticas: PV %, VEL, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23017"],"alternativas":["hsr-lc-23013","hsr-lc-21000","hsr-lc-21055","hsr-lc-21021","hsr-lc-21007","hsr-lc-20001"]},"reliquias":["hsr-relic-101","hsr-relic-114","hsr-relic-106"],"ornamentos":["hsr-relic-302","hsr-relic-310","hsr-relic-317"],"principales":{"torso":["Bonif. curación realizada","PV %"],"piernas":["VEL"],"esfera":["PV %"],"cuerda":["PV %","Recuperación de energía"]},"secundarias":["PV %","VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-black-swan', 'General', 'Conos ideales: Recuerdos reconstruidos.
Otros conos que le van bien: Esas incontables primaveras, Lluvia incesante, Por qué canta el océano, Sanación solitaria, Solo hay que esperar o Antes de que comience la misión del tutorial.
Reliquias (4 piezas): Prisionero aislado, Águila del crepúsculo o Pistolera de la espiga silvestre.
Ornamentos planares: Entidad comercial pangaláctica, Litoral embriagado o Estación sellaespacios.', 'Torso: Acierto de efecto.
Piernas: ATQ % o VEL.
Esfera de plano: Aumento de Daño de Viento.
Cuerda de unión: ATQ %.
Subestadísticas: ATQ %, Acierto de efecto, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23022"],"alternativas":["hsr-lc-23029","hsr-lc-23007","hsr-lc-23047","hsr-lc-24003","hsr-lc-23006","hsr-lc-22000"]},"reliquias":["hsr-relic-116","hsr-relic-110","hsr-relic-102"],"ornamentos":["hsr-relic-303","hsr-relic-322","hsr-relic-301"],"principales":{"torso":["Acierto de efecto"],"piernas":["ATQ %","VEL"],"esfera":["Aumento de Daño de Viento"],"cuerda":["ATQ %"]},"secundarias":["ATQ %","Acierto de efecto","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-blade', 'General', 'Conos ideales: Noche terrorífica o Orilla inalcanzable.
Otros conos que le van bien: Algo insustituible, Danza crepuscular, Sangre y fuego, abran camino, Sobre la caída de un Eón, Bajo el cielo azul o Grabación ninja: Cacería del Sonido.
Reliquias (4 piezas): Discípula longeva, Águila del crepúsculo o Pistolera de la espiga silvestre.
Ornamentos planares: Osario sereno, Salsotto inerte o Arena rutilante.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o PV %.
Esfera de plano: Aumento de Daño de Viento o PV %.
Cuerda de unión: PV %.
Subestadísticas: Prob. CRIT, Daño CRIT, PV %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23017","hsr-lc-23009"],"alternativas":["hsr-lc-23002","hsr-lc-23030","hsr-lc-23039","hsr-lc-24000","hsr-lc-21019","hsr-lc-22003"]},"reliquias":["hsr-relic-113","hsr-relic-110","hsr-relic-102"],"ornamentos":["hsr-relic-319","hsr-relic-306","hsr-relic-309"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","PV %"],"esfera":["Aumento de Daño de Viento","PV %"],"cuerda":["PV %"]},"secundarias":["Prob. CRIT","Daño CRIT","PV %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-boothill', 'General', 'Conos ideales: Hacia una segunda vida.
Otros conos que le van bien: Crucero estelar, Dormir como un tronco, El río nace en primavera, Juego de espadas, La sombra de la noche o Antagonista.
Reliquias (4 piezas): Ladrón del rastro meteórico, Caballería de hierro plaguicida o Pistolera de la espiga silvestre.
Ornamentos planares: Talia, paraíso de los forajidos, Fragua de la linterna Kalpagni o Estación sellaespacios.', 'Torso: Prob. CRIT o ATQ %.
Piernas: VEL.
Esfera de plano: Aumento de Daño Físico.
Cuerda de unión: Efecto de Ruptura.
Subestadísticas: Efecto de Ruptura, VEL, ATQ %, Prob. CRIT, Daño CRIT.', null, null, '{"conos":{"ideales":["hsr-lc-23027"],"alternativas":["hsr-lc-24001","hsr-lc-23012","hsr-lc-21024","hsr-lc-21010","hsr-lc-21047","hsr-lc-20014"]},"reliquias":["hsr-relic-111","hsr-relic-119","hsr-relic-102"],"ornamentos":["hsr-relic-307","hsr-relic-316","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","ATQ %"],"piernas":["VEL"],"esfera":["Aumento de Daño Físico"],"cuerda":["Efecto de Ruptura"]},"secundarias":["Efecto de Ruptura","VEL","ATQ %","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('honkai-star-rail', 'hsr-bronya', 'General', 'Conos ideales: La batalla no ha terminado o Mundo de juegos.
Otros conos que le van bien: De vuelta a la tierra, ¡A bailar!, Aventuras en Villa Ensueño, El pasado y el futuro, Esculpir la luna y tejer las nubes o Coro.
Reliquias (4 piezas): Mensajero del espacio hackeado, Águila del crepúsculo o Sacerdote del calvario revivido.
Ornamentos planares: Lushaka, sumergido bajo el mar, Quilla rota o Flota de los eternos.', 'Torso: Daño CRIT.
Piernas: VEL.
Esfera de plano: PV % o DEF %.
Cuerda de unión: Recuperación de energía.
Subestadísticas: Daño CRIT, VEL, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23003","hsr-lc-23021"],"alternativas":["hsr-lc-23034","hsr-lc-21018","hsr-lc-21036","hsr-lc-21025","hsr-lc-21032","hsr-lc-20005"]},"reliquias":["hsr-relic-114","hsr-relic-110","hsr-relic-121"],"ornamentos":["hsr-relic-317","hsr-relic-310","hsr-relic-302"],"principales":{"torso":["Daño CRIT"],"piernas":["VEL"],"esfera":["PV %","DEF %"],"cuerda":["Recuperación de energía"]},"secundarias":["Daño CRIT","VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-castorice', 'General', 'Conos ideales: Despedidas más bellas.
Otros conos que le van bien: Las flores nunca olvidan o Más sudor y menos lágrimas.
Reliquias (4 piezas): Poetisa del colapso elegíaco, Genio de las estrellas relucientes o Discípula longeva.
Ornamentos planares: Osario sereno, Flota de los eternos o Parque de Platanolandia.', 'Torso: Daño CRIT.
Piernas: PV %.
Esfera de plano: Aumento de Daño Cuántico o PV %.
Cuerda de unión: PV %.
Subestadísticas: Prob. CRIT, Daño CRIT, PV %.', null, null, '{"conos":{"ideales":["hsr-lc-23040"],"alternativas":["hsr-lc-21057","hsr-lc-21052"]},"reliquias":["hsr-relic-124","hsr-relic-108","hsr-relic-113"],"ornamentos":["hsr-relic-319","hsr-relic-302","hsr-relic-318"],"principales":{"torso":["Daño CRIT"],"piernas":["PV %"],"esfera":["Aumento de Daño Cuántico","PV %"],"cuerda":["PV %"]},"secundarias":["Prob. CRIT","Daño CRIT","PV %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-cerydra', 'General', 'Otros conos que le van bien: Era grabada en sangre dorada.
Reliquias (4 piezas): Sacerdote del calvario revivido, Águila del crepúsculo o Pistolera de la espiga silvestre.
Ornamentos planares: Lushaka, sumergido bajo el mar, Flota de los eternos o Estación sellaespacios.', 'Torso: ATQ %.
Piernas: VEL o ATQ %.
Esfera de plano: ATQ %.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: ATQ %, VEL, Daño CRIT.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23048"]},"reliquias":["hsr-relic-121","hsr-relic-110","hsr-relic-102"],"ornamentos":["hsr-relic-317","hsr-relic-302","hsr-relic-301"],"principales":{"torso":["ATQ %"],"piernas":["VEL","ATQ %"],"esfera":["ATQ %"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["ATQ %","VEL","Daño CRIT"]}'::jsonb),
  ('honkai-star-rail', 'hsr-sparxie', 'General', 'Otros conos que le van bien: El cautivador mundochispa, Juntos hacia el futuro, La buena suerte de hoy, Las aventuras de Champigaga o Un breve descanso.
Reliquias (4 piezas): Chica mágica de hazañas gloriosas o Capitán del mar maldito.
Ornamentos planares: Tengoku@sala de chat, Parque de Platanolandia o Arena rutilante.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: ATQ %.
Esfera de plano: ATQ %.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23053","hsr-lc-22007","hsr-lc-21065","hsr-lc-21064","hsr-lc-21066"]},"reliquias":["hsr-relic-129","hsr-relic-126"],"ornamentos":["hsr-relic-324","hsr-relic-318","hsr-relic-309"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["ATQ %"],"esfera":["ATQ %"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-cipher', 'General', 'Conos ideales: Mentiras que vuelan en el viento.
Otros conos que le van bien: Vacaciones en las termas.
Reliquias (4 piezas): Buceadora pionera del agua muerta, Genio de las estrellas relucientes o Mensajero del espacio hackeado.
Ornamentos planares: Lushaka, sumergido bajo el mar, Flota de los eternos o Vonwacq el vivaz.', 'Torso: Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño Cuántico o ATQ %.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: VEL, ATQ %, Daño CRIT, Prob. CRIT.', null, null, '{"conos":{"ideales":["hsr-lc-23043"],"alternativas":["hsr-lc-21061"]},"reliquias":["hsr-relic-117","hsr-relic-108","hsr-relic-114"],"ornamentos":["hsr-relic-317","hsr-relic-302","hsr-relic-308"],"principales":{"torso":["Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño Cuántico","ATQ %"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["VEL","ATQ %","Daño CRIT","Prob. CRIT"]}'::jsonb),
  ('honkai-star-rail', 'hsr-clara', 'General', 'Conos ideales: Algo insustituible o Danza crepuscular.
Otros conos que le van bien: Orilla inalcanzable, Que arda el alba, Sobre la caída de un Eón, Bajo el cielo azul, Grabación ninja: Cacería del Sonido o Juramento secreto.
Reliquias (4 piezas): Campeona de boxeo callejero, Discípula longeva o Gran duque incinerador.
Ornamentos planares: Salsotto inerte, Duran, dinastía de lobos raudos o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: ATQ %.
Esfera de plano: Aumento de Daño Físico.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23002","hsr-lc-23030"],"alternativas":["hsr-lc-23009","hsr-lc-23044","hsr-lc-24000","hsr-lc-21019","hsr-lc-22003","hsr-lc-21012"]},"reliquias":["hsr-relic-105","hsr-relic-113","hsr-relic-115"],"ornamentos":["hsr-relic-306","hsr-relic-315","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["ATQ %"],"esfera":["Aumento de Daño Físico"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-cyrene', 'General', 'Conos ideales: Amor eterno como este momento.
Reliquias (4 piezas): Salvado{F#ra}{M#r} que reforja el mundo, Mensajero del espacio hackeado o Héroe de la epopeya triunfal.
Ornamentos planares: Amphoreus, la tierra eterna, Osario sereno o Árbol gigante en meditación profunda.', 'Torso: Daño CRIT.
Piernas: VEL.
Esfera de plano: PV % o Aumento de Daño de Hielo.
Cuerda de unión: PV %.
Subestadísticas: VEL, Daño CRIT, Prob. CRIT, PV %.', null, null, '{"conos":{"ideales":["hsr-lc-23052"],"alternativas":[]},"reliquias":["hsr-relic-127","hsr-relic-114","hsr-relic-123"],"ornamentos":["hsr-relic-323","hsr-relic-319","hsr-relic-320"],"principales":{"torso":["Daño CRIT"],"piernas":["VEL"],"esfera":["PV %","Aumento de Daño de Hielo"],"cuerda":["PV %"]},"secundarias":["VEL","Daño CRIT","Prob. CRIT","PV %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-dan-heng', 'General', 'Conos ideales: En la noche.
Otros conos que le van bien: Crucero estelar, Dormir como un tronco, El río nace en primavera, Ganador final, Juego de espadas o Regreso a la oscuridad.
Reliquias (4 piezas): Águila del crepúsculo, Eruditos perdidos en el mar del conocimiento o Pistolera de la espiga silvestre.
Ornamentos planares: Glamoth, frente del firmamento, Estación sellaespacios o Arena rutilante.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño de Viento.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23001"],"alternativas":["hsr-lc-24001","hsr-lc-23012","hsr-lc-21024","hsr-lc-21037","hsr-lc-21010","hsr-lc-21031"]},"reliquias":["hsr-relic-110","hsr-relic-122","hsr-relic-102"],"ornamentos":["hsr-relic-311","hsr-relic-301","hsr-relic-309"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño de Viento"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-imbibitor-lunae', 'General', 'Otros conos que le van bien: Algo insustituible, Más brillante que el sol, Sobre la caída de un Eón, Bajo el cielo azul, Juramento secreto o Los Topos te dan la bienvenida.
Reliquias (4 piezas): Pistolera de la espiga silvestre, Habitante del yermo de los bandidos o Buceadora pionera del agua muerta.
Ornamentos planares: Arena rutilante, Diferenciador celestial o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño Imaginario.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23002","hsr-lc-23015","hsr-lc-24000","hsr-lc-21019","hsr-lc-21012","hsr-lc-21005"]},"reliquias":["hsr-relic-102","hsr-relic-112","hsr-relic-117"],"ornamentos":["hsr-relic-309","hsr-relic-305","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño Imaginario"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-permanser-terrae', 'General', 'Otros conos que le van bien: A través de montañas y ríos, El momento de la victoria, La textura de los recuerdos, Ya ha cerrado los ojos, La elección de Landau o Que tu viaje sea siempre pacífico.
Reliquias (4 piezas): Eremita aislado en las estrellas, Sacerdote del calvario revivido o Pistolera de la espiga silvestre.
Ornamentos planares: Lushaka, sumergido bajo el mar, Estación sellaespacios o Colonipenal, la tierra de los sueños.', 'Torso: ATQ %.
Piernas: VEL o ATQ %.
Esfera de plano: ATQ %.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: ATQ %, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23051","hsr-lc-23005","hsr-lc-24002","hsr-lc-23011","hsr-lc-21009","hsr-lc-21053"]},"reliquias":["hsr-relic-128","hsr-relic-121","hsr-relic-102"],"ornamentos":["hsr-relic-317","hsr-relic-301","hsr-relic-312"],"principales":{"torso":["ATQ %"],"piernas":["VEL","ATQ %"],"esfera":["ATQ %"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-dr-ratio', 'General', 'Conos ideales: El bautismo del pensamiento puro.
Otros conos que le van bien: Crucero estelar, Dormir como un tronco, El final de una mentira, En la noche, Infierno donde arden los ideales o Me voy de caza.
Reliquias (4 piezas): Buceadora pionera del agua muerta, Habitante del yermo de los bandidos o Gran duque incinerador.
Ornamentos planares: Duran, dinastía de lobos raudos, Salsotto inerte o Glamoth, frente del firmamento.', 'Torso: Daño CRIT o Prob. CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño Imaginario.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23020"],"alternativas":["hsr-lc-24001","hsr-lc-23012","hsr-lc-23056","hsr-lc-23001","hsr-lc-23046","hsr-lc-23031"]},"reliquias":["hsr-relic-117","hsr-relic-112","hsr-relic-115"],"ornamentos":["hsr-relic-315","hsr-relic-306","hsr-relic-311"],"principales":{"torso":["Daño CRIT","Prob. CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño Imaginario"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-evanescia', 'General', 'Otros conos que le van bien: Encuentro en la próxima primavera, Juntos hacia el futuro, La buena suerte de hoy, Las aventuras de Champigaga o Un breve descanso.
Reliquias (4 piezas): Chica mágica de hazañas gloriosas, Capitán del mar maldito o Campeona de boxeo callejero.
Ornamentos planares: Etapa cero de Punklorde, Sigonia, desolación sin dueño o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: ATQ % o Aumento de Daño Físico.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, VEL, ATQ %.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23058","hsr-lc-22007","hsr-lc-21065","hsr-lc-21064","hsr-lc-21066"]},"reliquias":["hsr-relic-129","hsr-relic-126","hsr-relic-105"],"ornamentos":["hsr-relic-325","hsr-relic-313","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["ATQ %","Aumento de Daño Físico"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","VEL","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-evernight', 'General', 'Conos ideales: A la estrella de la larga noche.
Otros conos que le van bien: Despedidas más bellas, Las flores nunca olvidan o Más sudor y menos lágrimas.
Reliquias (4 piezas): Salvado{F#ra}{M#r} que reforja el mundo, Cazador del bosque glacial o Discípula longeva.
Ornamentos planares: Osario sereno, Paraíso de las hadas tejesueños o Parque de Platanolandia.', 'Torso: Daño CRIT o Prob. CRIT.
Piernas: VEL o PV %.
Esfera de plano: Aumento de Daño de Hielo o PV %.
Cuerda de unión: PV %.
Subestadísticas: Prob. CRIT, Daño CRIT, VEL, PV %.', null, null, '{"conos":{"ideales":["hsr-lc-23049"],"alternativas":["hsr-lc-23040","hsr-lc-21057","hsr-lc-21052"]},"reliquias":["hsr-relic-127","hsr-relic-104","hsr-relic-113"],"ornamentos":["hsr-relic-319","hsr-relic-321","hsr-relic-318"],"principales":{"torso":["Daño CRIT","Prob. CRIT"],"piernas":["VEL","PV %"],"esfera":["Aumento de Daño de Hielo","PV %"],"cuerda":["PV %"]},"secundarias":["Prob. CRIT","Daño CRIT","VEL","PV %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-feixiao', 'General', 'Conos ideales: Me voy de caza.
Otros conos que le van bien: Crucero estelar, El bautismo del pensamiento puro, El final de una mentira, Preocupaciones y felicidad, Ganador final o Hacia el final del horizonte.
Reliquias (4 piezas): Intrépida cabalgavientos, Águila del crepúsculo o Gran duque incinerador.
Ornamentos planares: Duran, dinastía de lobos raudos, Salsotto inerte o Glamoth, frente del firmamento.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Viento o ATQ %.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23031"],"alternativas":["hsr-lc-24001","hsr-lc-23020","hsr-lc-23056","hsr-lc-23016","hsr-lc-21037","hsr-lc-22008"]},"reliquias":["hsr-relic-120","hsr-relic-110","hsr-relic-115"],"ornamentos":["hsr-relic-315","hsr-relic-306","hsr-relic-311"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño de Viento","ATQ %"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-firefly', 'General', 'Otros conos que le van bien: A donde regresan los sueños, Algo insustituible, Sobre la caída de un Eón, Los Topos te dan la bienvenida, Promesa grabada o Sin escapatoria.
Reliquias (4 piezas): Caballería de hierro plaguicida, Habitante del yermo de los bandidos o Forjador de lava.
Ornamentos planares: Fragua de la linterna Kalpagni, Talia, paraíso de los forajidos o Arena rutilante.', 'Torso: ATQ %.
Piernas: VEL.
Esfera de plano: ATQ %.
Cuerda de unión: Efecto de Ruptura.
Subestadísticas: Efecto de Ruptura, VEL, ATQ %.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23025","hsr-lc-23002","hsr-lc-24000","hsr-lc-21005","hsr-lc-21042","hsr-lc-21033"]},"reliquias":["hsr-relic-119","hsr-relic-112","hsr-relic-107"],"ornamentos":["hsr-relic-316","hsr-relic-307","hsr-relic-309"],"principales":{"torso":["ATQ %"],"piernas":["VEL"],"esfera":["ATQ %"],"cuerda":["Efecto de Ruptura"]},"secundarias":["Efecto de Ruptura","VEL","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-fu-xuan', 'General', 'Conos ideales: Ya ha cerrado los ojos.
Otros conos que le van bien: El momento de la victoria, La textura de los recuerdos, El primer día del resto de mi vida, La elección de Landau, Somos Llamarada o Blindaje.
Reliquias (4 piezas): Discípula longeva, Guardia de la nieve borrascosa o Genio de las estrellas relucientes.
Ornamentos planares: Flota de los eternos, Quilla rota o Vonwacq el vivaz.', 'Torso: PV %.
Piernas: VEL o PV %.
Esfera de plano: PV %.
Cuerda de unión: Recuperación de energía o PV %.
Subestadísticas: PV %, DEF %, RES a efecto, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23011"],"alternativas":["hsr-lc-23005","hsr-lc-24002","hsr-lc-21002","hsr-lc-21009","hsr-lc-21023","hsr-lc-20010"]},"reliquias":["hsr-relic-113","hsr-relic-106","hsr-relic-108"],"ornamentos":["hsr-relic-302","hsr-relic-310","hsr-relic-308"],"principales":{"torso":["PV %"],"piernas":["VEL","PV %"],"esfera":["PV %"],"cuerda":["Recuperación de energía","PV %"]},"secundarias":["PV %","DEF %","RES a efecto","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-fugue', 'General', 'Otros conos que le van bien: El largo camino a casa, No olvides su fuego, Sanación solitaria o Vacaciones en las termas.
Reliquias (4 piezas): Caballería de hierro plaguicida, Ladrón del rastro meteórico o Relojero de maquinaciones oníricas.
Ornamentos planares: Fragua de la linterna Kalpagni, Vonwacq el vivaz o Talia, paraíso de los forajidos.', 'Torso: Acierto de efecto.
Piernas: VEL.
Esfera de plano: PV %.
Cuerda de unión: Recuperación de energía o Efecto de Ruptura.
Subestadísticas: Efecto de Ruptura, VEL, Acierto de efecto.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23035","hsr-lc-23050","hsr-lc-24003","hsr-lc-21061"]},"reliquias":["hsr-relic-119","hsr-relic-111","hsr-relic-118"],"ornamentos":["hsr-relic-316","hsr-relic-308","hsr-relic-307"],"principales":{"torso":["Acierto de efecto"],"piernas":["VEL"],"esfera":["PV %"],"cuerda":["Recuperación de energía","Efecto de Ruptura"]},"secundarias":["Efecto de Ruptura","VEL","Acierto de efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-gallagher', 'General', 'Conos ideales: Noche terrorífica.
Otros conos que le van bien: El tiempo no espera, Solo la fragancia perdura, Conversación en el postoperatorio, El momento oportuno, Ey, estoy aquí o Hasta pasado mañana.
Reliquias (4 piezas): Caballería de hierro plaguicida, Ladrón del rastro meteórico o Transeúnte de la nube pasajera.
Ornamentos planares: Fragua de la linterna Kalpagni, Talia, paraíso de los forajidos o Flota de los eternos.', 'Torso: Bonif. curación realizada.
Piernas: VEL.
Esfera de plano: PV % o DEF %.
Cuerda de unión: Efecto de Ruptura o Recuperación de energía.
Subestadísticas: VEL, Efecto de Ruptura, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23017"],"alternativas":["hsr-lc-23013","hsr-lc-23032","hsr-lc-21000","hsr-lc-21014","hsr-lc-22001","hsr-lc-21055"]},"reliquias":["hsr-relic-119","hsr-relic-111","hsr-relic-101"],"ornamentos":["hsr-relic-316","hsr-relic-307","hsr-relic-302"],"principales":{"torso":["Bonif. curación realizada"],"piernas":["VEL"],"esfera":["PV %","DEF %"],"cuerda":["Efecto de Ruptura","Recuperación de energía"]},"secundarias":["VEL","Efecto de Ruptura","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-gepard', 'General', 'Conos ideales: El momento de la victoria.
Otros conos que le van bien: La textura de los recuerdos, El primer día del resto de mi vida, La elección de Landau, Que tu viaje sea siempre pacífico, Somos Llamarada o Tendencias del mercado universal.
Reliquias (4 piezas): Paladina de la Iglesia de la Corte Inmaculada, Eremita aislado en las estrellas o Guardia de la nieve borrascosa.
Ornamentos planares: La Belobog de los Arquitectos, Quilla rota o Lushaka, sumergido bajo el mar.', 'Torso: DEF %.
Piernas: VEL.
Esfera de plano: DEF %.
Cuerda de unión: Recuperación de energía o DEF %.
Subestadísticas: DEF %, VEL, Acierto de efecto, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23005"],"alternativas":["hsr-lc-24002","hsr-lc-21002","hsr-lc-21009","hsr-lc-21053","hsr-lc-21023","hsr-lc-21016"]},"reliquias":["hsr-relic-103","hsr-relic-128","hsr-relic-106"],"ornamentos":["hsr-relic-304","hsr-relic-310","hsr-relic-317"],"principales":{"torso":["DEF %"],"piernas":["VEL"],"esfera":["DEF %"],"cuerda":["Recuperación de energía","DEF %"]},"secundarias":["DEF %","VEL","Acierto de efecto","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-gilgamesh', 'General', 'Conos ideales: Soy lo que ves.
Otros conos que le van bien: Coronación sin agradecimiento, Que arda el alba, Sobre la caída de un Eón, Bajo el cielo azul o Sangre del pasado.', null, null, null, '{"conos":{"ideales":["hsr-lc-23062"],"alternativas":["hsr-lc-23045","hsr-lc-23044","hsr-lc-24000","hsr-lc-21019","hsr-lc-21058"]},"reliquias":[],"ornamentos":[],"principales":null,"secundarias":[]}'::jsonb),
  ('honkai-star-rail', 'hsr-guinaifen', 'General', 'Conos ideales: Buenas noches, que duermas bien.
Otros conos que le van bien: Esas incontables primaveras, Lluvia incesante, Por qué canta el océano, Recuerdos reconstruidos, Sanación solitaria o Solo hay que esperar.
Reliquias (4 piezas): Prisionero aislado, Pistolera de la espiga silvestre o Forjador de lava.
Ornamentos planares: Estación sellaespacios, Entidad comercial pangaláctica o Talia, paraíso de los forajidos.', 'Torso: ATQ %.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Fuego.
Cuerda de unión: ATQ %.
Subestadísticas: ATQ %, VEL, Acierto de efecto.', null, null, '{"conos":{"ideales":["hsr-lc-21001"],"alternativas":["hsr-lc-23029","hsr-lc-23007","hsr-lc-23047","hsr-lc-23022","hsr-lc-24003","hsr-lc-23006"]},"reliquias":["hsr-relic-116","hsr-relic-102","hsr-relic-107"],"ornamentos":["hsr-relic-301","hsr-relic-303","hsr-relic-307"],"principales":{"torso":["ATQ %"],"piernas":["VEL"],"esfera":["Aumento de Daño de Fuego"],"cuerda":["ATQ %"]},"secundarias":["ATQ %","VEL","Acierto de efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-hanya', 'General', 'Conos ideales: Mundo de juegos.
Otros conos que le van bien: La batalla no ha terminado, ¡A bailar!, Aventuras en Villa Ensueño, El pasado y el futuro, Encuentro planetario o Esculpir la luna y tejer las nubes.
Reliquias (4 piezas): Mensajero del espacio hackeado, Pistolera de la espiga silvestre o Sacerdote del calvario revivido.
Ornamentos planares: Lushaka, sumergido bajo el mar, Vonwacq el vivaz o Quilla rota.', 'Torso: PV % o DEF %.
Piernas: VEL.
Esfera de plano: PV % o DEF %.
Cuerda de unión: Recuperación de energía.
Subestadísticas: VEL, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23021"],"alternativas":["hsr-lc-23003","hsr-lc-21018","hsr-lc-21036","hsr-lc-21025","hsr-lc-21011","hsr-lc-21032"]},"reliquias":["hsr-relic-114","hsr-relic-102","hsr-relic-121"],"ornamentos":["hsr-relic-317","hsr-relic-308","hsr-relic-310"],"principales":{"torso":["PV %","DEF %"],"piernas":["VEL"],"esfera":["PV %","DEF %"],"cuerda":["Recuperación de energía"]},"secundarias":["VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-herta', 'General', 'Conos ideales: Antes del amanecer.
Otros conos que le van bien: Cálculo interminable, Instante grabado a fuego, La esperanza no tiene precio, Noche en la Vía Láctea, Día del colapso cósmico o El nacimiento del yo.
Reliquias (4 piezas): Cazador del bosque glacial, Pistolera de la espiga silvestre o Eruditos perdidos en el mar del conocimiento.
Ornamentos planares: Sigonia, desolación sin dueño, Salsotto inerte o Duran, dinastía de lobos raudos.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: ATQ % o VEL.
Esfera de plano: Aumento de Daño de Hielo o ATQ %.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23010"],"alternativas":["hsr-lc-24004","hsr-lc-23018","hsr-lc-23028","hsr-lc-23000","hsr-lc-21040","hsr-lc-21006"]},"reliquias":["hsr-relic-104","hsr-relic-102","hsr-relic-122"],"ornamentos":["hsr-relic-313","hsr-relic-306","hsr-relic-315"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["ATQ %","VEL"],"esfera":["Aumento de Daño de Hielo","ATQ %"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-himeko', 'General', 'Conos ideales: Antes del amanecer.
Otros conos que le van bien: Cálculo interminable, Hacia lo inescrutable, La esperanza no tiene precio, Noche en la Vía Láctea, Día del colapso cósmico o El nacimiento del yo.
Reliquias (4 piezas): Gran duque incinerador, Forjador de lava o Caballería de hierro plaguicida.
Ornamentos planares: Salsotto inerte, Sigonia, desolación sin dueño o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño de Fuego.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23010"],"alternativas":["hsr-lc-24004","hsr-lc-23037","hsr-lc-23028","hsr-lc-23000","hsr-lc-21040","hsr-lc-21006"]},"reliquias":["hsr-relic-115","hsr-relic-107","hsr-relic-119"],"ornamentos":["hsr-relic-306","hsr-relic-313","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño de Fuego"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-himeko-nova', 'General', 'Otros conos que le van bien: Cuando una estrella ilumina la noche, Hacia lo inescrutable, La vida en llamas, Noche en la Vía Láctea, El reposo de los genios o Hoy es otro día tranquilo.
Reliquias (4 piezas): Piloto estelar como Yoveo, Capitán del mar maldito o Forjador de lava.
Ornamentos planares: Punto de partida de la estrella caída, Salsotto inerte o Parque de Platanolandia.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: ATQ % o VEL.
Esfera de plano: Aumento de Daño de Fuego o ATQ %.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23060","hsr-lc-23037","hsr-lc-23041","hsr-lc-23000","hsr-lc-21020","hsr-lc-21034"]},"reliquias":["hsr-relic-131","hsr-relic-126","hsr-relic-107"],"ornamentos":["hsr-relic-327","hsr-relic-306","hsr-relic-318"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["ATQ %","VEL"],"esfera":["Aumento de Daño de Fuego","ATQ %"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-hook', 'General', 'Conos ideales: Sobre la caída de un Eón.
Otros conos que le van bien: Algo insustituible, ¡Guau! ¡Hora de pasear!, Bajo el cielo azul, Los Topos te dan la bienvenida o Colapso celeste.
Reliquias (4 piezas): Buceadora pionera del agua muerta, Eruditos perdidos en el mar del conocimiento o Forjador de lava.
Ornamentos planares: Estación sellaespacios, Arena rutilante o Diferenciador celestial.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Fuego.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-24000"],"alternativas":["hsr-lc-23002","hsr-lc-21026","hsr-lc-21019","hsr-lc-21005","hsr-lc-20002"]},"reliquias":["hsr-relic-117","hsr-relic-122","hsr-relic-107"],"ornamentos":["hsr-relic-301","hsr-relic-309","hsr-relic-305"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño de Fuego"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-huohuo', 'General', 'Conos ideales: Noche terrorífica.
Otros conos que le van bien: El tiempo no espera, Conversación en el postoperatorio, El momento oportuno, Ey, estoy aquí, Hasta pasado mañana o Sentimiento compartido.
Reliquias (4 piezas): Transeúnte de la nube pasajera, Mensajero del espacio hackeado o Águila del crepúsculo.
Ornamentos planares: Flota de los eternos, Quilla rota o Lushaka, sumergido bajo el mar.', 'Torso: Bonif. curación realizada o PV %.
Piernas: VEL.
Esfera de plano: PV %.
Cuerda de unión: Recuperación de energía.
Subestadísticas: PV %, VEL, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23017"],"alternativas":["hsr-lc-23013","hsr-lc-21000","hsr-lc-21014","hsr-lc-22001","hsr-lc-21055","hsr-lc-21007"]},"reliquias":["hsr-relic-101","hsr-relic-114","hsr-relic-110"],"ornamentos":["hsr-relic-302","hsr-relic-310","hsr-relic-317"],"principales":{"torso":["Bonif. curación realizada","PV %"],"piernas":["VEL"],"esfera":["PV %"],"cuerda":["Recuperación de energía"]},"secundarias":["PV %","VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-hyacine', 'General', 'Conos ideales: Que el arcoíris siempre esté en el cielo.
Otros conos que le van bien: Amor eterno como este momento o La siguiente página de la historia.
Reliquias (4 piezas): Guerrera celestial del sol y el trueno, Transeúnte de la nube pasajera o Mensajero del espacio hackeado.
Ornamentos planares: Árbol gigante en meditación profunda, Flota de los eternos o Vonwacq el vivaz.', 'Torso: Bonif. curación realizada.
Piernas: VEL.
Esfera de plano: PV %.
Cuerda de unión: Recuperación de energía o PV %.
Subestadísticas: PV %, VEL, RES a efecto, Daño CRIT.', null, null, '{"conos":{"ideales":["hsr-lc-23042"],"alternativas":["hsr-lc-23052","hsr-lc-21054"]},"reliquias":["hsr-relic-125","hsr-relic-101","hsr-relic-114"],"ornamentos":["hsr-relic-320","hsr-relic-302","hsr-relic-308"],"principales":{"torso":["Bonif. curación realizada"],"piernas":["VEL"],"esfera":["PV %"],"cuerda":["Recuperación de energía","PV %"]},"secundarias":["PV %","VEL","RES a efecto","Daño CRIT"]}'::jsonb),
  ('honkai-star-rail', 'hsr-hysilens', 'General', 'Conos ideales: Por qué canta el océano.
Reliquias (4 piezas): Prisionero aislado, Campeona de boxeo callejero o Pistolera de la espiga silvestre.
Ornamentos planares: Litoral embriagado, Estación sellaespacios o Glamoth, frente del firmamento.', 'Torso: Acierto de efecto o ATQ %.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño Físico.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: Acierto de efecto, VEL, ATQ %.', null, null, '{"conos":{"ideales":["hsr-lc-23047"],"alternativas":[]},"reliquias":["hsr-relic-116","hsr-relic-105","hsr-relic-102"],"ornamentos":["hsr-relic-322","hsr-relic-301","hsr-relic-311"],"principales":{"torso":["Acierto de efecto","ATQ %"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño Físico"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["Acierto de efecto","VEL","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-jade', 'General', 'Otros conos que le van bien: Antes del amanecer, Cálculo interminable, La esperanza no tiene precio, Noche en la Vía Láctea, El reposo de los genios o Hoy es otro día tranquilo.
Reliquias (4 piezas): Genio de las estrellas relucientes, Gran duque incinerador o Pistolera de la espiga silvestre.
Ornamentos planares: Sigonia, desolación sin dueño, Salsotto inerte o Estación sellaespacios.', 'Torso: Prob. CRIT.
Piernas: ATQ % o VEL.
Esfera de plano: Aumento de Daño Cuántico.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23010","hsr-lc-24004","hsr-lc-23028","hsr-lc-23000","hsr-lc-21020","hsr-lc-21034"]},"reliquias":["hsr-relic-108","hsr-relic-115","hsr-relic-102"],"ornamentos":["hsr-relic-313","hsr-relic-306","hsr-relic-301"],"principales":{"torso":["Prob. CRIT"],"piernas":["ATQ %","VEL"],"esfera":["Aumento de Daño Cuántico"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-jiaoqiu', 'General', 'Conos ideales: Esas incontables primaveras.
Otros conos que le van bien: Lluvia incesante, Mentiras que vuelan en el viento, Sanación solitaria, Antes de que comience la misión del tutorial, Determinación reluciente o Vacaciones en las termas.
Reliquias (4 piezas): Prisionero aislado, Águila del crepúsculo o Guardia de la nieve borrascosa.
Ornamentos planares: Entidad comercial pangaláctica, Flota de los eternos o Vonwacq el vivaz.', 'Torso: Acierto de efecto.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Fuego.
Cuerda de unión: Recuperación de energía.
Subestadísticas: Acierto de efecto, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23029"],"alternativas":["hsr-lc-23007","hsr-lc-23043","hsr-lc-24003","hsr-lc-22000","hsr-lc-21015","hsr-lc-21061"]},"reliquias":["hsr-relic-116","hsr-relic-110","hsr-relic-106"],"ornamentos":["hsr-relic-303","hsr-relic-302","hsr-relic-308"],"principales":{"torso":["Acierto de efecto"],"piernas":["VEL"],"esfera":["Aumento de Daño de Fuego"],"cuerda":["Recuperación de energía"]},"secundarias":["Acierto de efecto","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-jing-yuan', 'General', 'Conos ideales: Antes del amanecer.
Otros conos que le van bien: Cálculo interminable, La esperanza no tiene precio, Noche en la Vía Láctea, Día del colapso cósmico, El nacimiento del yo o El reposo de los genios.
Reliquias (4 piezas): Gran duque incinerador, Banda del trueno crepitante o Eruditos perdidos en el mar del conocimiento.
Ornamentos planares: Parque de Platanolandia, Salsotto inerte o Sigonia, desolación sin dueño.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Rayo.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23010"],"alternativas":["hsr-lc-24004","hsr-lc-23028","hsr-lc-23000","hsr-lc-21040","hsr-lc-21006","hsr-lc-21020"]},"reliquias":["hsr-relic-115","hsr-relic-109","hsr-relic-122"],"ornamentos":["hsr-relic-318","hsr-relic-306","hsr-relic-313"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño de Rayo"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-jingliu', 'General', 'Otros conos que le van bien: Algo insustituible, Sangre y fuego, abran camino, Sobre la caída de un Eón, Yo seré mi propia espada, Bajo el cielo azul o Grabación ninja: Cacería del Sonido.
Reliquias (4 piezas): Eruditos perdidos en el mar del conocimiento, Cazador del bosque glacial o Genio de las estrellas relucientes.
Ornamentos planares: Osario sereno, Arena rutilante o Salsotto inerte.', 'Torso: PV % o Daño CRIT.
Piernas: VEL o PV %.
Esfera de plano: Aumento de Daño de Hielo.
Cuerda de unión: Recuperación de energía o PV %.
Subestadísticas: Prob. CRIT, Daño CRIT, PV %, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23002","hsr-lc-23039","hsr-lc-24000","hsr-lc-23014","hsr-lc-21019","hsr-lc-22003"]},"reliquias":["hsr-relic-122","hsr-relic-104","hsr-relic-108"],"ornamentos":["hsr-relic-319","hsr-relic-309","hsr-relic-306"],"principales":{"torso":["PV %","Daño CRIT"],"piernas":["VEL","PV %"],"esfera":["Aumento de Daño de Hielo"],"cuerda":["Recuperación de energía","PV %"]},"secundarias":["Prob. CRIT","Daño CRIT","PV %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-kafka', 'General', 'Conos ideales: Solo hay que esperar.
Otros conos que le van bien: En nombre del mundo, Lluvia incesante, Por qué canta el océano, Recuerdos reconstruidos, Arriba el telón o Buenas noches, que duermas bien.
Reliquias (4 piezas): Prisionero aislado, Banda del trueno crepitante o Pistolera de la espiga silvestre.
Ornamentos planares: Litoral embriagado, Glamoth, frente del firmamento o Estación sellaespacios.', 'Torso: Acierto de efecto o ATQ %.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Rayo o ATQ %.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: ATQ %, VEL, Acierto de efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23006"],"alternativas":["hsr-lc-23004","hsr-lc-23007","hsr-lc-23047","hsr-lc-23022","hsr-lc-21041","hsr-lc-21001"]},"reliquias":["hsr-relic-116","hsr-relic-109","hsr-relic-102"],"ornamentos":["hsr-relic-322","hsr-relic-311","hsr-relic-301"],"principales":{"torso":["Acierto de efecto","ATQ %"],"piernas":["VEL"],"esfera":["Aumento de Daño de Rayo","ATQ %"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["ATQ %","VEL","Acierto de efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-the-dahlia', 'General', 'Conos ideales: No olvides su fuego.
Otros conos que le van bien: Vacaciones en las termas.
Reliquias (4 piezas): Caballería de hierro plaguicida, Ladrón del rastro meteórico o Relojero de maquinaciones oníricas.
Ornamentos planares: Fragua de la linterna Kalpagni, Vonwacq el vivaz o Talia, paraíso de los forajidos.', 'Torso: PV % o DEF %.
Piernas: VEL.
Esfera de plano: PV % o DEF %.
Cuerda de unión: Efecto de Ruptura o Recuperación de energía.
Subestadísticas: Efecto de Ruptura, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23050"],"alternativas":["hsr-lc-21061"]},"reliquias":["hsr-relic-119","hsr-relic-111","hsr-relic-118"],"ornamentos":["hsr-relic-316","hsr-relic-308","hsr-relic-307"],"principales":{"torso":["PV %","DEF %"],"piernas":["VEL"],"esfera":["PV %","DEF %"],"cuerda":["Efecto de Ruptura","Recuperación de energía"]},"secundarias":["Efecto de Ruptura","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-lingsha', 'General', 'Otros conos que le van bien: Ecos del ataúd, Noche terrorífica, Solo la fragancia perdura, Conversación en el postoperatorio, Cuestión de verdad o Hasta pasado mañana.
Reliquias (4 piezas): Caballería de hierro plaguicida, Ladrón del rastro meteórico o Transeúnte de la nube pasajera.
Ornamentos planares: Fragua de la linterna Kalpagni, Talia, paraíso de los forajidos o Flota de los eternos.', 'Torso: Bonif. curación realizada.
Piernas: VEL.
Esfera de plano: ATQ %.
Cuerda de unión: Recuperación de energía o Efecto de Ruptura.
Subestadísticas: Efecto de Ruptura, VEL, ATQ %.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23008","hsr-lc-23017","hsr-lc-23032","hsr-lc-21000","hsr-lc-21035","hsr-lc-21055"]},"reliquias":["hsr-relic-119","hsr-relic-111","hsr-relic-101"],"ornamentos":["hsr-relic-316","hsr-relic-307","hsr-relic-302"],"principales":{"torso":["Bonif. curación realizada"],"piernas":["VEL"],"esfera":["ATQ %"],"cuerda":["Recuperación de energía","Efecto de Ruptura"]},"secundarias":["Efecto de Ruptura","VEL","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-luka', 'General', 'Conos ideales: Buenas noches, que duermas bien.
Otros conos que le van bien: En nombre del mundo, Esas incontables primaveras, Lluvia incesante, Por qué canta el océano, Sanación solitaria o Antes de que comience la misión del tutorial.
Reliquias (4 piezas): Campeona de boxeo callejero, Prisionero aislado o Pistolera de la espiga silvestre.
Ornamentos planares: Estación sellaespacios, Talia, paraíso de los forajidos o Arena rutilante.', 'Torso: ATQ %.
Piernas: VEL.
Esfera de plano: Aumento de Daño Físico.
Cuerda de unión: ATQ %.
Subestadísticas: ATQ %, VEL, Efecto de Ruptura, Prob. CRIT, Daño CRIT.', null, null, '{"conos":{"ideales":["hsr-lc-21001"],"alternativas":["hsr-lc-23004","hsr-lc-23029","hsr-lc-23007","hsr-lc-23047","hsr-lc-24003","hsr-lc-22000"]},"reliquias":["hsr-relic-105","hsr-relic-116","hsr-relic-102"],"ornamentos":["hsr-relic-301","hsr-relic-307","hsr-relic-309"],"principales":{"torso":["ATQ %"],"piernas":["VEL"],"esfera":["Aumento de Daño Físico"],"cuerda":["ATQ %"]},"secundarias":["ATQ %","VEL","Efecto de Ruptura","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('honkai-star-rail', 'hsr-luocha', 'General', 'Otros conos que le van bien: Ecos del ataúd, El tiempo no espera, Noche terrorífica, Solo la fragancia perdura, Conversación en el postoperatorio o El momento oportuno.
Reliquias (4 piezas): Transeúnte de la nube pasajera, Sacerdote del calvario revivido o Pistolera de la espiga silvestre.
Ornamentos planares: Estación sellaespacios, Lushaka, sumergido bajo el mar o Vonwacq el vivaz.', 'Torso: Bonif. curación realizada o ATQ %.
Piernas: VEL.
Esfera de plano: ATQ %.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: ATQ %, VEL, RES a efecto.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23008","hsr-lc-23013","hsr-lc-23017","hsr-lc-23032","hsr-lc-21000","hsr-lc-21014"]},"reliquias":["hsr-relic-101","hsr-relic-121","hsr-relic-102"],"ornamentos":["hsr-relic-301","hsr-relic-317","hsr-relic-308"],"principales":{"torso":["Bonif. curación realizada","ATQ %"],"piernas":["VEL"],"esfera":["ATQ %"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["ATQ %","VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-lynx', 'General', 'Conos ideales: Noche terrorífica.
Otros conos que le van bien: El tiempo no espera, Conversación en el postoperatorio, El momento oportuno, Hasta pasado mañana, Intercambio equivalente o Las noches cálidas no duran.
Reliquias (4 piezas): Transeúnte de la nube pasajera, Mensajero del espacio hackeado o Guardia de la nieve borrascosa.
Ornamentos planares: Flota de los eternos, Quilla rota o Lushaka, sumergido bajo el mar.', 'Torso: Bonif. curación realizada o PV %.
Piernas: VEL.
Esfera de plano: PV %.
Cuerda de unión: PV % o Recuperación de energía.
Subestadísticas: PV %, VEL, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23017"],"alternativas":["hsr-lc-23013","hsr-lc-21000","hsr-lc-21014","hsr-lc-21055","hsr-lc-21021","hsr-lc-21028"]},"reliquias":["hsr-relic-101","hsr-relic-114","hsr-relic-106"],"ornamentos":["hsr-relic-302","hsr-relic-310","hsr-relic-317"],"principales":{"torso":["Bonif. curación realizada","PV %"],"piernas":["VEL"],"esfera":["PV %"],"cuerda":["PV %","Recuperación de energía"]},"secundarias":["PV %","VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-march-7th', 'General', 'Conos ideales: El momento de la victoria.
Otros conos que le van bien: El destino nunca es justo, ¡Así soy yo!, El primer día del resto de mi vida, La elección de Landau, Que tu viaje sea siempre pacífico o Tendencias del mercado universal.
Reliquias (4 piezas): Paladina de la Iglesia de la Corte Inmaculada, Eremita aislado en las estrellas o Guardia de la nieve borrascosa.
Ornamentos planares: La Belobog de los Arquitectos, Quilla rota o Lushaka, sumergido bajo el mar.', 'Torso: DEF % o Acierto de efecto.
Piernas: VEL o DEF %.
Esfera de plano: DEF %.
Cuerda de unión: DEF %.
Subestadísticas: DEF %, VEL, Acierto de efecto, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23005"],"alternativas":["hsr-lc-23023","hsr-lc-21030","hsr-lc-21002","hsr-lc-21009","hsr-lc-21053","hsr-lc-21016"]},"reliquias":["hsr-relic-103","hsr-relic-128","hsr-relic-106"],"ornamentos":["hsr-relic-304","hsr-relic-310","hsr-relic-317"],"principales":{"torso":["DEF %","Acierto de efecto"],"piernas":["VEL","DEF %"],"esfera":["DEF %"],"cuerda":["DEF %"]},"secundarias":["DEF %","VEL","Acierto de efecto","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-march-7th-imaginaria', 'General', 'Conos ideales: En la noche o Hacia una segunda vida.
Otros conos que le van bien: Crucero estelar, Dormir como un tronco, El bautismo del pensamiento puro, El final de una mentira, Me voy de caza o ¡Suscríbanse a mi canal!.
Reliquias (4 piezas): Pistolera de la espiga silvestre, Habitante del yermo de los bandidos o Buceadora pionera del agua muerta.
Ornamentos planares: Arena rutilante, Izumo gensei y reino divino de Takama o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño Imaginario.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23001","hsr-lc-23027"],"alternativas":["hsr-lc-24001","hsr-lc-23012","hsr-lc-23020","hsr-lc-23056","hsr-lc-23031","hsr-lc-21017"]},"reliquias":["hsr-relic-102","hsr-relic-112","hsr-relic-117"],"ornamentos":["hsr-relic-309","hsr-relic-314","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño Imaginario"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-misha', 'General', 'Conos ideales: Sobre la caída de un Eón.
Otros conos que le van bien: Bajo el cielo azul, Juramento secreto, Los Topos te dan la bienvenida, Promesa grabada, Sangre del pasado o Sin escapatoria.
Reliquias (4 piezas): Cazador del bosque glacial, Eruditos perdidos en el mar del conocimiento o Pistolera de la espiga silvestre.
Ornamentos planares: Salsotto inerte, Estación sellaespacios o Glamoth, frente del firmamento.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño de Hielo.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-24000"],"alternativas":["hsr-lc-21019","hsr-lc-21012","hsr-lc-21005","hsr-lc-21042","hsr-lc-21058","hsr-lc-21033"]},"reliquias":["hsr-relic-104","hsr-relic-122","hsr-relic-102"],"ornamentos":["hsr-relic-306","hsr-relic-301","hsr-relic-311"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño de Hielo"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-mortenax-blade', 'General', 'Otros conos que le van bien: Mentiras que vuelan en el viento, Nuevo cuerpo del averno ardiente, Antes de que comience la misión del tutorial, Buenas noches, que duermas bien, Determinación reluciente o Vacaciones en las termas.
Reliquias (4 piezas): Gran forja del interrogante divino, Buceadora pionera del agua muerta o Discípula longeva.
Ornamentos planares: Osario sereno, Salsotto inerte o Duran, dinastía de lobos raudos.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o PV %.
Esfera de plano: Aumento de Daño de Fuego o PV %.
Cuerda de unión: PV % o Recuperación de energía.
Subestadísticas: PV %, Prob. CRIT, Daño CRIT, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23043","hsr-lc-23059","hsr-lc-22000","hsr-lc-21001","hsr-lc-21015","hsr-lc-21061"]},"reliquias":["hsr-relic-132","hsr-relic-117","hsr-relic-113"],"ornamentos":["hsr-relic-319","hsr-relic-306","hsr-relic-315"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","PV %"],"esfera":["Aumento de Daño de Fuego","PV %"],"cuerda":["PV %","Recuperación de energía"]},"secundarias":["PV %","Prob. CRIT","Daño CRIT","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-moze', 'General', 'Otros conos que le van bien: Crucero estelar, Dormir como un tronco, El bautismo del pensamiento puro, El final de una mentira, Me voy de caza o Preocupaciones y felicidad.
Reliquias (4 piezas): Buceadora pionera del agua muerta, Banda del trueno crepitante o Intrépida cabalgavientos.
Ornamentos planares: Duran, dinastía de lobos raudos, Izumo gensei y reino divino de Takama o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño de Rayo.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-24001","hsr-lc-23012","hsr-lc-23020","hsr-lc-23056","hsr-lc-23031","hsr-lc-23016"]},"reliquias":["hsr-relic-117","hsr-relic-109","hsr-relic-120"],"ornamentos":["hsr-relic-315","hsr-relic-314","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño de Rayo"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-mydei', 'General', 'Otros conos que le van bien: Sangre y fuego, abran camino, Grabación ninja: Cacería del Sonido o Sangre del pasado.
Reliquias (4 piezas): Eruditos perdidos en el mar del conocimiento, Discípula longeva o Habitante del yermo de los bandidos.
Ornamentos planares: Osario sereno, Arena rutilante o Flota de los eternos.', 'Torso: PV % o Daño CRIT.
Piernas: VEL o PV %.
Esfera de plano: Aumento de Daño Imaginario o PV %.
Cuerda de unión: PV %.
Subestadísticas: Prob. CRIT, Daño CRIT, PV %, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23039","hsr-lc-22003","hsr-lc-21058"]},"reliquias":["hsr-relic-122","hsr-relic-113","hsr-relic-112"],"ornamentos":["hsr-relic-319","hsr-relic-309","hsr-relic-302"],"principales":{"torso":["PV %","Daño CRIT"],"piernas":["VEL","PV %"],"esfera":["Aumento de Daño Imaginario","PV %"],"cuerda":["PV %"]},"secundarias":["Prob. CRIT","Daño CRIT","PV %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-natasha', 'General', 'Conos ideales: Noche terrorífica.
Otros conos que le van bien: El tiempo no espera, Conversación en el postoperatorio, Hasta pasado mañana, Intercambio equivalente, Las noches cálidas no duran o Sentimiento compartido.
Reliquias (4 piezas): Transeúnte de la nube pasajera, Mensajero del espacio hackeado o Sacerdote del calvario revivido.
Ornamentos planares: Flota de los eternos, Lushaka, sumergido bajo el mar o Quilla rota.', 'Torso: Bonif. curación realizada o PV %.
Piernas: VEL.
Esfera de plano: PV %.
Cuerda de unión: PV % o Recuperación de energía.
Subestadísticas: PV %, VEL, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23017"],"alternativas":["hsr-lc-23013","hsr-lc-21000","hsr-lc-21055","hsr-lc-21021","hsr-lc-21028","hsr-lc-21007"]},"reliquias":["hsr-relic-101","hsr-relic-114","hsr-relic-121"],"ornamentos":["hsr-relic-302","hsr-relic-317","hsr-relic-310"],"principales":{"torso":["Bonif. curación realizada","PV %"],"piernas":["VEL"],"esfera":["PV %"],"cuerda":["PV %","Recuperación de energía"]},"secundarias":["PV %","VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-pela', 'General', 'Conos ideales: Antes de que comience la misión del tutorial.
Otros conos que le van bien: En nombre del mundo, Esas incontables primaveras, Lluvia incesante, Mentiras que vuelan en el viento, Buenas noches, que duermas bien o Determinación reluciente.
Reliquias (4 piezas): Cazador del bosque glacial, Guardia de la nieve borrascosa o Águila del crepúsculo.
Ornamentos planares: Colonipenal, la tierra de los sueños, Quilla rota o Vonwacq el vivaz.', 'Torso: Acierto de efecto o Prob. CRIT.
Piernas: VEL.
Esfera de plano: PV % o Aumento de Daño de Hielo.
Cuerda de unión: Recuperación de energía.
Subestadísticas: VEL, Acierto de efecto, Prob. CRIT, Daño CRIT, ATQ %.', null, null, '{"conos":{"ideales":["hsr-lc-22000"],"alternativas":["hsr-lc-23004","hsr-lc-23029","hsr-lc-23007","hsr-lc-23043","hsr-lc-21001","hsr-lc-21015"]},"reliquias":["hsr-relic-104","hsr-relic-106","hsr-relic-110"],"ornamentos":["hsr-relic-312","hsr-relic-310","hsr-relic-308"],"principales":{"torso":["Acierto de efecto","Prob. CRIT"],"piernas":["VEL"],"esfera":["PV %","Aumento de Daño de Hielo"],"cuerda":["Recuperación de energía"]},"secundarias":["VEL","Acierto de efecto","Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-phainon', 'General', 'Conos ideales: Que arda el alba.
Otros conos que le van bien: Sangre del pasado.
Reliquias (4 piezas): Capitán del mar maldito, Campeona de boxeo callejero o Eruditos perdidos en el mar del conocimiento.
Ornamentos planares: Paraíso de las hadas tejesueños, Arena rutilante o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: ATQ %.
Esfera de plano: Aumento de Daño Físico o ATQ %.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %.', null, null, '{"conos":{"ideales":["hsr-lc-23044"],"alternativas":["hsr-lc-21058"]},"reliquias":["hsr-relic-126","hsr-relic-105","hsr-relic-122"],"ornamentos":["hsr-relic-321","hsr-relic-309","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["ATQ %"],"esfera":["Aumento de Daño Físico","ATQ %"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-qingque', 'General', 'Conos ideales: Antes del amanecer.
Otros conos que le van bien: Cálculo interminable, Instante grabado a fuego, Noche en la Vía Láctea, Día del colapso cósmico, El reposo de los genios o Hoy es otro día tranquilo.
Reliquias (4 piezas): Genio de las estrellas relucientes, Pistolera de la espiga silvestre o Ladrón del rastro meteórico.
Ornamentos planares: Arena rutilante, Diferenciador celestial o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño Cuántico.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23010"],"alternativas":["hsr-lc-24004","hsr-lc-23018","hsr-lc-23000","hsr-lc-21040","hsr-lc-21020","hsr-lc-21034"]},"reliquias":["hsr-relic-108","hsr-relic-102","hsr-relic-111"],"ornamentos":["hsr-relic-309","hsr-relic-305","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño Cuántico"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-rappa', 'General', 'Conos ideales: Pergamino ninja: Azote deslumbrante del mal.
Otros conos que le van bien: Que el mundo clame o Tras el silencio de La Armonía.
Reliquias (4 piezas): Caballería de hierro plaguicida, Ladrón del rastro meteórico o Relojero de maquinaciones oníricas.
Ornamentos planares: Talia, paraíso de los forajidos, Fragua de la linterna Kalpagni o Estación sellaespacios.', 'Torso: ATQ %.
Piernas: VEL.
Esfera de plano: ATQ %.
Cuerda de unión: Efecto de Ruptura o Recuperación de energía.
Subestadísticas: Efecto de Ruptura, VEL, ATQ %.', null, null, '{"conos":{"ideales":["hsr-lc-23033"],"alternativas":["hsr-lc-21013","hsr-lc-21045"]},"reliquias":["hsr-relic-119","hsr-relic-111","hsr-relic-118"],"ornamentos":["hsr-relic-307","hsr-relic-316","hsr-relic-301"],"principales":{"torso":["ATQ %"],"piernas":["VEL"],"esfera":["ATQ %"],"cuerda":["Efecto de Ruptura","Recuperación de energía"]},"secundarias":["Efecto de Ruptura","VEL","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-rin-tohsaka', 'General', 'Otros conos que le van bien: Cálculo interminable, Destelleos silentes, Hacia lo inescrutable, La vida en llamas, Día del colapso cósmico o Hoy es otro día tranquilo.', null, null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-24004","hsr-lc-23061","hsr-lc-23037","hsr-lc-23041","hsr-lc-21040","hsr-lc-21034"]},"reliquias":[],"ornamentos":[],"principales":null,"secundarias":[]}'::jsonb),
  ('honkai-star-rail', 'hsr-robin', 'General', 'Conos ideales: Luces de la noche.
Otros conos que le van bien: La batalla no ha terminado, Mi pasado en el espejo, El pasado y el futuro, Esculpir la luna y tejer las nubes, Imagen en el recuerdo o Juventud por florecer.
Reliquias (4 piezas): Pistolera de la espiga silvestre, Campeona de boxeo callejero o Prisionero aislado.
Ornamentos planares: Flota de los eternos, Estación sellaespacios o Vonwacq el vivaz.', 'Torso: ATQ %.
Piernas: ATQ %.
Esfera de plano: ATQ % o Aumento de Daño Físico.
Cuerda de unión: Recuperación de energía.
Subestadísticas: ATQ %, ATQ, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23026"],"alternativas":["hsr-lc-23003","hsr-lc-23019","hsr-lc-21025","hsr-lc-21032","hsr-lc-21004","hsr-lc-21046"]},"reliquias":["hsr-relic-102","hsr-relic-105","hsr-relic-116"],"ornamentos":["hsr-relic-302","hsr-relic-301","hsr-relic-308"],"principales":{"torso":["ATQ %"],"piernas":["ATQ %"],"esfera":["ATQ %","Aumento de Daño Físico"],"cuerda":["Recuperación de energía"]},"secundarias":["ATQ %","ATQ","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-robin-summeretto', 'General', 'Otros conos que le van bien: A la estrella de la larga noche, El tiempo no espera, Levántate y canta, Que el arcoíris siempre esté en el cielo, Sobre los recuerdos nunca cae el telón o La siguiente página de la historia.
Reliquias (4 piezas): Salvado{F#ra}{M#r} que reforja el mundo, Sacerdote del calvario revivido o Mensajero del espacio hackeado.
Ornamentos planares: Amphoreus, la tierra eterna, Vonwacq el vivaz o Lushaka, sumergido bajo el mar.', 'Torso: PV % o Daño CRIT.
Piernas: VEL o PV %.
Esfera de plano: PV % o Aumento de Daño de Viento.
Cuerda de unión: Recuperación de energía o PV %.
Subestadísticas: Prob. CRIT, Daño CRIT, PV %, VEL.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23049","hsr-lc-23013","hsr-lc-23063","hsr-lc-23042","hsr-lc-24005","hsr-lc-21054"]},"reliquias":["hsr-relic-127","hsr-relic-121","hsr-relic-114"],"ornamentos":["hsr-relic-323","hsr-relic-308","hsr-relic-317"],"principales":{"torso":["PV %","Daño CRIT"],"piernas":["VEL","PV %"],"esfera":["PV %","Aumento de Daño de Viento"],"cuerda":["Recuperación de energía","PV %"]},"secundarias":["Prob. CRIT","Daño CRIT","PV %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-ruan-mei', 'General', 'Conos ideales: Imagen en el recuerdo.
Otros conos que le van bien: La batalla no ha terminado, Mi pasado en el espejo, ¡A bailar!, Al perseguir el viento, Encuentro planetario o Esculpir la luna y tejer las nubes.
Reliquias (4 piezas): Relojero de maquinaciones oníricas, Ladrón del rastro meteórico o Mensajero del espacio hackeado.
Ornamentos planares: Talia, paraíso de los forajidos, Colonipenal, la tierra de los sueños o Vonwacq el vivaz.', 'Torso: PV % o DEF %.
Piernas: VEL.
Esfera de plano: PV % o DEF %.
Cuerda de unión: Efecto de Ruptura o Recuperación de energía.
Subestadísticas: Efecto de Ruptura, VEL, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-21004"],"alternativas":["hsr-lc-23003","hsr-lc-23019","hsr-lc-21018","hsr-lc-21056","hsr-lc-21011","hsr-lc-21032"]},"reliquias":["hsr-relic-118","hsr-relic-111","hsr-relic-114"],"ornamentos":["hsr-relic-307","hsr-relic-312","hsr-relic-308"],"principales":{"torso":["PV %","DEF %"],"piernas":["VEL"],"esfera":["PV %","DEF %"],"cuerda":["Efecto de Ruptura","Recuperación de energía"]},"secundarias":["Efecto de Ruptura","VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-saber', 'General', 'Conos ideales: Coronación sin agradecimiento.
Otros conos que le van bien: Soy lo que ves.', null, null, null, '{"conos":{"ideales":["hsr-lc-23045"],"alternativas":["hsr-lc-23062"]},"reliquias":[],"ornamentos":[],"principales":null,"secundarias":[]}'::jsonb),
  ('honkai-star-rail', 'hsr-sampo', 'General', 'Conos ideales: Buenas noches, que duermas bien.
Otros conos que le van bien: En nombre del mundo, Esas incontables primaveras, Por qué canta el océano, Sanación solitaria, Calderón o Determinación reluciente.
Reliquias (4 piezas): Águila del crepúsculo, Prisionero aislado o Pistolera de la espiga silvestre.
Ornamentos planares: Estación sellaespacios, Entidad comercial pangaláctica o Glamoth, frente del firmamento.', 'Torso: ATQ %.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Viento.
Cuerda de unión: ATQ %.
Subestadísticas: ATQ %, VEL, Acierto de efecto.', null, null, '{"conos":{"ideales":["hsr-lc-21001"],"alternativas":["hsr-lc-23004","hsr-lc-23029","hsr-lc-23047","hsr-lc-24003","hsr-lc-21022","hsr-lc-21015"]},"reliquias":["hsr-relic-110","hsr-relic-116","hsr-relic-102"],"ornamentos":["hsr-relic-301","hsr-relic-303","hsr-relic-311"],"principales":{"torso":["ATQ %"],"piernas":["VEL"],"esfera":["Aumento de Daño de Viento"],"cuerda":["ATQ %"]},"secundarias":["ATQ %","VEL","Acierto de efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-seele', 'General', 'Conos ideales: En la noche.
Otros conos que le van bien: Crucero estelar, Dormir como un tronco, Infierno donde arden los ideales, El río nace en primavera, Ganador final o Juego de espadas.
Reliquias (4 piezas): Genio de las estrellas relucientes, Eruditos perdidos en el mar del conocimiento o Pistolera de la espiga silvestre.
Ornamentos planares: Glamoth, frente del firmamento, Estación sellaespacios o Salsotto inerte.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño Cuántico o ATQ %.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23001"],"alternativas":["hsr-lc-24001","hsr-lc-23012","hsr-lc-23046","hsr-lc-21024","hsr-lc-21037","hsr-lc-21010"]},"reliquias":["hsr-relic-108","hsr-relic-122","hsr-relic-102"],"ornamentos":["hsr-relic-311","hsr-relic-301","hsr-relic-306"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño Cuántico","ATQ %"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-serval', 'General', 'Conos ideales: Antes del amanecer.
Otros conos que le van bien: Cálculo interminable, Hacia lo inescrutable, Instante grabado a fuego, Noche en la Vía Láctea, Pergamino ninja: Azote deslumbrante del mal o Día del colapso cósmico.
Reliquias (4 piezas): Banda del trueno crepitante, Buceadora pionera del agua muerta o Eruditos perdidos en el mar del conocimiento.
Ornamentos planares: Estación sellaespacios, Salsotto inerte o Sigonia, desolación sin dueño.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Rayo o ATQ %.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23010"],"alternativas":["hsr-lc-24004","hsr-lc-23037","hsr-lc-23018","hsr-lc-23000","hsr-lc-23033","hsr-lc-21040"]},"reliquias":["hsr-relic-109","hsr-relic-117","hsr-relic-122"],"ornamentos":["hsr-relic-301","hsr-relic-306","hsr-relic-313"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño de Rayo","ATQ %"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-silver-wolf', 'General', 'Conos ideales: Lluvia incesante o Antes de que comience la misión del tutorial.
Otros conos que le van bien: En nombre del mundo, Buenas noches, que duermas bien, Determinación reluciente, Vacaciones en las termas, Volveremos a encontrarnos o Vacío.
Reliquias (4 piezas): Genio de las estrellas relucientes, Ladrón del rastro meteórico o Buceadora pionera del agua muerta.
Ornamentos planares: Colonipenal, la tierra de los sueños, Entidad comercial pangaláctica o Talia, paraíso de los forajidos.', 'Torso: Acierto de efecto o Prob. CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño Cuántico.
Cuerda de unión: Recuperación de energía.
Subestadísticas: VEL, Acierto de efecto, Prob. CRIT, Daño CRIT, ATQ %.', null, null, '{"conos":{"ideales":["hsr-lc-23007","hsr-lc-22000"],"alternativas":["hsr-lc-23004","hsr-lc-21001","hsr-lc-21015","hsr-lc-21061","hsr-lc-21029","hsr-lc-20004"]},"reliquias":["hsr-relic-108","hsr-relic-111","hsr-relic-117"],"ornamentos":["hsr-relic-312","hsr-relic-303","hsr-relic-307"],"principales":{"torso":["Acierto de efecto","Prob. CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño Cuántico"],"cuerda":["Recuperación de energía"]},"secundarias":["VEL","Acierto de efecto","Prob. CRIT","Daño CRIT","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-silver-wolf-lv999', 'General', 'Otros conos que le van bien: Bienvenidos a la ciudad cósmica, Juntos hacia el futuro, La buena suerte de hoy, Las aventuras de Champigaga o Un breve descanso.
Reliquias (4 piezas): Chica mágica de hazañas gloriosas, Capitán del mar maldito o Habitante del yermo de los bandidos.
Ornamentos planares: Etapa cero de Punklorde, Sigonia, desolación sin dueño o Tengoku@sala de chat.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: PV % o DEF %.
Cuerda de unión: DEF % o PV %.
Subestadísticas: VEL, Prob. CRIT, Daño CRIT.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23057","hsr-lc-22007","hsr-lc-21065","hsr-lc-21064","hsr-lc-21066"]},"reliquias":["hsr-relic-129","hsr-relic-126","hsr-relic-112"],"ornamentos":["hsr-relic-325","hsr-relic-313","hsr-relic-324"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["PV %","DEF %"],"cuerda":["DEF %","PV %"]},"secundarias":["VEL","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('honkai-star-rail', 'hsr-sparkle', 'General', 'Conos ideales: Mundo de juegos.
Otros conos que le van bien: De vuelta a la tierra, Infierno donde arden los ideales, La batalla no ha terminado, ¡A bailar!, Aventuras en Villa Ensueño o El pasado y el futuro.
Reliquias (4 piezas): Sacerdote del calvario revivido, Mensajero del espacio hackeado o Águila del crepúsculo.
Ornamentos planares: Lushaka, sumergido bajo el mar, Quilla rota o Colonipenal, la tierra de los sueños.', 'Torso: Daño CRIT.
Piernas: VEL.
Esfera de plano: PV % o DEF %.
Cuerda de unión: Recuperación de energía.
Subestadísticas: Daño CRIT, VEL, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23021"],"alternativas":["hsr-lc-23034","hsr-lc-23046","hsr-lc-23003","hsr-lc-21018","hsr-lc-21036","hsr-lc-21025"]},"reliquias":["hsr-relic-121","hsr-relic-114","hsr-relic-110"],"ornamentos":["hsr-relic-317","hsr-relic-310","hsr-relic-312"],"principales":{"torso":["Daño CRIT"],"piernas":["VEL"],"esfera":["PV %","DEF %"],"cuerda":["Recuperación de energía"]},"secundarias":["Daño CRIT","VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-sunday', 'General', 'Conos ideales: De vuelta a la tierra.
Otros conos que le van bien: La batalla no ha terminado, Mundo de juegos o El pasado y el futuro.
Reliquias (4 piezas): Sacerdote del calvario revivido, Mensajero del espacio hackeado o Águila del crepúsculo.
Ornamentos planares: Lushaka, sumergido bajo el mar, Quilla rota o Vonwacq el vivaz.', 'Torso: Daño CRIT.
Piernas: VEL.
Esfera de plano: PV % o DEF %.
Cuerda de unión: Recuperación de energía.
Subestadísticas: Daño CRIT, VEL, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23034"],"alternativas":["hsr-lc-23003","hsr-lc-23021","hsr-lc-21025"]},"reliquias":["hsr-relic-121","hsr-relic-114","hsr-relic-110"],"ornamentos":["hsr-relic-317","hsr-relic-310","hsr-relic-308"],"principales":{"torso":["Daño CRIT"],"piernas":["VEL"],"esfera":["PV %","DEF %"],"cuerda":["Recuperación de energía"]},"secundarias":["Daño CRIT","VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-sushang', 'General', 'Conos ideales: En la noche.
Otros conos que le van bien: Crucero estelar, Dormir como un tronco, Hacia una segunda vida, El río nace en primavera, Ganador final o Juego de espadas.
Reliquias (4 piezas): Campeona de boxeo callejero, Ladrón del rastro meteórico o Caballería de hierro plaguicida.
Ornamentos planares: Glamoth, frente del firmamento, Talia, paraíso de los forajidos o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño Físico.
Cuerda de unión: ATQ % o Efecto de Ruptura.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL, Efecto de Ruptura.', null, null, '{"conos":{"ideales":["hsr-lc-23001"],"alternativas":["hsr-lc-24001","hsr-lc-23012","hsr-lc-23027","hsr-lc-21024","hsr-lc-21037","hsr-lc-21010"]},"reliquias":["hsr-relic-105","hsr-relic-111","hsr-relic-119"],"ornamentos":["hsr-relic-311","hsr-relic-307","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño Físico"],"cuerda":["ATQ %","Efecto de Ruptura"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL","Efecto de Ruptura"]}'::jsonb),
  ('honkai-star-rail', 'hsr-the-herta', 'General', 'Conos ideales: Hacia lo inescrutable.
Otros conos que le van bien: Noche en la Vía Láctea, Día del colapso cósmico, El reposo de los genios o La solemnidad del desayuno.
Reliquias (4 piezas): Eruditos perdidos en el mar del conocimiento, Cazador del bosque glacial o Pistolera de la espiga silvestre.
Ornamentos planares: Izumo gensei y reino divino de Takama, Arena rutilante o Sigonia, desolación sin dueño.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño de Hielo.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23037"],"alternativas":["hsr-lc-23000","hsr-lc-21040","hsr-lc-21020","hsr-lc-21027"]},"reliquias":["hsr-relic-122","hsr-relic-104","hsr-relic-102"],"ornamentos":["hsr-relic-314","hsr-relic-309","hsr-relic-313"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño de Hielo"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-tingyun', 'General', 'Conos ideales: De vuelta a la tierra o La batalla no ha terminado.
Otros conos que le van bien: Luces de la noche, Mundo de juegos, ¡A bailar!, Aventuras en Villa Ensueño, Esculpir la luna y tejer las nubes o Imagen en el recuerdo.
Reliquias (4 piezas): Sacerdote del calvario revivido, Mensajero del espacio hackeado o Águila del crepúsculo.
Ornamentos planares: Vonwacq el vivaz, Colonipenal, la tierra de los sueños o Flota de los eternos.', 'Torso: ATQ %.
Piernas: VEL.
Esfera de plano: ATQ %.
Cuerda de unión: Recuperación de energía.
Subestadísticas: VEL, ATQ %, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23034","hsr-lc-23003"],"alternativas":["hsr-lc-23026","hsr-lc-23021","hsr-lc-21018","hsr-lc-21036","hsr-lc-21032","hsr-lc-21004"]},"reliquias":["hsr-relic-121","hsr-relic-114","hsr-relic-110"],"ornamentos":["hsr-relic-308","hsr-relic-312","hsr-relic-302"],"principales":{"torso":["ATQ %"],"piernas":["VEL"],"esfera":["ATQ %"],"cuerda":["Recuperación de energía"]},"secundarias":["VEL","ATQ %","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-topaz', 'General', 'Conos ideales: Preocupaciones y felicidad.
Otros conos que le van bien: Crucero estelar, Dormir como un tronco, El final de una mentira, Ganador final, Hacia el final del horizonte o Juego de espadas.
Reliquias (4 piezas): Gran duque incinerador, Forjador de lava o Buceadora pionera del agua muerta.
Ornamentos planares: Parque de Platanolandia, Salsotto inerte o Duran, dinastía de lobos raudos.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: ATQ % o VEL.
Esfera de plano: Aumento de Daño de Fuego.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23016"],"alternativas":["hsr-lc-24001","hsr-lc-23012","hsr-lc-23056","hsr-lc-21037","hsr-lc-22008","hsr-lc-21010"]},"reliquias":["hsr-relic-115","hsr-relic-107","hsr-relic-117"],"ornamentos":["hsr-relic-318","hsr-relic-306","hsr-relic-315"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["ATQ %","VEL"],"esfera":["Aumento de Daño de Fuego"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-trazacaminos-exultacion', 'General', 'Otros conos que le van bien: Exultación desbordante de bendiciones, Juntos hacia el futuro o Las aventuras de Champigaga.
Reliquias (4 piezas): Adivino de alcance remoto, Chica mágica de hazañas gloriosas o Pistolera de la espiga silvestre.
Ornamentos planares: Lushaka, sumergido bajo el mar, Etapa cero de Punklorde o Estación sellaespacios.', 'Torso: Daño CRIT o Prob. CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: ATQ %.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, VEL, ATQ %.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-24006","hsr-lc-22007","hsr-lc-21064"]},"reliquias":["hsr-relic-130","hsr-relic-129","hsr-relic-102"],"ornamentos":["hsr-relic-317","hsr-relic-325","hsr-relic-301"],"principales":{"torso":["Daño CRIT","Prob. CRIT"],"piernas":["VEL","ATQ %"],"esfera":["ATQ %"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","VEL","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-trazacaminos-fisico', 'General', 'Conos ideales: Sobre la caída de un Eón.
Otros conos que le van bien: Algo insustituible, Bajo el cielo azul, Los Topos te dan la bienvenida, Sin escapatoria o Colapso celeste.
Reliquias (4 piezas): Campeona de boxeo callejero, Eruditos perdidos en el mar del conocimiento o Pistolera de la espiga silvestre.
Ornamentos planares: Arena rutilante, Estación sellaespacios o Salsotto inerte.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño Físico.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-24000"],"alternativas":["hsr-lc-23002","hsr-lc-21019","hsr-lc-21005","hsr-lc-21033","hsr-lc-20002"]},"reliquias":["hsr-relic-105","hsr-relic-122","hsr-relic-102"],"ornamentos":["hsr-relic-309","hsr-relic-301","hsr-relic-306"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño Físico"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-trazacaminos-fuego', 'General', 'Conos ideales: El momento de la victoria.
Otros conos que le van bien: La textura de los recuerdos, Ya ha cerrado los ojos, ¡Así soy yo!, Concierto para dos, El primer día del resto de mi vida o La elección de Landau.
Reliquias (4 piezas): Paladina de la Iglesia de la Corte Inmaculada, Eremita aislado en las estrellas o Guardia de la nieve borrascosa.
Ornamentos planares: La Belobog de los Arquitectos, Quilla rota o Flota de los eternos.', 'Torso: DEF %.
Piernas: VEL.
Esfera de plano: DEF %.
Cuerda de unión: DEF %.
Subestadísticas: DEF %, VEL, RES a efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23005"],"alternativas":["hsr-lc-24002","hsr-lc-23011","hsr-lc-21030","hsr-lc-21043","hsr-lc-21002","hsr-lc-21009"]},"reliquias":["hsr-relic-103","hsr-relic-128","hsr-relic-106"],"ornamentos":["hsr-relic-304","hsr-relic-310","hsr-relic-302"],"principales":{"torso":["DEF %"],"piernas":["VEL"],"esfera":["DEF %"],"cuerda":["DEF %"]},"secundarias":["DEF %","VEL","RES a efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-trazacaminos-hielo', 'General', 'Otros conos que le van bien: Amor eterno como este momento, Que el arcoíris siempre esté en el cielo, Sobre los recuerdos nunca cae el telón, Victoria disputada, Volando hacia un mañana rosado o Imágenes quemadas.
Reliquias (4 piezas): Héroe de la epopeya triunfal, Cazador del bosque glacial o Águila del crepúsculo.
Ornamentos planares: Lushaka, sumergido bajo el mar, Colonipenal, la tierra de los sueños o Parque de Platanolandia.', 'Torso: Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño de Hielo.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: Daño CRIT, VEL, ATQ %.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23052","hsr-lc-23042","hsr-lc-24005","hsr-lc-21050","hsr-lc-22006","hsr-lc-20021"]},"reliquias":["hsr-relic-123","hsr-relic-104","hsr-relic-110"],"ornamentos":["hsr-relic-317","hsr-relic-312","hsr-relic-318"],"principales":{"torso":["Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño de Hielo"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["Daño CRIT","VEL","ATQ %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-trazacaminos-imaginario', 'General', 'Conos ideales: Imagen en el recuerdo.
Otros conos que le van bien: La batalla no ha terminado, Mi pasado en el espejo, ¡A bailar!, Al perseguir el viento, Encuentro planetario o Rueda mecánica.
Reliquias (4 piezas): Relojero de maquinaciones oníricas, Ladrón del rastro meteórico o Mensajero del espacio hackeado.
Ornamentos planares: Talia, paraíso de los forajidos, Fragua de la linterna Kalpagni o Flota de los eternos.', 'Torso: PV % o DEF %.
Piernas: VEL.
Esfera de plano: DEF % o PV %.
Cuerda de unión: Efecto de Ruptura.
Subestadísticas: Efecto de Ruptura, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-21004"],"alternativas":["hsr-lc-23003","hsr-lc-23019","hsr-lc-21018","hsr-lc-21056","hsr-lc-21011","hsr-lc-20012"]},"reliquias":["hsr-relic-118","hsr-relic-111","hsr-relic-114"],"ornamentos":["hsr-relic-307","hsr-relic-316","hsr-relic-302"],"principales":{"torso":["PV %","DEF %"],"piernas":["VEL"],"esfera":["DEF %","PV %"],"cuerda":["Efecto de Ruptura"]},"secundarias":["Efecto de Ruptura","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-tribbie', 'General', 'Otros conos que le van bien: Si el tiempo fuera una flor, ¡A bailar!, Imagen en el recuerdo o Rueda mecánica.
Reliquias (4 piezas): Poetisa del colapso elegíaco, Genio de las estrellas relucientes o Pistolera de la espiga silvestre.
Ornamentos planares: Osario sereno, Flota de los eternos o Lushaka, sumergido bajo el mar.', 'Torso: Daño CRIT o Prob. CRIT.
Piernas: PV %.
Esfera de plano: Aumento de Daño Cuántico o PV %.
Cuerda de unión: Recuperación de energía o PV %.
Subestadísticas: Prob. CRIT, Daño CRIT, PV %.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23038","hsr-lc-21018","hsr-lc-21004","hsr-lc-20012"]},"reliquias":["hsr-relic-124","hsr-relic-108","hsr-relic-102"],"ornamentos":["hsr-relic-319","hsr-relic-302","hsr-relic-317"],"principales":{"torso":["Daño CRIT","Prob. CRIT"],"piernas":["PV %"],"esfera":["Aumento de Daño Cuántico","PV %"],"cuerda":["Recuperación de energía","PV %"]},"secundarias":["Prob. CRIT","Daño CRIT","PV %"]}'::jsonb),
  ('honkai-star-rail', 'hsr-welt', 'General', 'Conos ideales: En nombre del mundo o Mentiras que vuelan en el viento.
Otros conos que le van bien: En las orillas transitorias, Lluvia incesante, Antes de que comience la misión del tutorial, Buenas noches, que duermas bien, Determinación reluciente o Tango ilimitado.
Reliquias (4 piezas): Buceadora pionera del agua muerta, Habitante del yermo de los bandidos o Eruditos perdidos en el mar del conocimiento.
Ornamentos planares: Arena rutilante, Estación sellaespacios o Entidad comercial pangaláctica.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño Imaginario.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL, Acierto de efecto.', null, null, '{"conos":{"ideales":["hsr-lc-23004","hsr-lc-23043"],"alternativas":["hsr-lc-23024","hsr-lc-23007","hsr-lc-22000","hsr-lc-21001","hsr-lc-21015","hsr-lc-21044"]},"reliquias":["hsr-relic-117","hsr-relic-112","hsr-relic-122"],"ornamentos":["hsr-relic-309","hsr-relic-301","hsr-relic-303"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño Imaginario"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL","Acierto de efecto"]}'::jsonb),
  ('honkai-star-rail', 'hsr-xueyi', 'General', 'Conos ideales: Sobre la caída de un Eón.
Otros conos que le van bien: A donde regresan los sueños, Bajo el cielo azul, Juramento secreto, Los Topos te dan la bienvenida, Promesa grabada o Sangre del pasado.
Reliquias (4 piezas): Genio de las estrellas relucientes, Ladrón del rastro meteórico o Caballería de hierro plaguicida.
Ornamentos planares: Talia, paraíso de los forajidos, Salsotto inerte o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: VEL o ATQ %.
Esfera de plano: Aumento de Daño Cuántico o ATQ %.
Cuerda de unión: Efecto de Ruptura o ATQ %.
Subestadísticas: Efecto de Ruptura, Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-24000"],"alternativas":["hsr-lc-23025","hsr-lc-21019","hsr-lc-21012","hsr-lc-21005","hsr-lc-21042","hsr-lc-21058"]},"reliquias":["hsr-relic-108","hsr-relic-111","hsr-relic-119"],"ornamentos":["hsr-relic-307","hsr-relic-306","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["VEL","ATQ %"],"esfera":["Aumento de Daño Cuántico","ATQ %"],"cuerda":["Efecto de Ruptura","ATQ %"]},"secundarias":["Efecto de Ruptura","Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-yanqing', 'General', 'Conos ideales: En la noche.
Otros conos que le van bien: Crucero estelar, Dormir como un tronco, Me voy de caza, El río nace en primavera, Ganador final o Juego de espadas.
Reliquias (4 piezas): Cazador del bosque glacial, Buceadora pionera del agua muerta o Eruditos perdidos en el mar del conocimiento.
Ornamentos planares: Glamoth, frente del firmamento, Estación sellaespacios o Salsotto inerte.', 'Torso: Daño CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño de Hielo.
Cuerda de unión: ATQ %.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23001"],"alternativas":["hsr-lc-24001","hsr-lc-23012","hsr-lc-23031","hsr-lc-21024","hsr-lc-21037","hsr-lc-21010"]},"reliquias":["hsr-relic-104","hsr-relic-117","hsr-relic-122"],"ornamentos":["hsr-relic-311","hsr-relic-301","hsr-relic-306"],"principales":{"torso":["Daño CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño de Hielo"],"cuerda":["ATQ %"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb),
  ('honkai-star-rail', 'hsr-yao-guang', 'General', 'Otros conos que le van bien: Cuando se decidió a ver, Juntos hacia el futuro, La buena suerte de hoy, Las aventuras de Champigaga o Risita burlona.
Reliquias (4 piezas): Adivino de alcance remoto o Mensajero del espacio hackeado.
Ornamentos planares: Lushaka, sumergido bajo el mar, Vonwacq el vivaz o Quilla rota.', 'Torso: Daño CRIT o Prob. CRIT.
Piernas: VEL.
Esfera de plano: PV % o DEF %.
Cuerda de unión: Recuperación de energía.
Subestadísticas: VEL, Daño CRIT, Prob. CRIT.', null, null, '{"conos":{"ideales":[],"alternativas":["hsr-lc-23054","hsr-lc-22007","hsr-lc-21065","hsr-lc-21064","hsr-lc-20023"]},"reliquias":["hsr-relic-130","hsr-relic-114"],"ornamentos":["hsr-relic-317","hsr-relic-308","hsr-relic-310"],"principales":{"torso":["Daño CRIT","Prob. CRIT"],"piernas":["VEL"],"esfera":["PV %","DEF %"],"cuerda":["Recuperación de energía"]},"secundarias":["VEL","Daño CRIT","Prob. CRIT"]}'::jsonb),
  ('honkai-star-rail', 'hsr-yukong', 'General', 'Conos ideales: Imagen en el recuerdo.
Otros conos que le van bien: La batalla no ha terminado, ¡A bailar!, Aventuras en Villa Ensueño, El pasado y el futuro, Encuentro planetario o Esculpir la luna y tejer las nubes.
Reliquias (4 piezas): Pistolera de la espiga silvestre, Habitante del yermo de los bandidos o Ladrón del rastro meteórico.
Ornamentos planares: Flota de los eternos, Colonipenal, la tierra de los sueños o Vonwacq el vivaz.', 'Torso: Prob. CRIT.
Piernas: VEL.
Esfera de plano: Aumento de Daño Imaginario.
Cuerda de unión: Recuperación de energía o ATQ %.
Subestadísticas: VEL, ATQ %, Prob. CRIT, Daño CRIT.', null, null, '{"conos":{"ideales":["hsr-lc-21004"],"alternativas":["hsr-lc-23003","hsr-lc-21018","hsr-lc-21036","hsr-lc-21025","hsr-lc-21011","hsr-lc-21032"]},"reliquias":["hsr-relic-102","hsr-relic-112","hsr-relic-111"],"ornamentos":["hsr-relic-302","hsr-relic-312","hsr-relic-308"],"principales":{"torso":["Prob. CRIT"],"piernas":["VEL"],"esfera":["Aumento de Daño Imaginario"],"cuerda":["Recuperación de energía","ATQ %"]},"secundarias":["VEL","ATQ %","Prob. CRIT","Daño CRIT"]}'::jsonb),
  ('honkai-star-rail', 'hsr-yunli', 'General', 'Conos ideales: Danza crepuscular.
Otros conos que le van bien: Algo insustituible, Orilla inalcanzable, Que arda el alba, Sobre la caída de un Eón, Bajo el cielo azul o Sangre del pasado.
Reliquias (4 piezas): Intrépida cabalgavientos, Buceadora pionera del agua muerta o Campeona de boxeo callejero.
Ornamentos planares: Duran, dinastía de lobos raudos, Salsotto inerte o Estación sellaespacios.', 'Torso: Prob. CRIT o Daño CRIT.
Piernas: ATQ %.
Esfera de plano: Aumento de Daño Físico o ATQ %.
Cuerda de unión: ATQ % o Recuperación de energía.
Subestadísticas: Prob. CRIT, Daño CRIT, ATQ %, VEL.', null, null, '{"conos":{"ideales":["hsr-lc-23030"],"alternativas":["hsr-lc-23002","hsr-lc-23009","hsr-lc-23044","hsr-lc-24000","hsr-lc-21019","hsr-lc-21058"]},"reliquias":["hsr-relic-120","hsr-relic-117","hsr-relic-105"],"ornamentos":["hsr-relic-315","hsr-relic-306","hsr-relic-301"],"principales":{"torso":["Prob. CRIT","Daño CRIT"],"piernas":["ATQ %"],"esfera":["Aumento de Daño Físico","ATQ %"],"cuerda":["ATQ %","Recuperación de energía"]},"secundarias":["Prob. CRIT","Daño CRIT","ATQ %","VEL"]}'::jsonb)
on conflict (character_id, mode) do update
  set equipment_build = excluded.equipment_build,
      stats = excluded.stats,
      build = excluded.build,
      updated_at = now();

-- Comprobacion
select count(*) as builds, count(build -> 'principales') filter (where build -> 'principales' <> 'null'::jsonb) as con_recomendacion_oficial
from public.character_meta_guides
where game_id = 'honkai-star-rail';
