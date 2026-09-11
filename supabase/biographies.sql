-- Ejecutar en Supabase -> SQL Editor -> New query -> Run.
-- Requiere characters.sql, characters_full.sql y characters_genshin_missing.sql.
--
-- Biografias en ingles y en espanol. Las inglesas salen de las wikis en ingles
-- y las espanolas de las wikis en espanol, siempre por su API (action=parse).
-- Cuando un personaje no tiene ficha en la wiki espanola, el texto espanol es
-- una traduccion del oficial en ingles: esas filas quedan marcadas con
-- biography_es_translated = true para poder avisarlo en la interfaz.

alter table public.characters add column if not exists biography_en text;
alter table public.characters add column if not exists biography_source_en text;
alter table public.characters add column if not exists biography_es text;
alter table public.characters add column if not exists biography_source_es text;
alter table public.characters
  add column if not exists biography_es_translated boolean not null default false;

-- ---------------------------------------------------------------------------
-- Genshin Impact (119 personajes)
-- ---------------------------------------------------------------------------
update public.characters set
  biography_en = 'The genius mechanical inventor of Nod-Krai. She lives in the Clink-Clank Krumkake Craftshop, surrounded by her mechanical family and the fragrance of the workshop''s namesake — scrumptious krumkakes.

Located at the border, Nod-Krai is neither a land of abundance nor a place of joy. All year round, the cold wind howls and lashes the lands, as though attempting to wring even the last dregs of warmth from every corner.

Yet in this seemingly forgotten corner of the world, the marketplace is chock-a-block with an astonishing array of marvelous machines. From guns that shoot flowers to floor sweepers that act as affectionate as puppies... You never know how a contraption might act until the very moment it springs to life.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Aino%2FProfile',
  biography_es = '"¿Que cómo puedes entablar una amistad con Aino? Procediendo a analizar datos... Respuesta: primero, debes estar en contra de los krumkakes salados; segundo, debes apreciar sus inventos; y tercero, debes jugar con ella a menudo".
La primera impresión que tiene la gente de la tierra fronteriza de Nod Krai es que es “un lugar caótico azotado por un viento gélido”. Sin embargo, una vez que te familiarizas con sus reglas y exploras este lugar pacientemente, te darás cuenta de que está lleno de objetos curiosos y maravillosos. Es posible que, mientras estás de compras, te encuentres con una chica robot que está comprando como una persona cualquiera, o que escuches el estruendoso sonido de una forja al pasar por un mercado. Con un poco de suerte, hasta podrías encontrarte con un robot que pasa a toda velocidad. Si preguntas a alguien, averiguarás que todas esas máquinas son obra de Aino.

Si todo ello te da curiosidad y quieres visitar a Aino, hazlo, es muy sencillo.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Aino%2FHistoria',
  biography_es_translated = false
where id = 'gi-aino';
update public.characters set
  biography_en = 'Albedo — an alchemist based in Mondstadt, in the service of the Knights of Favonius. "Genius," "Kreideprinz," or "Captain of the Investigation Team"... Such titles and honors are of no consequence to him when there is so much more research to conduct. The pursuit of fortune and connections cannot hold a candle to his heart''s desire — acquiring the limitless, obscure knowledge left behind by previous generations of scholars.

Alchemy is an ancient art, and many of its secrets have been lost to history.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Albedo%2FProfile',
  biography_es = 'Alquimista Jefe de los Caballeros de Favonius y Capitán del equipo de investigación. Lo llaman el “Príncipe de la Roca Caliza”.

La búsqueda de la fortuna y las conexiones no puede igualar el deseo de su corazón: adquirir el conocimiento oscuro e ilimitado que dejaron las generaciones anteriores de eruditos.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Albedo%2FHistoria',
  biography_es_translated = false
where id = 'gi-albedo';
update public.characters set
  biography_en = 'The current scribe of the Sumeru Akademiya, a man endowed with extraordinary intelligence and talent. He lives free — free from the searching eyes of ordinary people, anyway.

A capable person who keeps a low profile for too long is often perceived as someone with a mysterious identity and ulterior purposes. Alhaitham himself is a powerful rebuttal to all these cliché views: He is a brilliant man, but he is only an ordinary employee of the Akademiya, with a stable job and a cushy house in Sumeru, leading a carefree and comfortable life.

Sometimes, people find it next to impossible to catch the current scribe in his office. Little do they know about the scribe, other than his name, "Alhaitham," and that he is supposed to be present during work hours. The fact is, no one knows his whereabouts, and all they can do is leave documents and files on his desk.

Alhaitham couldn''t be more satisfied with how things are.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Alhaitham%2FProfile',
  biography_es = 'El actual escriba de la Academia de Sumeru, un hombre de gran inteligencia y talento. Vive su vida libremente y es prácticamente imposible de encontrar.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Alhac%C3%A9n%2FHistoria',
  biography_es_translated = false
where id = 'gi-alhaitham';
update public.characters set
  biography_en = 'Outcast, hunter of machines, Seeker, Anointed, Savior... Aloy had many identities in her original world, and she was destined on account of her genetics to be the heroine who would heal it.

Now, she has arrived in a new world, full of never-before-seen challenges, and once again, she throws herself gladly into the hunt.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Aloy%2FProfile',
  biography_es = 'Antes era una paria, pero hoy en día es una cazadora excepcionalmente ágil. Siempre esta preparada para hacer uso de su arco y sus flechas cuando es necesario.

Tratada como paria desde que nació, Aloy creció en las montañas salvajes cerca de donde habitaba la tribu que la repudió. Criada por un experto cazador, entrenó para cazar con el sigilo de un gato y eficacia mortal. Pero lo que más quería saber, no podría enseñárselo él. Por encima de todo, ella ardía en deseos de descubrir qué ocurrió cuando nació, quiénes eran sus padres y por qué fue marginada por la tribu.

La búsqueda de repuestas la llevó a un gran mundo mucho más peligroso de lo que ella nunca podría haber imaginado.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Aloy%2FHistoria',
  biography_es_translated = false
where id = 'gi-aloy';
update public.characters set
  biography_en = 'A "professional hunter" mastering the Snezhnayan snowfields. Beneath his calm demeanor, a fiercely distinct "ideal" seems to burn.

In Snezhnaya, the name "Alyosha" is exceptionally favored among the people.

This is not because some young hunter''s monumental deeds made it a household name, but because the name itself carries a beautiful promise that countless parents yearned for.

Fearless, innocent and kind-hearted...

They pray for their children to bear such virtues, wishing for them to escape the carving of fate just like the heroes in legendary tales.

Yet, they are oblivious to the harsh truth: the ice and snow of Snezhnaya never respond to prayers, and the bitter cold itself is a relentless rasp.

A mere name cannot breed true courage, and unarmed kindness cannot shield a child from the spear thrown by fate.

Only those who experience, fight, and live like heroes can break the curse of reality; only those who plunge their feet into the frozen wastes time and again stand a chanc',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Alyosha%2FProfile',
  biography_es = 'Aliosha utiliza el modelo masculino mediano. Tiene la piel pálida, pecas, el pelo de un tono verde menta pastel y los ojos amarillos. Lleva una camisa negra, sobre la que se pone un abrigo azul y blanco, y encima una túnica roja y beige con cuello de piel blanco. Lleva un Electro Vision sujeto a una pequeña bolsa que lleva en la pierna derecha.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Aliosha%2FHistoria',
  biography_es_translated = false
where id = 'gi-alyosha';
update public.characters set
  biography_en = 'A perky, straightforward girl, who is also the only Outrider of the Knights of Favonius. Her amazing mastery of the glider has made her a three-time winner of the Gliding Championship in Mondstadt. As a rising star within the Knights of Favonius, Amber is always ready for any challenging tasks.

Amber is an Outrider of the Knights of Favonius. In an age where Outriders are becoming obsolete, she continues on with her responsibilities.

It takes a newcomer only a few days to feel right at home with this passionate girl.

Whether it''s before the Good Hunter''s signboard, the banks of Cider Lake, or the tree tops at Windrise, one can find traces of this vigilant Outrider in red anywhere.

Once spotted by her, no suspicious individual can ever escape her interrogation.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Amber%2FProfile',
  biography_es = 'Siempre enérgica y llena de vida, Amber es la mejor exploradora de los Caballeros de Favonius, aunque también es la única...
Una chica alegre y sencilla, que también es la primera exploradora de los Caballeros de Favonius que conocemos dentro del juego. Su asombroso dominio de las alas voladoras la ha convertido en tres veces ganadora del Campeonato de vuelo en Mondstadt. Como estrella en ascenso dentro de los Caballeros de Favonius, Amber siempre está lista para cualquier tarea desafiante.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Amber%2FHistoria',
  biography_es_translated = false
where id = 'gi-amber';
update public.characters set
  biography_en = 'While walking through Hanamizaka, it is hard not to notice a young man of the oni race named Arataki Itto.

Never mind his horns or piercing voice sticking out like sore thumbs — the sight of him enthusiastically joining in to play childrens'' games is enough to set him apart from the crowd.

In any case, his obvious lack of things to do stands in stark contrast to Hanamizaka itself, where craftspeople gather in droves and busy themselves all day long.

Itto claims to be the "first and greatest head of the Arataki Gang," the responsibilities and duties of which he tried to explain to some Tenryou Commission officials when they came to him to investigate a rather harmless street brawl.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Arataki%20Itto%2FProfile',
  biography_es = 'El primer gran líder de la Banda de Arataki, muy activo en la zona de Hanamizaka de la Ciudad de Inazuma. ¿Nunca habías oído hablar de la Banda de Arataki? ¿En serio?

Itto es probablemente un descendiente de Arataki, un famoso artista marcial en la historia de Inazuma. Basándose en los epítetos que él diseña por sí mismo, así como en las descripciones físicas que otros NPC le han dado, tiene sangre oni corriendo por sus venas.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Arataki%20Itto%2FHistoria',
  biography_es_translated = false
where id = 'gi-arataki-itto';
update public.characters set
  biography_en = '"The Knave," Fourth of the Fatui Harbingers. Revered as "Father" by the children of the House of the Hearth.

The Hotel Bouffes d''ete, situated in the Vasari Passage, is a lovely building with clean walls and sparkling windows, and well-mannered, well-groomed children frequent it every day.

Unlike other mansions of comparable beauty in the Court of Fontaine, the registered owner of this property does not live on-site. Indeed, nearby residents have not even heard of her.

The signature on the relevant documentation is but a false identity — the real power lies with someone else.

If one could hear the children whisper at night behind the Hotel''s closed gates, one would hear this appellation: "Father."

When speaking of "Father," some faces turn worshipful, some hearts are seized with fear, and still others look inscrutable, torn — but their tone always becomes one of respect.

These children are part of the organization known as the House of the Hearth.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Arlecchino%2FProfile',
  biography_es = 'Rosalyne murió en una tierra extranjera. Pero ustedes, hombres de negocios y dignatarios desalmados siempre tienen una excusa conveniente para permanecer en la comodidad de su patria. Nunca lo entenderían. Así que, ¿por qué mejor no se callan? No queremos hacer llorar a los niños.
Hace varios años, cuando era una niña, Arlecchino se enfrentó a la anterior poseedora del título de La Sota y acabó sucediéndola. Reformó la Casa de la Hoguera; aunque estricta, insistía en que la Casa se mantuviera de forma colectiva, permitía a sus miembros completar las tareas a su manera y no los castigaba tan severamente como su predecesora.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Arlecchino%2FHistoria',
  biography_es_translated = false
where id = 'gi-arlecchino';
update public.characters set
  biography_en = 'Daughter of the Yashiro Commission''s Kamisato Clan from Inazuma. Dignified and elegant, wise and determined. Sincere and pleasant to others. Universally loved by the Inazuma people, she has earned the title of Shirasagi Himegimi.

A pair of siblings have inherited the Kamisato Clan, one of the three most respected and prestigious clans in Inazuma City.

The elder brother, Ayato, is the head of the clan and is in charge of government affairs.

While his younger sister, Ayaka, known by all as the Princess, takes care of the clan''s internal and external affairs.

Ayaka often appears at social occasions and has more interactions with the common folk. As such, she is better known by the people and has gained a higher reputation than her elder brother.

This has earned her the elegant title of Shirasagi Himegimi.

As is known to all,

Ayaka, the daughter of the Kamisato family, is a figure greatly admired by the people for her beauty, dignified demeanor, and noble character.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Ayaka%2FProfile',
  biography_es = 'La hija del Clan Kamisato, perteneciente a la Comisión Yashiro de Inazuma. Una persona solemne refinada, inteligente y tenaz',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Kamisato%20Ayaka%2FHistoria',
  biography_es_translated = false
where id = 'gi-ayaka';
update public.characters set
  biography_en = 'Current head of the Kamisato Clan and, accordingly, the Yashiro Commissioner. He always has a way of attaining his purpose in a well-thought-out manner. However, few people understand what that "goal" he holds most dear is.

As clan head of the Kamisato Clan, one of the great clans of the Tri-Commission, Kamisato Ayato is a household name in Inazuma.

However, people do not have quite the same clear impression of him as they do of the Shirasagi Himegimi, the elegant and kind Ayaka.

Most only know that he is an important figure in the Shogunate and the head of a famed noble house. But as for the details, there''s little that they can say for sure.

Some people say that "the Yashiro Commission''s festivals and events are ever meticulous and have been full of consideration for the people. Surely the Commissioner''s hand is in all such matters."

But others also say "ah, but there is much to politics that should never see the light of day.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Ayato%2FProfile',
  biography_es = 'Joven promesa y actual líder del clan Kamisato de la Comisión Yashiro. Refinado y educado, siempre tiene una forma de solucionar las cosas.

Como jefe de la Comisión Yashiro, Kamisato Ayato se compromete a mantener la prosperidad y la estabilidad de la región.

En apariencia, es un hombre discreto y elegante. No le gusta hacer apariciones públicas, y mucho menos mostrar sus habilidades abiertamente.

Pero los que lo conocen saben que no hay que subestimarle. Hace mucho tiempo, durante su juventud, cuando la Comisión Yashiro pasaba por tiempos difíciles, y cuando el clan Kamisato estaba a punto de desmoronarse, fue él quien estabilizó la situación.

No podría haber alcanzado su posición sin un extraordinario ingenio y astucia. Pero tal vez, esa sonrisa impenetrable oculta ondas más oscuras.

Sin embargo, lo más intrigante es que, en la mayoría de estas negociaciones en las que participa, no es despiadado ni competitivo.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Kamisato%20Ayato%2FHistoria',
  biography_es_translated = false
where id = 'gi-ayato';
update public.characters set
  biography_en = 'The owner of Bubu Pharmacy, the finest pharmacy in all of Liyue. He is rarely seen without a white snake named Changsheng coiled around his shoulders. His prescriptions are varied and diverse, and his medical prowess and compassion are known throughout Teyvat.

Baizhu, the owner of "Bubu Pharmacy," is a master of the medicinal arts.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Baizhu%2FProfile',
  biography_es = 'El dueño de la Farmacia Bubu, siempre con una serpiente blanca llamada Changsheng colgándole del cuello. Gran conocedor de la medicina, sus auténticas intenciones son un verdadero misterio.

Baizhu se presenta en la misión "Guizhong", después de que el Viajero y Zhongli regresan a Qiqi con las manos vacías después de que ella les pide que cacen a un "Adeptus legendario" llamado "Cococabra". Después de que se dieron cuenta de que Qiqi había estado buscando leche de coco todo el tiempo, Baizhu se muestra y se revela como el dueño de la Farmacia Bubu, algo que ni siquiera Zhongli sabía. Ofrece tres millones de moras a cambio de Incienso eterno, una suma considerable que obliga al grupo a pedirle a Nobile que pague por ellos. Después, Baizhu comenta sobre su "extraño" encuentro y Changsheng advierte al Viajero que probablemente intentará desplumarlos.

El Herborista Gui, otro empleado de la Farmacia Bubu, comenta que Baizhu sufre de una dolencia desconocida que lo debilita bastante.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Baizhu%2FHistoria',
  biography_es_translated = false
where id = 'gi-baizhu';
update public.characters set
  biography_en = 'The Deaconess of the Favonius Church and a shining starlet adored by all. Although the concept of a starlet is rather novel in a city of bards, the people of Mondstadt love Barbara nonetheless. "I owe everything to the city''s spirit of freedom" — Barbara, regarding her popularity.

Barbara is the Deaconess of the Church of Favonius, as well as the shining idol of Mondstadt.

"The sight of Barbara makes all my problems disappear." This is quite a common saying among the citizens of Mondstadt.

In fact, Barbara can do much more than just put people in a better mood: Her healing powers extend to flesh wounds and other physical ailments.

Barbara is known to have access to miraculous healing powers through her Hydro Vision.

However, Barbara herself knows that hard work is the most miraculous magic of all.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Barbara%2FProfile',
  biography_es = 'Todos los habitantes de Mondstadt adoran a Bárbara. Ella vio por primera vez la palabra “ídolo” en una revista.

La diaconisa de la iglesia Favonius y una estrella brillante adorada por todos. Aunque el concepto de una estrella joven es bastante novedoso en una ciudad de bardos, la gente de Mondstadt ama a Bárbara de todos modos.

Bárbara es la diaconisa de la iglesia Favonius, así como la ídolo brillante de Mondstadt.

"Ver a Bárbara hace que todos mis problemas desaparezcan". Este es un dicho bastante común entre los habitantes de Mondstadt.

De hecho, Bárbara puede hacer mucho más que poner a la gente de mejor humor: sus poderes curativos se extienden a las heridas de la carne y otras dolencias físicas. Se sabe que Bárbara tiene acceso a poderes curativos milagrosos a través de su Visión Hydro.

Sin embargo, la propia Bárbara sabe que la magia más milagrosa de todas es el trabajo duro.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/B%C3%A1rbara%2FHistoria',
  biography_es_translated = false
where id = 'gi-barbara';
update public.characters set
  biography_en = 'Captain of the Crux, with quite the reputation in Liyue. There are those who say she can split mountains and part the sea. Others say she draws lightning through her sword. Some say that even the mightiest of sea beasts are no match for her. For those not from Liyue, it may sound like a hearty joke, but those that have sailed with her will say— "No matter what sea beasts there may be, Beidou will be sure to split them all in two."

Beidou is the leader of The Crux — an armed crew based in Liyue Harbor.

An armed crew means exactly what it sounds like: a crew of sailors armed to the teeth.

Without getting into too many details, everything The Crux does is approved by the Qixing... more or less.

Beidou is a trusted leader, so much so that her crew believes her capable of taming the storms and billows on the sea.

"It''s Beidou! Even the mightiest of storms must bow its head to her might!"',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Beidou%2FProfile',
  biography_es = 'Capitana de la Flota Crux Meridianam y su tripulación. Es una mujer bastante libre y franca.

Hay quienes dicen que puede dividir las montañas y separar el mar. Otros que dispara rayos con su espada. Algunos que incluso la más poderosa de las bestias marinas no es rival para ella.

Para los que no son de Liyue, creerán que están siendo exagerados, pero los que han navegado con ella dirán... "No importa qué bestias marinas se encuentre, Beidou se asegurará de dividirlas todas en dos".',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Beidou%2FHistoria',
  biography_es_translated = false
where id = 'gi-beidou';
update public.characters set
  biography_en = 'One of the few young adventurers of the Mondstadt Adventurers'' Guild, he is always plagued with inexplicable bad luck. He is the only active member of his own adventure group, known as "Benny''s Adventure Team," after all the other members decided to "take leave" following a series of unfortunate incidents. As a result, the team is currently on the verge of being dissolved.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Bennett%2FProfile',
  biography_es = 'El chico aventurero de Mondstadt. Su naturaleza amable no va acorde con su mala suerte.

Los pocos jóvenes aventureros del Gremio de Aventureros de Mondstadt han sufrido desgracias insospechadas al salir de aventura con Bennett.

Él es el único miembro activo de su propio grupo de aventureros, conocido como la "Brigada de Benny", luego de que todos los demás miembros decidieron "ausentarse" después de una serie de calamidades. Como resultado, el equipo está actualmente a punto de ser disuelto.

Katheryne del Gremio de Aventureros, quien no tiene el valor de romperle el corazón, ha decidido mantener la "Brigada de Benny" en los registros, mientras que a la vez oculta el hecho de que todos los demás miembros han dejado oficialmente el equipo desde hace mucho tiempo.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Bennett%2FHistoria',
  biography_es_translated = false
where id = 'gi-bennett';
update public.characters set
  biography_en = 'The guardian of Aaru Village who is gentle and benevolent. She will not allow anyone to harm Aaru Village under her watch.

Candace, who has heterochromatic eyes, serves as the guardian of Aaru Village.

Candace always shows the greatest kindness to all travelers visiting the village, and she will not pursue an inadvertent faux pas so long as that person corrects themselves in time. In Candace''s view, the village rules are the most important thing. So long as these boundaries are respected, anyone can be allowed to rest in Aaru Village.

But woe betide those who regard this tolerance as weakness. Those who try to do anything illegal in Aaru Village will definitely pay the price.

By then, they will find that Candace''s lance and shield truly are the most frightening of weapons.

The scion of Al-Ahmar, a member of desert folk, the Guardian...',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Candace%2FProfile',
  biography_es = '"Una vez le regalé unas cuantas alhajas a Candance y le dije que tenía que aprender a disfrutar de la vida y divertirse más a menudo. Pero ella me respondió que era feliz al contemplar la aldea en paz... *Suspira*, supongo que nuestra guardiana tiene su particular forma de disfrutar de la vida..."
"Esa tal Candace... es digna descendiente del Rey Deshret".

Este comentario lo hizo un avergonzado y tembloroso miembro de Los Eremitas en la taberna de la Ciudad de Sumeru.

Esta guardiana con heterocromía bendecida por los dioses es capaz de invocar tormentas de arena que engullen a los enemigos a su paso.

Un miembro de los Ladrones de Tesoros que acababa de anunciar que dejaba la organización añadió que Candace tiene control sobre cada grano de arena del desierto.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Candace%2FHistoria',
  biography_es_translated = false
where id = 'gi-candace';
update public.characters set
  biography_en = 'Indefatigable reporter of The Steambird, constantly on the hunt for the "truth."

In the Court of Fontaine, a new "story" is born every minute.

For example, Romaritime Harbor might suddenly swell with new ships, crewed by sailors of obviously non-Fontainian origin. Some fishmonger in Poisson might suddenly buy three months'' worth of fish in a single month, or countless flyers boasting of a certain place where especially delicious fish can be found might suddenly appear in the Court...

In the eyes of a mediocre reporter or ordinary city folk, these are "independent" tales, just like there will always be waves rippling across the sea''s surface — such ordinary events are barely worth paying attention to at all.

Clumsier journalists might even chase these waves, and dispiritedly end up merely following the wave''s patterns, constantly pumping out "surface-level stories" of little interest.

But in Charlotte''s eyes, these waves are but the superficial representation of other forces.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Charlotte%2FProfile',
  biography_es = '"... Señorita Euphrasie, hace tres días, Charlotte, reportera de su periódico, siguió en secreto a unos criminales desde la Corte de Fontaine hasta el Puerto Rociomarino, arriesgándose a ser capturada y arrojada al mar por esta banda de maleantes... Lo siento, pero no nos importa eso de ''cuanto más cerca del suceso nos hallemos, más se acercará a la verdad el reportaje''.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Charlotte%2FHistoria',
  biography_es_translated = false
where id = 'gi-charlotte';
update public.characters set
  biography_en = 'Whether mediating "disputes" stirred up by humans or by Saurians, or arbitrating with words or with bullets, all conflicts are resolved when the Peacemaker of the Tlalocan gets involved.

All humans hunger for power, and none can avoid conflict.

Some fight to protect their tribe and resist the Abyss, while others do so to prove themselves superior, greater, or more worthy of Mora, wine, power, and glory than their comrades.

But even those who love battle the most know to fear one name — Chasca.

So long as she is on the battlefield, even the fiercest fight will cease into silence in short order.

This is not entirely due to her eloquence or skill as a mediator, nor is it wholly a consequence of her ability to come up with satisfactory solutions based on her deep grasp of human nature. Instead, it''s more that...

This "Peacemaker" is just ludicrously strong, and she fights in a manner that makes a mockery of common sense.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Chasca%2FProfile',
  biography_es = 'Comprendemos que últimamente nuestro comportamiento ha sido imprudente e impulsivo, por lo que acordamos dejar atrás este conflicto y continuar a partir de ahora mano a mano... Esta declaración es completamente voluntaria y sin objeciones. Además, nos gustaría darle las gracias a la mediadora por su excelente contribución en el proceso de reconciliación.
"... Esta niña no tiene salvación... ¡Por supuesto que yo tampoco puedo aceptarlo! Pero, por favor... desiste".

Tal fue el primer conflicto que oyó Chasca desde que llegó al mundo.

"¿Qué le pasa a esta niña? ¿Acaso la criaron los Qucusaurios? Con razón es tan salvaje...".

Así fueron los innumerables conflictos con los que se topó Chasca al regresar a la Tribu Plumaflora.

Aunque los recuerdos de su infancia se le antojen borrosos, Chasca se acuerda de las emociones que brotaban al escuchar palabras como aquellas: decepción, dolor, rencor y frustración...',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Chasca%2FHistoria',
  biography_es_translated = false
where id = 'gi-chasca';
update public.characters set
  biography_en = 'The renowned Captain of the Special Security and Surveillance Patrol, always true to her own sense of "justice."

In the Court of Fontaine, where the corpus juris is exceedingly well-developed — some might even say convoluted — there are many odd ordinances that can confound and confuse foreign tourists.

For example, fruit tarts may not be placed directly on unheated platters, unfinished Fonta may not be intentionally placed in the middle of roads, and one must not forget to trim the claws of pet felines...

Violations are thus difficult to avoid. But Fontainians are quite familiar with such matters, quickly ascertaining the gravity of an offense and deciding on a course of action based on the identity of the one sent to deal with the matter.

If it is only a member of the establishment''s staff, then perhaps a simple debate will be sufficient to resolve the issue; who doesn''t enjoy a lively atmosphere?',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Chevreuse%2FProfile',
  biography_es = 'La capitana de la Unidad Especial de Seguridad y Vigilancia. Su corazón siempre late por la justicia, y su mosquete solo apunta a los criminales.

Chevreuse creció en el Río Ceniciento. Ella es la actual Capitana de la Unidad Especial de Seguridad y Vigilancia y una cliente frecuente del Taller Beaumont, y a menudo compra materiales costosos para mantener su mosquete. Según Riqueti, Chevreuse ha comentado sobre el escaso uso de Mecagendarmes por parte de la Unidad mientras estaba bajo su mando, afirmando que "¡Los Mecagendarmes sólo bloquearán nuestras balas!"

En su tiempo libre, a Chevreuse le gusta leer, especialmente libros en los que la justicia prevalece sobre el mal. También tiene una obsesión enfermiza con la comida chatarra.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Chevreuse%2FHistoria',
  biography_es_translated = false
where id = 'gi-chevreuse';
update public.characters set
  biography_en = 'A frank and outspoken fashion designer whose unique sense of style always puts her at the forefront of Fontainian trends.

You push open the doors to the boutique. Situated on one of Fontaine''s busiest thoroughfares, it is named for its designer.

The crisp ringing of a bell chimes from above as if wishing luck to all customers who step through the door. If the rumors swirling about have even a grain of truth to them, then perhaps such blessings will come in handy.

"Welcome to the Chioriya Boutique, how may I help you?" The greeting that reaches your ears, while perhaps lacking somewhat in enthusiasm, is filled with assurance.

The owner of the voice shoots you a glance from behind the counter. A striking foreigner with captivating eyes — just like they said.

"A personalized, custom job? Or something off the shelf?" Her second question.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Chiori%2FProfile',
  biography_es = 'La dueña de la Sastrería Chiori y una famosa diseñadora de moda de Fontaine.

Tras un encuentro mientras le entregaba un paquete, Chiori confeccionó el atuendo actual de Kirara, Mezcolanza florífera, después de sentirse disgustada con su aspecto. Esto hizo que su tienda se hiciera más conocida a medida que la gente preguntaba por el traje. Ella también diseñó los atuendos usados por Lyney, Lynette y Navia, así como los accesorios para el Daguerrotipo de Charlotte, Monsieur Verite. Chiori es muy popular entre la gente de Fontaine, desde las clases altas hasta incluso hombres musculosos que la tratan con respeto y le hacen regalos; aquellos que la irrespetan son expulsados rápidamente de su tienda.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Chiori%2FHistoria',
  biography_es_translated = false
where id = 'gi-chiori';
update public.characters set
  biography_en = 'An exorcist who roams the land with Liyue as his base of operations, evil spirits fleeing wherever he goes. As the heir to a clan of exorcists, he has always possessed abilities superior to most. However, these abilities are not the result of training, but of an inborn trait — a pure yang spirit.

Throughout its long history, Liyue has never had a lack of rumors and myths regarding all manner of evil spirits and demons. And regardless of the truth of such rumors, someone has to do something about them.

Chongyun was born into a renowned family of exorcists, and has possessed a natural ability to drive away evil spirits from a young age due to his pure-yang spirit.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Chongyun%2FProfile',
  biography_es = 'Un joven exorcista procedente de una familia de exorcistas. Hace todo lo que puede para reprimir su propia “positividad congénita”.

Un exorcista que deambula por la tierra con Liyue como su base de operaciones. Los espíritus malignos huyen donde quiera que él va.

Como heredero de un clan de exorcistas, siempre ha poseído habilidades superiores a la mayoría.

Sin embargo, estas habilidades no son el resultado del entrenamiento, sino de un rasgo innato: la positividad congénita.

La positividad congénita es una fisiología extremadamente rara que hace que el cuerpo sea susceptible al calentamiento debido al exceso de energía positiva. Si no se controla, aquellos que poseen tal forma pueden tener rápidamente la sangre caliente. Chongyun es un caso particularmente grave, sus cambios de humor son explosivos y no recuerda nada de tales episodios.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Chongyun%2FHistoria',
  biography_es_translated = false
where id = 'gi-chongyun';
update public.characters set
  biography_en = 'A legendary shaman from the Masters of the Night-Wind, known throughout Natlan as the eminent "Granny Itztli." Not one to be messed with, but also the first person all turn to when trouble arises.

"Shamans" are practitioners of a mysterious craft who originate from the Masters of the Night-Wind. With many mystical abilities at their disposal, they are wise and powerful figures. In the eyes of the people of Natlan, whether one seeks medicine or wishes to decipher a cryptic prophecy, visiting a shaman is always the right choice. They can be both doctors and prophets, playing indispensable roles both in everyday life and in matters of far greater import. In short, theirs is a highly respected profession.

Yet above the many shamans, there are "great shamans" in a league of their own. They say it is a title that only those who reach the very pinnacle of their mystical arts may earn — and indeed, throughout the entire history of Natlan, they have been few and far between.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Citlali%2FProfile',
  biography_es = '"Siempre he pensado que Citlalí tenía madera de líder y que, tarde o temprano, se convertiría en la jefa de los Augures Vientonocturno. Sin embargo, han pasado doscientos años y sigue sin mostrar interés alguno en salir de casa. Si alguien pudiera convencerla más que esas novelas ligeras, tal vez lograría que esta chamana tan talentosa prestara más atención al mundo real... pero, de nuevo, ¿quién podría hacer eso?".

Cada vez que un niño empieza a llorar desconsoladamente, los padres de los Augures Vientonocturno recurren al nombre de la abu Itztli para obtener resultados inmediatos.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Citlal%C3%AD%2FHistoria',
  biography_es_translated = false
where id = 'gi-citlali';
update public.characters set
  biography_en = 'The mightiest Champion Duelist. Sword in hand, she defends justice in the Court of Fontaine.

Disputes are a Mora a dozen in Fontaine, day in and day out.

A confectioner might accuse another of stealing their recipe — and not only that, but replacing Bulle Fruit peel with Mint, thus bringing disgrace not only upon themselves, but upon the very dessert itself! Or a playwright might accuse a fanatical reader of imitating their style and taking up a pen name too close to their own, to the point that even the newspapers could not distinguish the genuine article.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Clorinde%2FProfile',
  biography_es = '... Te daré un consejo, amigo: las pruebas que hay en tu contra son irrebatibles. Si quieres defender tu honor, debes redimirte y llevar a cabo buenas acciones. No pienses en batirte en duelo para enmendar las cosas. ¡Tu oponente sería Clorinde! ''Esa'' Clorinde, ¿sabes? Por el amor de la Fontana Lucine... Si luchas contra ella, ¡ni siquiera tendrás opción de confesar!.
En la bulliciosa Corte de Fontaine, las disputas son el pan de cada día.

Un dramaturgo podría acusar a un lector ávido de imitar su estilo y adoptar un seudónimo demasiado parecido al suyo, hasta el punto de que ni siquiera los periódicos podrían distinguir quién es el autor original.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Clorinde%2FHistoria',
  biography_es_translated = false
where id = 'gi-clorinde';
update public.characters set
  biography_en = 'A Trainee Forest Ranger who is under the tutelage of Tighnari. She started her academic career a little later than her peers, so she is currently working hard to catch up. She hides the other side of her personality deep under the surface of optimism and kindness.

"Helpful," "bright and sunny," "friendly and passionate"...',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Collei%2FProfile',
  biography_es = '"¿Eh? ¿Tienes pensado ir a Sumeru? ¿Te importaría pasarte a ver a Collei? Hace tiempo que no la veo. Me pregunto si tiene el pelo más largo. ¿Habrá crecido mucho?"
Guardabosques en prácticas del Bosque Avidya. Es animada, positiva y cariñosa.

Collei es originaria de Sumeru, pero son pocos los que conocen su historia antes de que llegara a la Villa Gandharva.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Collei%2FHistoria',
  biography_es_translated = false
where id = 'gi-collei';
update public.characters set
  biography_en = 'Kuutar, the Moon Goddess of Nod-Krai, and formerly The Damselette, Third of the Fatui Harbingers. Still, her friends call her Columbina Hyposelenia, and she prefers it that way.

Day or night?

Why, night, of course. The world of daylight was filled with too many words beyond her understanding. "Kuutar," "The Damselette," "Goddess"... She knew these words to be like mirrors, each reflecting a version of her in this unfamiliar world. But those were versions others wished to see. She did not recognize herself in those reflections, just as she did not recognize the moon hanging in the sky. At least at night, she could clearly feel the pull coming from beyond the heavens. It made no sound, yet she understood it all the same — the Frost Moon was calling her home.

...

Spring, summer, autumn, or winter?

Winter, without question.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Columbina%2FProfile',
  biography_es = 'Kuutar, la Diosa de la Luna de Nod-Krai y antaño la Damisela, Tercera de los Heraldos Fatui. Aun así, sus amigos la llaman Columbina Hyposelenia, y ella lo prefiere así.

¿Día o noche?

La noche, por supuesto. El mundo de la luz diurna estaba lleno de palabras que escapaban a su comprensión. "Kuutar", "la Damisela", "diosa"... Sabía que esas palabras eran como espejos, y que cada uno reflejaba una versión de ella en aquel mundo ajeno. Pero eran las versiones que otros deseaban ver. No se reconocía en esos reflejos, igual que tampoco reconocía la luna colgada del cielo. Al menos de noche podía sentir con claridad la llamada que venía de más allá de los cielos. No hacía ruido alguno y, sin embargo, la entendía: la Luna de Escarcha la llamaba a casa.

¿Primavera, verano, otoño o invierno?

Invierno, sin ninguna duda.',
  biography_source_es = 'https://genshin-impact.fandom.com/wiki/Columbina%2FProfile',
  biography_es_translated = true
where id = 'gi-columbina';
update public.characters set
  biography_en = 'The General Mahamatra of the Akademiya, leader of all the Matras. He has a unique sense of humor that never fails to leave a deep impression.

As the leader of all Matra, General Mahamatra Cyno is well known to everyone in the Akademiya.

His duties are to arrest those who violate the Akademiya''s rules and regulations, terminate illegal studies, and uphold discipline of the Akademiya. Nevertheless, researchers feel that this General Mahamatra does nothing but undermine academic progress and prohibit scientific research.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Cyno%2FProfile',
  biography_es = 'Gran Juez de la matra y supervisor de los eruditos de la Academia de Sumeru. Cuando trabaja, es incluso más eficiente que la "Gran Vayuvyastra" creada por la Facultad Kshahrewar.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Cyno%2FHistoria',
  biography_es_translated = false
where id = 'gi-cyno';
update public.characters set
  biography_en = 'Deacon of the Church of Favonius and Herald of the Anemo Archon, as well as the church choir cantor. If one should seek the guidance of Barbatos, there is none better to consult than Dahlia. Be sure to bring plenty of baggage, he likes hearing people talk about their troubles.

In this city blessed by freedom, people choose to follow many different paths — from those who seek peace and leisure, to those who yearn for the thrill of adventure. As for Dahlia, well, he''s the kind of person whose morning prayers are filled with entreaties for trouble to come his way.

Deacon of the Church of Favonius and leader of the church''s choir, he is a man blessed by the gods who is said to hear the will of the divine. When the people face hardships and seek guidance from on high, it is Dahlia who leads their morning prayers, beseeching Barbatos for answers on their behalf.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Dahlia%2FProfile',
  biography_es = '"Para resolver un conflicto entre dos ciudadanos, es necesario aplicar la ley y la justicia. En cambio, Dahlia... Lo que él hace es llevar a la taberna a dos personas enfrentadas, no hablar del tema y dedicarse a beber hasta que, de algún modo que no entiendo, esas dos personas se convierten en amigos de copas. Pero... ¿de verdad eso soluciona el conflicto?".
Mucha gente de Mondstadt cree que Dahlia es el favorito del Arconte Anemo. Cuando alguien necesita que dicho Arconte le guíe, Dahlia suele recibir respuestas al preguntar a la deidad.

Por esta razón, los devotos que buscan las bendiciones de Barbatos a menudo se reúnen frente a Dahlia para contarle sus problemas.

Sin embargo, esto nunca ha sido una molestia para él, sino que, es más, hasta se divierte con ello.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Dahlia%2FHistoria',
  biography_es_translated = false
where id = 'gi-dahlia';
update public.characters set
  biography_en = 'A member of "The Eremites," a loosely-organized mercenary organization. She is brave, powerful, and enjoys an excellent reputation among mercenaries.

The term "Eremites" does not reference a specific group or organization, but all those who are born of the desert and ply a trade using their martial prowess, operating as mercenaries.

Frail is humanity in such a desolate profession. To survive, those who walk the path of a mercenary will naturally come together, forming loose bands of mercenaries.

Though the Eremites are many, few among them will be remembered as legends, with most bound to be as evanescent as sand in the wind. Yet there are exceptions who, like Dehya, may linger in the annals of history.

The "Flame-Mane" Dehya is fierce and brave, the lion her moniker invokes an analogy for her might. The nickname itself, meanwhile, denotes her passionate nature.

Should you be planning to hire a mercenary to serve as a bodyguard, Dehya stands as a prime choice.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Dehya%2FProfile',
  biography_es = 'Dehya, miembro de Los Eremitas, una organización de mercenarios del desierto de Sumeru. Es valiente, poderosa y goza de una gran reputación en dicha organización.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Dehya%2FHistoria',
  biography_es_translated = false
where id = 'gi-dehya';
update public.characters set
  biography_en = 'As the wealthiest gentleman in Mondstadt, the ever-dapper Diluc always presents himself as the epitome of perfection. But behind the courteous visage burns a zealous soul that has sworn to protect Mondstadt at all costs, allowing him to mercilessly vanquish all who threaten his city.

As the city of ballads and wines, Mondstadt''s alcohol industry is renowned all over Teyvat.

As owner of the Dawn Winery, Diluc is essentially in charge of half the industry. This means he has a huge stream of revenue and an entire network of information, in the form of tavern patrons'' gossip, right at his fingertips.

In a way, he is the uncrowned king of Mondstadt.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Diluc%2FProfile',
  biography_es = 'El magnate del imperio vinícola de Mondstadt, inigualable en todos los sentidos.

Como el hombre más rico de Mondstadt, Diluc siempre muestra su lado más exquisito. Sin embargo, su verdadera naturaleza es la de un guerrero con una gran determinación. Protege a Mondstadt con todas sus fuerzas en todo momento.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Diluc%2FHistoria',
  biography_es_translated = false
where id = 'gi-diluc';
update public.characters set
  biography_en = 'The incredibly popular bartender of the Cat''s Tail tavern, rising star of Mondstadt''s wine industry, and the greatest challenger to its traditional powerhouses. A feisty feline young lady from Springvale, any drink mixed by Diona''s hand tastes delicious beyond belief. Yet given her extreme distaste for alcohol, is her talent a blessing or a curse?

Whenever a guest walks into the Cat''s Tail, they will immediately glance in the direction of the bar.

Behind it often stands a girl with mildly-twitching cat ears, cocktail shaker in hand, and an unhappy look on her face.

This is the mixologist Diona, ascendant star of Mondstadt''s wine industry, and the greatest challenger to its traditional powerhouses.

However, she does not make these wonderful cocktails on purpose — indeed, quite the opposite.

Her mixing methods can seem a little "inscrutable" to an outsider.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Diona%2FProfile',
  biography_es = 'Una joven que ha heredado trazas de sangre no humana. Ella es la increíble y popular camarera de la taberna Cola de Gato.
"¿Cómo, oh, cómo puedo hacer bebidas con un sabor horrible...? Tenía grandes esperanzas en el" ''Cóctel de salsa de soja, leche, chile Jueyun y semillas de diente de león'', ¡mi combinación más de pesadilla hasta la fecha! Pero incluso eso fue recibido con elogios en la taberna: "¡Esta es la mejor bebida de la pequeña Diona hasta ahora!" Grr... pero no me rendiré... "',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Diona%2FHistoria',
  biography_es_translated = false
where id = 'gi-diona';
update public.characters set
  biography_en = 'Dori is a merchant in Sumeru who has a fondness for glittering Mora. With her persuasive eloquence, she is able to sell various strange and mysterious products for a very high price.

"Dori Sangemah Bay, owner of the Palace of Alcazarzaray, super-duper merchant who sells everything you need!"

When one holds Dori''s name card, this impressive title instantly comes into view.

Dori is, however, indeed the most special Sumeru merchant of all.

She already possesses vast wealth, but is still fervently passionate about earning Mora;

She already owns multiple well-renowned merchant caravans, yet she always travels across Sumeru to sell her marvelous items in person.

Speaking of which, her wares are just as curious as her style: special travel kit, outdoor dryer machines, automatic snowball launchers... You can probably buy anything you can think of from Dori. The only question is: Do you have enough Mora to do so?',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Dori%2FProfile',
  biography_es = 'Una impredecible comerciante itinerante cuya mayor pasión es el Mora contante y sonante.

La impredecible Dori tiene mil y un tesoros.

Como la comerciante con mayor talento de Sumeru, Dori te conseguirá todo lo que necesitas, ya sean piedras preciosas, hierbas medicinales poco comunes o extraños artefactos de los que nadie ha oído hablar nunca.

Aunque, claro está, todo tiene un precio. Dori siempre tiene una sonrisa afable en el rostro, pero sus precios son terroríficos.

Algunos piensan que es como la lluvia después de una larga sequía. Otros opinan que es la mecha que prende el fuego.

Aunque ninguno de esos rumores llegará nunca a oídos de Dori. El único sonido que resuena en el Palacio Alcazarzaray es el tintineo de los Moras.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Dori%2FHistoria',
  biography_es_translated = false
where id = 'gi-dori';
update public.characters set
  biography_en = 'Once a dragon who lived in a fairy tale, he now strives to learn how to live as a human.

After one particular Windblume Festival, a new face appeared in Mondstadt — a young boy with horns upon his head and wings growing from his back. Master Jean told the people that this boy had once been a dragon. Through wondrous alchemy, he had gained a human form and now sought to learn how to live among them.

A dragon turning into a human wasn''t exactly shocking news. After all, countless fairy tales had sprouted from Mondstadt’s soil. What truly stirred the people''s curiosity was the boy''s name: Durin.

Whenever that name was spoken aloud, people would instinctively look toward Dragonspine. Beneath its blinding snows lay the colossal bones of a creature long gone, and with them, memories of a calamity best left buried.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Durin%2FProfile',
  biography_es = '"¡Oh, enemigo del malvado dragón Tarasca! ¡Oh, gran bestia que desafía el mismísimo destino! Mi ojo izquierdo ha percibido el entrelazamiento entre la causa y el efecto. El recién nacido forjado en un sueño para arribar a este mundo atravesará la destrucción de tres mil universos y, en la hora final del juicio divino, declarará aquel nombre prohibido ante su enemigo predestinado". "Lo que quiere decir la señorita es... Bueno, no importa".

En el pasado, cuando los forasteros en Mondstadt preguntaban por la historia de Durin, la mayoría de los residentes contaban una trágica historia: la de cómo el malvado dragón Durin descendió entre una oleada de monstruos, atacó la ciudad y luchó contra Dvalin en los cielos, trayendo el desastre a Mondstadt hasta que, finalmente, pereció en la montaña nevada.

Sin embargo, no hace mucho, cuando los forasteros volvieron a preguntar por la historia de Durin, las respuestas que recibieron fueron bastante diferentes.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Durin%2FHistoria',
  biography_es_translated = false
where id = 'gi-durin';
update public.characters set
  biography_en = 'A renowned perfumer from Fontaine. Elegant, charming, and a little mysterious... just like her work.

There is much that may be said when discussing a bottle of perfume.

We might speak of its fragrance: How it first bewitches with its top notes, before gradually melding with its wearer, and finally taking a subdued bow amidst the lingering aroma.

We could speak of the concept underlying its design: Is it meant to enliven the spirit, or to lend an aura of alluring mystique?

We might even debate the most appropriate occasion for its use: Would one be willing to attend a social ball clad in this aroma, or would it be better suited to suffusing the atmosphere of a private date?

Emilie finds these matters to be most worthy of discussion, as they are intimately related to how one selects a perfume.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Emilie%2FProfile',
  biography_es = 'Una perfumista de renombre de Fontaine. Elegante, encantadora y un poco misteriosa... igual que su trabajo.

Hay mucho que decir cuando se habla de un frasco de perfume.

Podríamos hablar de su fragancia: de cómo primero seduce con sus notas de salida, luego se funde poco a poco con quien lo lleva y por fin se despide con discreción entre un aroma que persiste.

Podríamos hablar del concepto que hay detrás de su diseño: ¿busca animar el espíritu o envolver a quien lo usa en un aura de misterio seductor?

Incluso podríamos discutir cuál es la ocasión más apropiada para llevarlo: ¿acudirías a un baile de sociedad con este aroma, o encaja mejor en la atmósfera de una cita privada?

A Emilie le parece que estas cuestiones merecen mucho la pena, porque tienen que ver directamente con cómo se elige un perfume.',
  biography_source_es = 'https://genshin-impact.fandom.com/wiki/Emilie%2FProfile',
  biography_es_translated = true
where id = 'gi-emilie';
update public.characters set
  biography_en = 'A renowned, exacting Fontainian chef. Diligently seeking the pinnacle of culinary excellence.

For many years, Fontainian cuisine — exemplified by a focus on elegant sophistication — has been a popular palate-pleaser throughout Teyvat. If you were to inquire among food critics as to what best embodies the principles of Fontainian food, few if any would omit the great "former head chef of the Hotel Debord," Escoffier, from the forefront of their name lists.

In the eyes of discerning diners, Escoffier is both the founder of "precision gastronomy" and a leading proponent of "the principles of innovative cuisine." She excels at taking flavorings measured with the precision of scientific rigor and crafting them into dazzling, dynamic taste experiences.

According to countless food critics, she is a "demon chef" who continues to breathe new life into the culinary world while sending shivers down the spines of dietary dinosaurs — those stubbornly unreceptive to change and fresh avenues in cu',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Escoffier%2FProfile',
  biography_es = '"¿''El hada del dulce''?, ¿''la tirana de las papilas gustativas''? No es tan exagerado como lo pintan los periódicos. Escoffier no es más que una chica a la que le gusta cocinar... y que es un poco estricta. Quienes no se toman la cocina en serio no son dignos de su respeto. De todos modos, el ''sabor'' de ustedes dos seguro que combina la mar de bien, ¡no me cabe duda!".
Durante mucho tiempo, la columna gastronómica de «El Pájaro de Vapor» ha sido considerada por los gourmets como el lugar al que acudir en busca de nuevos sabores. Colaboradora habitual de esta sección, la antigua jefa de cocina del Bistró Debord, Escoffier, y su "cocina de precisión" gozan de gran reputación en toda Fontaine.

"Analizar", "extraer" y "mezclar". Lo que Escoffier desmenuza no son solo "extractos", sino también la percepción inherente de la gente de Fontaine acerca de lo "delicioso".',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Escoffier%2FHistoria',
  biography_es_translated = false
where id = 'gi-escoffier';
update public.characters set
  biography_en = 'A rebellious descendant of the old aristocracy who is always out on the battlefield. As one born into the old aristocracy, carrying the bloodline of sinners, Eula has needed a unique approach to the world to navigate the towering walls of prejudice peacefully. Of course, this did not prevent her from severing ties with her clan. As the outstanding Spindrift Knight, she hunts down Mondstadt''s enemies in the wild to exact her unique "vengeance."

Eula''s role within the Knights of Favonius is Captain of the Reconnaisance Company.

The nature of her work means that she rarely sets foot in the city — she spends most of her time out in the wild, leading her team of scouts as they hunt down Abyss Order operatives and other monsters.

Known as the Spindrift Knight, Eula wields her blade with consummate skill, but perhaps more importantly, she is well-versed in strategy and possesses great courage and excellent intuition.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Eula%2FProfile',
  biography_es = 'La Caballera de la Marea, procedente de una familia con un gran linaje y Capitana de la Compañía de Reconocimiento de los Caballeros de Favonius. Aunque es descendiente de la antigua aristocracia, se unió a los Caballeros de Favonius, sus archienemigos, algo que sigue siendo un gran enigma para toda Mondstadt hasta hoy en día.

Una descendiente rebelde de la vieja aristocracia que siempre está en el campo de batalla. Como alguien nacida en la vieja aristocracia, portadora de la línea de sangre de los pecadores, Eula ha necesitado un enfoque único del mundo para navegar pacíficamente por los imponentes muros de los prejuicios. Por supuesto, esto no le impidió romper los lazos con su clan. Como la excepcional Caballera de la Marea, caza a los enemigos de Mondstadt en la naturaleza para exigir su "venganza" única.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Eula%2FHistoria',
  biography_es_translated = false
where id = 'gi-eula';
update public.characters set
  biography_en = 'A distinguished Akademiya scholar from "a century ago" and one of the founders of Ancient Mechanics as a field of study. Although she hailed from Haravatat, she was renowned for her talents in machinery throughout Sumeru... Even though these honors have been forgotten in the river of time, much as she has.

If you were to open any Kshahrewar textbook, you will find Faruzan''s record penned proudly upon the author page.

"Faruzan, outstanding researcher of the Akademiya, winner of the Sumeru Puzzlers'' League Lifetime Achievement Award, one of the seminal scholars of Ancient Mechanics."

But if you were to talk to Haravatat students about their choices, they frown as they speak of Faruzan''s current state.

"Oh, you mean her... Well, her research is...',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Faruzan%2FProfile',
  biography_es = '"Gran parte del contenido de este libro procede de las investigaciones y manuscritos de doña Faruzán. Esperamos que las futuras generaciones de eruditos recuerden su nombre cuando vuelva a la Academia".

Entre los eruditos de la Facultad Kshahrewar circula una historia que dice así:

Si has suspendido los exámenes de mecánica y no te atreves a pedir clases de recuperación a tu tutor disgustado, puedes dirigirte a la Facultad Haravatat, que está al lado, y pedirle a doña Faruzán algunos consejos.

No es necesario preparar un regalo. Solo acuérdate de mostrar sinceridad y humildad y llamarla "doña Faruzán" respetuosamente. Eso será suficiente para ganarte a esta enciclopedia de mecánica andante.

Las explicaciones de doña Faruzán son sencillas pero perspicaces de entender, y sus profundos conocimientos hacen que la gente se pregunte si ha participado en la redacción del programa de estudios.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Faruz%C3%A1n%2FHistoria',
  biography_es_translated = false
where id = 'gi-faruzan';
update public.characters set
  biography_en = 'A mysterious girl who calls herself "Prinzessin der Verurteilung" and travels with a night raven named Oz. Currently serves as an investigator in the Adventurers'' Guild. Through her unique abilities, eccentric character, and (while she would never admit it herself) hard work, Fischl has become a rising star among the Adventurers'' Guild''s investigators, earning the recognition of all.

Fischl is the Prinzessin der Verurteilung who arrived here after being exiled from the otherworld, "Immernachtreich."

She "observes and weaves the threads of fate" together with her talking night raven familiar, Oz.

Owing to reasons she cannot and Oz will not explain, Fischl now serves the Adventurers'' Guild as an investigator.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Fischl%2FProfile',
  biography_es = 'Una chica misteriosa que se hace llamar “Princesa del Juicio”. Siempre camina junto con un cuervo oscuro llamado Oz.

Una chica misteriosa que se hace llamar "la princesa del juicio". Siempre camina junto con un cuervo oscuro, llamado Oz. Actualmente hace de investigadora en el Gremio de Aventureros. Con sus habilidades únicas, su carácter excéntrico y su duro trabajo (aunque ella misma nunca lo admitiría), Fischl se convirtió en una estrella en ascenso entre los investigadores del Gremio de Aventureros, ganándose el reconocimiento de todos.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Fischl%2FHistoria',
  biography_es_translated = false
where id = 'gi-fischl';
update public.characters set
  biography_en = 'Kyryll Chudomirovich Flins, a Ratnik of Nod-Krai — this is how he likes to introduce himself.

There is a small isle in the central-southern region of Nod-Krai that has earned the name "Final Night Cemetery" on account of its lonesome, dismal air. Few visit, and merchant caravans only sometimes loop far around it. Jutting above its soil is a lighthouse languishing in disuse, where only the spirits of the dead consent to dwell, it is said.

Amidst the deathly silence, only one living soul remains. This gentleman tends to introduce himself as such: Flins, a warrior of the Lightkeepers, the awardee of a civilian commendation medal in recognition of his squad''s efforts in repelling Abyssal creatures.

The incident he mentions happened a long time ago.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Flins%2FProfile',
  biography_es = '"El señor Flins vive en un faro muy lejano. Es muy proactivo y parece saber mucho sobre tácticas de combate... O al menos eso es lo que he oído. Lo siento, no tengo total certeza sobre ello. Me uní al equipo más tarde y nunca he trabajado con él, así que todo lo que he dicho se lo oí al starshiná. ¿Quieres saber qué pienso yo? Humm... Creo que tiene muchas historias que contar. Además, ¿no te parece sorprendente que, a pesar de ser un soldado, sea una persona de muy buenos modales y sepa usar su elocuencia para conseguir lo que quiere?".Cuando llega la temporada de cosecha, ningún visitante es un desconocido, por lo que cualquier persona puede aparecer durante las festividades.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Flins%2FHistoria',
  biography_es_translated = false
where id = 'gi-flins';
update public.characters set
  biography_en = 'A taciturn young man and an expert diver, his heart remains as innocent as the fairytales that never cease to absorb him.

Whether you''re a tourist visiting Fontaine for the first time or an adventurer who''s set their heart on finding legendary treasures, you''re sure to be captivated by the enchantments of the underwater world. But those who attempt to explore the depths without first undergoing rigorous training or making the necessary preparations are gambling with their lives. Treacherous underwater currents, unexpected bodily reactions, and monsters lurking in the deep... Peril always comes without knocking. Seeking the help of a professional diver is always a wise choice.

If you ask people who''s the most talented diver around, you''re likely to hear the name of Freminet. Even old veterans, bronzed and toughened by long exposure to the elements, never tire of lauding his skills.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Freminet%2FProfile',
  biography_es = 'Un joven callado y buceador experto, cuyo corazón sigue siendo tan inocente como los cuentos de hadas que nunca deja de devorar.

Tanto si eres un turista que visita Fontaine por primera vez como si eres un aventurero empeñado en encontrar tesoros legendarios, el encanto del mundo submarino te atrapará. Pero quien intenta explorar las profundidades sin un entrenamiento riguroso ni la preparación necesaria se está jugando la vida. Corrientes traicioneras, reacciones inesperadas del cuerpo, monstruos que acechan en el fondo... El peligro nunca llama a la puerta. Buscar la ayuda de un buceador profesional siempre es una decisión sensata.

Si preguntas quién es el buceador con más talento de la zona, lo más probable es que oigas el nombre de Fréminet. Incluso los veteranos más curtidos por la intemperie no se cansan de alabar su técnica.',
  biography_source_es = 'https://genshin-impact.fandom.com/wiki/Freminet%2FProfile',
  biography_es_translated = true
where id = 'gi-freminet';
update public.characters set
  biography_en = 'The "Regina of All Waters, Kindreds, Peoples and Laws" is deeply loved by her people. She follows each and every trial held at the Opera Epiclese with an inextinguishable passion, and is always acutely aware of how the "audience" sees things.

It is unlikely that travelers from other nations will understand why the god of this land is regarded as a "superstar" unless they set foot in the Opera Epiclese.

Whether at performances or trials, she will always be in the seat reserved for her above the audience, laughing, scolding, falling into hysterics, to the point where more often than not she makes a stronger impression than the action onstage.

People buy tickets to indulge in new sensory experiences, and in this regard, Furina is by far more popular than the absolute justice that Neuvillette represents.

The forms respect can take are not limited to just lifting one''s eyes up to a being above, and the unique form of respect Fontainians have for Furina is perhaps described better as "af',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Furina%2FProfile',
  biography_es = 'Las mentiras nacen para cubrir otras mentiras, y la justicia aguarda al final de todas ellas. El ignorante se ríe de ello, pues no es más que una farsa... hasta que descubre el origen de todo y se da cuenta de que él fue el primero en mentirse a sí mismo.

Las gentes de Fontaine acogieron con gusto a Furina desde el primer momento en que se convirtió en la Arconte Hydro.

Su retórica, su ingenio y su elegancia, la cual mantiene en todo momento, reflejan su gran carisma como Arconte.

Pero, tal vez, por lo que Furina recibe más reconocimiento es por su particular teatralidad.

Tal y como dice el guion de una famosa obra de la Ópera de la Epíclesis:

"La vida es como una obra de teatro: nunca sabes en qué capítulo habrá un giro argumental".

Así es Furina, muy enigmática, pues nunca nadie es capaz de adivinar cuál será su siguiente movimiento.

Pero precisamente por este motivo, la diosa de los juicios y la justicia deja a todo el mundo fascinado desde su trono divino.

No obstante, al i',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Furina%2FHistoria',
  biography_es_translated = false
where id = 'gi-furina';
update public.characters set
  biography_en = 'Gold-Standard Guard of the Sword and Strongbox Secure Transport Agency, and the head of the "Mighty Mythical Beasts" Wushou troupe. Talkative and full of zeal, he''s a classic people person.

Goods flow through Yilong Wharf round the clock, and the merchant convoys and their cargo have need of guards to escort them through the various regions of Liyue to other lands.

Since ancient times, such escort work has been no easy task.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Gaming%2FProfile',
  biography_es = 'Escolta de la Agencia de Transporte Seguro Cofrespada y líder del grupo Bestias Místicas Poderosas.

Nacido en la Aldea Chiaoying, Gaming dejó su lugar de nacimiento después de un impasse con su padre para perseguir su pasión y convertirse en un bailarín profesional de Wushou, entrenando constantemente para hacer que el baile fuera popular en todo Teyvat. Sin embargo, como la carrera de sus sueños resultó ser financieramente insostenible, también aceptó un trabajo como guardia para una Agencia de Transporte Seguro, principalmente escoltando mercancías y personas hacia y desde el Puerto Yilong. Su diligencia y amabilidad le han valido renombre y se le considera el mejor guardia de la agencia.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Gaming%2FHistoria',
  biography_es_translated = false
where id = 'gi-gaming';
update public.characters set
  biography_en = 'The secretary to the Liyue Qixing. The blood of both human and illuminated beast flows within her veins. Graceful and quiet by nature, yet the gentle disposition of qilin sees not even the slightest conflict with even the most arduous of workloads. After all, Ganyu firmly believes that all the work she does is in honor of her contract with Rex Lapis, seeking the well-being of all living things within Liyue.

Though many in Liyue are fascinated by life in Yujing Terrace, its day-to-day operations and rules are a mystery to them.

They are aware that the Liyue Qixing are the cream of the crop who hold the fate of the city in their hands, but the calculations and data behind the Qixing''s every decision are far harder to grasp.

The people understand that the new policies announced each year will change the dynamics of the market, yet none can comprehend how policy is plucked from complex meeting minutes and compiled into something easier on the human eye.

As the secretary of Yuehai Pavil',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Ganyu%2FProfile',
  biography_es = 'La secretaria del Pabellón Yuehai, la sangre de las bestias iluminadas Chilin fluye por sus venas.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Ganyu%2FHistoria',
  biography_es_translated = false
where id = 'gi-ganyu';
update public.characters set
  biography_en = 'Gorou is the great general of Watatsumi Island''s military, and he is deeply loved by his subordinates.

During the period of the Vision Hunt Decree, Gorou led the forces of Watatsumi against the Shogun''s Army, and successfully held the line against them.

The troops call him the "ever-victorious pointy-eared general," a nickname that has also seen broad use among Shogunate warriors.

In private, however, Gorou puts on no airs and is a straightforward person, which has led him to be regarded by all as the man with the plan.

But even such an exemplary general must have his fair share of troubles...',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Gorou%2FProfile',
  biography_es = '"La gentileza y la honestidad son la representación de la virtud. Sin duda, mi amigo Gorou es un general virtuoso".
Un general de Watatsumi destacado por su lealtad y coraje. Posee el instinto de combate innato de una bestia y encuentra la forma de hacerse con la victoria hasta en los momentos más críticos.

Lidera las tropas de Watatsumi, que disponen de muchos menos recursos militares en comparación con el shogunato. Gorou se esfuerza por garantizar que los habitantes de este lugar vivan seguros y en paz.

Tal vez los forasteros no puedan imaginar que Gorou, alguien que se enfrenta a miles de enemigos en el campo de batalla, en realidad es un muchacho de lo más amable que se lleva bien con todos sus subordinados.

Para Gorou, las personas que le rodean no solo son sus valientes soldados, también son sus queridos compañeros, son como un tesoro al que hay que cuidar y proteger. La tierra que nos sostiene, los compañeros que nos apoyan, la fe que nos anima a seguir adelante...',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Gorou%2FHistoria',
  biography_es_translated = false
where id = 'gi-gorou';
update public.characters set
  biography_en = 'A young prodigy detective from the Tenryou Commission. His senses are sharp and his thoughts are ingenious. No matter what unsolved case he''s facing, he can get to the truth in unexpected ways.

Shikanoin Heizou is an extraordinary young detective.

Though working at the Tenryou Commission, he is at odds with the usual impression of a public servant, who is expected to be "stern," "solemn"... and "solemn" again.

On the outside, he appears more well-behaved and polite than any other new hires, but on the inside, he is actually thumbing his nose at all the official mumbo jumbo.

Unlike his colleagues, he does not go to the Station to report for duty on a daily basis and rarely shows up for any routine patrols.

It can seem like ages since you last saw him, and you may finally chance upon him at some crime scene.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Heizou%2FProfile',
  biography_es = 'El joven y talentoso detective de la Comisión Tenryou, de espíritu libre, alegre y vivaz.

Parece un debilucho, pero en realidad es el mejor detective de la Comisión Tenryou reconocido por todos.

Es un hombre con una imaginación desbordante y una meticulosa capacidad de razonamiento lógico, así como con un enfoque intuitivo sorprendente para la resolución de casos.

Cada vez que ocurre un crimen, mientras que sus colegas buscan pistas basándose en su experiencia, él ya ha encontrado la respuesta correcta tomándolo desde una perspectiva inesperada.

La gente siente una gran admiración por su poderosa intuición. Cuando dicen que su pensamiento y eficiencia es como una guía divina, es cuando Heizou mostraría confiadamente su típica sonrisa: "¡Puede que ni siquiera los Arcontes fueran capaces de hacerlo!"

El guardia Shikanoin tiene un ingenio y una perspicacia admirables. Es un hombre de gran talento, aunque nunca lo oculta.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Shikanoin%20Heizou%2FHistoria',
  biography_es_translated = false
where id = 'gi-heizou';
update public.characters set
  biography_en = 'Hu Tao is the 77th Director of the Wangsheng Funeral Parlor, a person vital to managing Liyue''s funerary affairs. She does her utmost to flawlessly carry out a person''s last rites and preserve the world''s balance of yin and yang. Aside from this, she is also a talented poet whose many "masterpieces" have passed around Liyue''s populace by word of mouth.

The 77th Director of the Wangsheng Funeral Parlor, a young lady managing the parlor''s operations. Despite her position, she''s an amiable person who puts on no airs.

Her antics are as plentiful as the sand on Yaoguang Shoal. She never ceases to shock people with her countless bizarre ideas.

Hu Tao may seem like all play and no work, spending every free moment on leisure and being widely considered a laissez-faire business owner.

It is only during funeral ceremonies, when she personally leads her undertakers through lamp-lit alleys, that she shows her dignified and solemn side.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Hu%20Tao%2FProfile',
  biography_es = '77.ᵃ directora de la Funeraria El Camino. Pese a su corta edad, ya es la principal encargada de todos los asuntos funerarios en Liyue.

Hu Tao es la 77.ᵃ directora de la Funeraria El Camino, es la encargada de todos los asuntos funerarios de Liyue.
Invierte toda su energía en que el ultimo adiós del cliente sea lo mas solemne posible y en proteger el equilibrio entre el yin y el yang. Además, ella es una peculiar poetisa cuyas obras maestras han pasado de boca en boca entre los habitantes de Liyue.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Hu%20Tao%2FHistoria',
  biography_es_translated = false
where id = 'gi-hu-tao';
update public.characters set
  biography_en = 'The head coach of the fitness club at the Collective of Plenty, a renowned Natlanese nutritionist, and the founder of the "Pilgrimage Victors Academy." Overwhelmed by the prospect of training? Unsure of how to improve your strength? In that case, she''s the first person you should talk to.

When the people of Natlan think about the Collective of Plenty, the first thing that springs to mind is the tribe''s culture of fitness — followed shortly by mental images of towering, muscular, chiseled physiques...

Many first-time visitors to the Collective of Plenty, therefore, are surprised to learn that the current leading light of the tribe''s fitness scene is about as far away from those mental images as it''s possible to be.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Iansan%2FProfile',
  biography_es = '"La entrenadora Iansán es la mejor instructora de ejercicio físico de toda Natlan, ¡y la persona a quien más respeto! Todo el mundo dice que tengo mucho talento, pero si no fuera por ella, probablemente habría desperdiciado mi talento comiendo. No te preocupes si no tienes el hábito de hacer ejercicio, ¡la entrenadora Iansán siempre se adapta a las circunstancias de sus alumnos! Ah, hablando de eso, ¿quiere echar un vistazo a este panfleto? ¡La entrenadora está reclutando nuevos estudiantes!".
"¿Quieres superarte a ti mismo? ¿Te gustaría ser más fuerte?".

"En ese caso, ¡ven a la Comunidad de la Feracidad y participa en el Curso de Formación para los Vencedores del Peregrinaje!',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Ians%C3%A1n%2FHistoria',
  biography_es_translated = false
where id = 'gi-iansan';
update public.characters set
  biography_en = 'A vet from the Flower-Feather Clan, beloved by humans and animals alike. The round creature by his side is his assistant.

In the eyes of the Natlanese, the Flower-Feather Clan lives in the sky. Although the Scions of the Canopy bound between their cliffs, and the Masters of the Night-Wind stargaze from their summits, only the Flower-Feather Clan has the privilege of catching clouds and riding rainbows like true knights of the skies.

The sensation of gazing up is one without equal. No obstacles in sight, only a vast plain of emptiness through which humanity yearns to soar, slaking its thirst for a life free of earthly shackles.

But the fires of war spread ever beneath their feet, followed by cries for help. Even a Qucusaur, once wounded, is forced to descend to the earth.

Ifa, then, is the knight whose eyes never leave the ground, out of both duty and habit.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Ifa%2FProfile',
  biography_es = 'Un veterinario del Clan Flor y Pluma, querido por igual por personas y animales. La criatura redonda que lo acompaña es su ayudante.

A ojos de los natlanenses, el Clan Flor y Pluma vive en el cielo. Aunque los Vástagos del Dosel saltan entre sus riscos y los Maestros del Viento Nocturno contemplan las estrellas desde las cumbres, solo el Clan Flor y Pluma tiene el privilegio de atrapar nubes y cabalgar arcoíris como auténticos caballeros del firmamento.

La sensación de mirar hacia arriba no tiene igual. Ningún obstáculo a la vista, solo una vasta llanura de vacío por la que la humanidad ansía volar, saciando su sed de una vida libre de ataduras terrenales.

Pero el fuego de la guerra se extiende sin descanso bajo sus pies, seguido de gritos de auxilio. Incluso un qucusaurio, una vez herido, se ve obligado a descender a tierra.

Ifa es, por tanto, el caballero que nunca aparta la mirada del suelo, por deber y por costumbre.',
  biography_source_es = 'https://genshin-impact.fandom.com/wiki/Ifa%2FProfile',
  biography_es_translated = true
where id = 'gi-ifa';
update public.characters set
  biography_en = 'A member of the Lightkeepers'' investigation squad, the Nightmare Orioles, he is much like the lantern he carries — both a guiding light and a source of care.

Spring in Nod-Krai is cruel.

Unlike the Northlands, where snow blankets the earth through all four seasons, denying even a glimmer of hope to the life buried beneath, the spring in Nod-Krai ushers in a false sense of optimism.

As the bitter winter loosens its grip, the frost melts into the thirsty soil, and seeds buried deep since the year before drink once more of the sweet, damp earth. They sense warmth above and stir, believing the frigid foe who shattered their stems and leaves has vanished with the passing of time — spurred by that fleeting promise, tender sprouts strain to push through the cracked earth and taste the air above.

But it is all a lie — a trap woven for the unwary.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Illuga%2FProfile',
  biography_es = '"Illuga está muy agradecido por la ayuda de los Caballeros de Favonius durante la batalla. Lamentablemente, tuvo que partir a otra misión de investigación, así que me pidió que te entregara esta botella de vino como muestra de su gratitud".

“Jajaja, qué amable es ese muchacho. En realidad, él fue quien más duro trabajó. Ah, qué lástima que no esté aquí, así no voy a poder rechazar su regalo... ¿Qué tal si abrimos la botella aquí mismo? Así puedo hablarte del brillante futuro que le espera a Illuga”.

"Je, podemos beber si quieres, pero no aproveches para robarme al personal".
Para cada nuevo miembro que se une a los Lampareros, no hay mayor fortuna que tener a alguien como Illuga como líder.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Illuga%2FHistoria',
  biography_es_translated = false
where id = 'gi-illuga';
update public.characters set
  biography_en = 'A robot from Nod-Krai constructed using mechanical components from all over the world. She was designed and built at the Clink-Clank Krumkake Craftshop.

Regarding mechanical life forms and their "sense of self," a scholar once proposed the following thought experiment: Suppose a machine''s parts age and are replaced each day. In time, all of its parts will have been replaced, and none of its original components will remain. At that point, is that machine still its original "self"?

This question never seemed to pose much of a problem for Ineffa: No matter how many times her outer shell or components were replaced, her "core" had always remained the same. Ineffa''s core was quite literally her home.

But what would happen if her core were ever dismantled in some way? Which part would represent her then? Even though Ineffa''s maker did not yet possess the technological skill, she had always yearned to take apart Ineffa''s core and analyze it.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Ineffa%2FProfile',
  biography_es = '"Antes que nada, ¡hay que reconocer que Ineffa es la mejor robot del mundo! Luego, hay que saber respetar sus opiniones y decisiones. Además, el derecho de interpretación final le pertenece al Taller de Krumkake Cling... Eh, ¡quiero decir, a Ineffa!".
Que los humanos hayan intentado emular el funcionamiento de la vida a través de mecanismos y engranajes no es una ocurrencia poco común en la historia de Teyvat.

Khaenri''ah abrió la tierra con gigantes forjados de acero, y el rey de la mecánica dio paso a una nueva era con mecanismos propulsados con mecatecnología.

Tal vez, a ojos de algunos locos, la humanidad no sea más que una máquina construida con carne y huesos.

Si echamos la vista a los creadores de las cosas no humanas y llevamos los límites más allá de las creaciones mecánicas...

Nos daremos cuenta de que los dioses se adentraron en el Mar Primigenio y los pecadores se lanzaron al Abismo, igual que el antiguo Rey Dragón grabó su consciencia y su alma en el flogisto.

Tal vez',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Ineffa%2FHistoria',
  biography_es_translated = false
where id = 'gi-ineffa';
update public.characters set
  biography_en = 'The Curatorium of Secrets'' extremely reliable, do-it-all super employee (or so she claims).

When people from Nasha Town speak of the only official employee of the Curatorium of Secrets, they always acknowledge Jahoda''s abilities — well, some of them — before wondering aloud:

Why would the boss of the Curatorium of Secrets hire no one else but her?

After all, that loose-tongued, ever-stumbling girl is always going on about how she''s "the master thief who''s plundered every corner of Nod-Krai," "the most street-smart local around," "the one who''s got connections everywhere." Such talk might fool a few outsiders, but there''s no way it could ever fool the sharp-eyed Lady Nefer, right?

"At any rate, just trust my judgement."

Whenever a partner shows even the slightest doubt, Nefer always responds with a gentle smile.

On some days when Lady Luck seemed to have completely abandoned her, Jahoda, after running into one problem after another during her commissions, would ask her dear boss w',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Jahoda%2FProfile',
  biography_es = '"Está bien, te daré la mano y no me iré. Aunque, como la última vez tardaste más en dormirte que la anterior, sugeriría probar el método favorito de Aino para conciliar el sueño: un buen abrazo". "De acuerdo, Jahoda, te abrazaré. No voy a marcharme".

Día tras día, entre todo el ruido y movimiento de la Villa Nasha, sus gentes están ya muy familiarizadas con la única empleada oficial de la Cámara de Secretos: la Srta. Jahoda.

A veces sale de la Cámara de Secretos pavoneándose mientras atraviesa las calles para comprarse una figura de caramelo extragrande. En otras ocasiones, corre por los tejados con aire exasperado mientras persigue a algún cliente que haya intentado estafarla.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Jahoda%2FHistoria',
  biography_es_translated = false
where id = 'gi-jahoda';
update public.characters set
  biography_en = 'As the Acting Grand Master of the Knights, Jean has always been devoted to her duties and maintaining peace in Mondstadt. She had taken precautions long before the onset of Stormterror''s assault, and she will guard Mondstadt with her life as always.

The Knights of Favonius are the protectors of Mondstadt, the swords and shields of the city.

In addition to keeping the city and the surrounding travel routes safe from the threat of wild monsters, the Knights'' most important responsibility is maintaining order among Mondstadt''s inhabitants.

Mondstadt is the City of Freedom, but unchecked freedom without any kind of rules only invites chaos and anxiety.

Jean''s understanding of this is the reason she remains diligent at all times, holding herself to impeccable standards.

However, she often finds that she exhausts her monthly quota of coffee within the first few days of the month as a result.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Jean%2FProfile',
  biography_es = 'La justa y rigurosa Caballera de Dandelion, y Gran Maestra Intendente de los Caballeros de Favonius de Mondstadt.

Jean, la Gran Maestra Intendente de los Caballeros de Favonius, siempre se ha dedicado religiosamente a sus tareas dentro de la orden y al mantenimiento de la paz en Mondstadt. A pesar de no tener grandes talentos, su gran diligencia la han convertido en uno de los miembros con más influencia. Cuando Stormterror amenaza la ciudad, toma medidas rápidamente y protege Mondstadt con todas sus fuerzas.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Jean%2FHistoria',
  biography_es_translated = false
where id = 'gi-jean';
update public.characters set
  biography_en = 'A young warrior of the Children of Echoes, given the Ancient Name of "Uthabiti." Kind-hearted and insatiably persistent, she grows stronger and more capable with each setback she faces.

Just like the other progeny of the Children of Echoes, Kachina grew up surrounded by adorable Tepetlisaurs, spending her time digging shiny gems out of the bowels of the mountains and listening to her elders passing down the legends of heroes.

She learned the mountain paths like the back of her hand, developing a great instinct and talent for finding minerals buried deep beneath the ground. When she had some time to kill, she''d be with all the other kids, running off to the music studios where artists were recording their newest tunes to just cut loose and dance freely to the pulsing rhythms.

Growing up in this environment, the occasional bump and scratch was unavoidable, and Kachina would cry out in pain when she hurt herself, just like any other child.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Kachina%2FProfile',
  biography_es = 'Recuerdo que cuando acabábamos de conocernos, vi a Kachina llorando y no pude evitar ofrecerle un pañuelo. Ella me miró sonriendo y dijo: ''No es nada, yo misma me secaré las lágrimas''. Esa frase se me quedó grabada en la memoria. Bueno, no te preocupes, en realidad Kachina es muy fuerte, pero aun así, ¡no olvides darle ánimos de vez en cuando!
Al igual que los demás niños de los Vástagos del Eco, Kachina ha crecido entre los adorables Tepetlisaurios, las relucientes piedras preciosas que excavan en las profundidades de las montañas y las historias de héroes que relatan los ancianos de la tribu. Asimismo, conoce los caminos entre los escarpados montes y es una excelente buscadora de los minerales que se hallan enterrados en el subsuelo. Cuando tiene tiempo libre, suele acercarse junto a los demás niños al taller donde graban música los artesanos de vinilos para bailar libremente al ritmo de sus canciones.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Kachina%2FHistoria',
  biography_es_translated = false
where id = 'gi-kachina';
update public.characters set
  biography_en = 'In the Knights of Favonius, Kaeya is the most trusted aide for the Acting Grand Master Jean. You can always count on him to solve any intractable problems. Everyone in Mondstadt loves Kaeya, but no one knows what secrets this witty, charming knight has...

Kaeya Alberich is an adopted son to the Ragnvindr Family, the renowned wine tycoon.

It has been a long time since he last called Diluc Ragnvindr "brother."

Kaeya currently serves as the Cavalry Captain of the Knights of Favonius, and is trusted by Jean.

Kaeya is often the one wrapping things up in every incident that occurs in Mondstadt''s vicinity.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Kaeya%2FProfile',
  biography_es = 'El gran estratega de los Caballeros de Favonius. Se rumorea que procede de un lugar de fuera de Mondstadt.

En los Caballeros de Favonius, Kaeya es el ayudante más confiable de la Gran Maestra Interina Jean. Siempre puede contar con él para resolver cualquier problema insoluble. Todos en Mondstadt aman a Kaeya, pero nadie sabe qué secretos tiene este ingenioso y encantador caballero.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Kaeya%2FHistoria',
  biography_es_translated = false
where id = 'gi-kaeya';
update public.characters set
  biography_en = 'A renowned architect from Sumeru who perhaps cares a bit too much about too many things. He is an aesthete troubled by reality.

In a land brimming with as much talent as Sumeru, one is practically spoiled for choice when it comes to designers. But when one speaks of architects, few are those who will not subconsciously think of "Kaveh."
The Kshahrewar graduate was once named the greatest architect in several decades and is known as the Light of Kshahrewar. Kaveh himself, however, is unfortunately unmoved by this title.

Such lovely names and titles are, to him, acknowledgment and shackles both. For example, Kaveh''s insolvency remains a matter of shame for him to this day. A person with little to no standing could just admit to such a thing, but a famous architect cannot. In fact, such undue candor might result in a crisis of reputation for him.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Kaveh%2FProfile',
  biography_es = 'Un célebre arquitecto de Sumeru que se preocupa demasiado por las cosas. Es un fanático de la estética, pero está atrapado por la realidad.

Kaveh es el reconocido arquitecto detrás del Palacio Alcazarzaray y el puente de Puerto Ormos, entre otros proyectos. Se graduó de la la Facultad Kshahrewar de la Akademiya de Sumeru con honores. Enseñó una asignatura optativa de arquitectura mientras estaba en la Akademiya y recibió un estipendio de la Akademiya.

A pesar de que el palacio era su obra maestra, Kaveh terminó endeudado después de su construcción debido a que Dori le prestó una gran cantidad de Mora, lo que lo obligó a establecer su residencia con Alhacén, aunque a menudo discute con su compañero de casa debido a su opiniones muy diferentes. También está familiarizado con Cyno y Tignari.

En algún momento antes del comienzo de las Misiones de Arconte de Sumeru, a Kaveh se le encomendó un proyecto en el desierto.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Kaveh%2FHistoria',
  biography_es_translated = false
where id = 'gi-kaveh';
update public.characters set
  biography_en = 'A wandering samurai from Inazuma with a modest and gentle personality. 
Beneath a youthful and carefree demeanor lies a heart that hides a great many burdens from the past. Seemingly easygoing, Kazuha has his own code of conduct.

Most people who meet Kaedehara Kazuha for the first time might be inclined to assume that he is just a trainee sailor with the Crux Fleet.

After all, he is a gentle soul who enjoys reciting poetry when idle, and who speaks to everyone in a leisurely manner. Who could tell that he is a wanted man throughout Inazuma?

Even Beidou, ever the good judge of character, could not tell that Kazuha could wield a sword with the skill of a seasoned warrior when she first decided to take him in.

Who knows if it was the storms of life that smoothed out his rough edges, or if his natural restraint has kept his edge sheathed.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Kazuha%2FProfile',
  biography_es = 'Un samurái errante de Inazuma que actualmente se hospeda en la Flota Crux Meridianam de Liyue. El corazón de este amable y libre joven encierra sus muchas cargas del pasado.

Un samurái errante de Inazuma que actualmente se hospeda en la Flota Crux Meridianam de Liyue. El corazón de este amable y libre joven encierra muchas cargas del pasado.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Kaedehara%20Kazuha%2FHistoria',
  biography_es_translated = false
where id = 'gi-kazuha';
update public.characters set
  biography_en = 'The Yuheng of the Liyue Qixing. Keqing has much to say about Rex Lapis'' unilateral approach to policymaking in Liyue ⁠— but in truth, gods admire skeptics such as her quite a lot. She firmly believes that humanity''s future should be determined by humans themselves, and that they can even do better than the archons and adepti have done for them. In order to prove this, she works harder than anyone else.

Rex Lapis has brought prosperity and plenty to Liyue Harbor, and his rule and majesty have long passed into show and song, much to the delight of the people. But for someone in such proximity to a god, Keqing seems to lack the requisite respect the most.

"Hmph.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Keqing%2FProfile',
  biography_es = 'El Equilibrio Terrenal de las Siete Estrellas de Liyue. Tiene su opinión sobre el gobierno de Rex Lapis en Liyue, pero, en verdad, a los dioses les gustan bastante los escépticos como ella.

El Equilibrio Terrenal de las Siete Estrellas de Liyue. Tiene su opinión sobre el gobierno de Rex Lapis en Liyue⁠, pero, en verdad, a los dioses les gustan bastante los escépticos como ella.

Keching cree firmemente que el futuro de la humanidad debería ser determinado por los propios humanos, y que incluso pueden hacerlo mejor de lo que los arcontes y los adeptus han hecho por ellos. Para demostrarlo, trabaja más duro que nadie.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Keching%2FHistoria',
  biography_es_translated = false
where id = 'gi-keqing';
update public.characters set
  biography_en = 'A saurian hunter who accompanies the one who calls himself "Dragonlord". He often accepts commissions that no one else wants, and is equally skilled at appraising the price.

Natlan is a nation where humans and Saurians live side-by-side, and this mutualism has lasted for many years.

Such relationships are for the most part friendly, with humans and Saurians as bosom companions.

But this does not mean that all Saurians approach humans with friendly intent.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Kinich%2FProfile',
  biography_es = '¿Este tipo? Es mi sirviente. Es listo y bastante ágil, pero tiene un enorme defecto: ¡es testarudo a más no poder! ¿Cómo es posible que cayera de cabeza desde un acantilado y no acabara muerto? ¡Me saca de mis casillas!
"No pasa nada por cobrar una comisión por entregar una carta, pero nunca había oído eso de cobrar una comisión por celebrar la Noche del Fuego Reminiscente. ¿Se puede seguir considerando héroe a alguien así?".

"Tampoco es que lo acabes de conocer. ¿Acaso no hace bien su trabajo? Pues eso es más que suficiente".

En Natlan, donde saurios y humanos conviven en armonía, no todo el mundo entiende por qué nació la profesión de cazasaurios. Y aún más críticas recibe el hecho de que en esta nación, en la que los héroes proliferan, se cobre un precio por completar una misión.

Asesino a sangre fría, cruel y despiadado; pragmático e interesado, sin apariencia heroica alguna...',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Kinich%2FHistoria',
  biography_es_translated = false
where id = 'gi-kinich';
update public.characters set
  biography_en = 'A courier who works for Komaniya Express, a delivery company in Inazuma. She has twin restless tails and is a nekomata who loves human society.

If you ask anyone in Inazuma which delivery company is the most reliable, the name "Komaniya Express" will surely be mentioned.

If you were to continue the line of inquiry and ask just what about their service left the deepest impression, you would see a smile creep onto their lips as they tell you of a certain special courier...

That adorable, vivacious young youkai with two twin twirling tails. After you thank her for delivering your package, she will bow deeply while wearing an expression of unadulterated bliss, as though she was the one receiving the gift.

If you''re willing to spend the time to leave a 5-star rating on the feedback board or give her a few snacks, you may even see stars of joy shoot from this youkai''s eyes as her tails swish back and forth.

Ah!',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Kirara%2FProfile',
  biography_es = 'Una repartidora de Komaniya Exprés, una empresa de envíos de Inazuma. Es una nekomata a la que le encanta su trabajo y la sociedad humana.

Es una mensajera que trabaja para Komaniya Express, una empresa de reparto en Inazuma. Tiene dos colas inquietas y es una nekomata que ama la sociedad humana.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Kirara%2FHistoria',
  biography_es_translated = false
where id = 'gi-kirara';
update public.characters set
  biography_en = 'Knights of Favonius Spark Knight! Forever with a bang and a flash! —And then disappearing from the stern gaze of Acting Grand Master Jean. Sure, time in solitary confinement gives lots of time to think about new gunpowder formulas... But it''d still be better to not be in solitary in the first place.

When the patrons of Mondstadt''s taverns are asked about the strongest knight of the Knights of Favonius, three names are likely to come up:

The highly reputable Acting Grand Master Jean, Cavalry Captain Kaeya, and the mysterious tycoon, Diluc.

However, some claim to have witnessed, albeit through bleary, drunken eyes, a knight in red, leveling the entire Stormbearer Mountains.

If one wants to find this mysterious knight, then they need look no further than the solitary confinement cell inside the Knights of Favonius Headquarters.

If the cell is found vacant... then something explosively unfortunate is likely about to take place...

Klee is well known for the danger she presents.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Klee%2FProfile',
  biography_es = 'Una visitante frecuente de los calabozos de los Caballeros de Favonius, la maestra de explosiones de Mondstadt. La llaman “el Sol Fugitivo”.

La presencia de la caballera chispeante de los Caballeros de Favonius siempre va acompañada de destellos y explosiones. Después de escuchar el estallido, siempre desaparece rápidamente de la mirada inquisitiva de Jean. Durante sus detenciones, investiga sobre nuevas fórmulas explosivas. Si no estuviera tanto tiempo en el calabozo, sus descubrimientos serían aún más aterradores.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Klee%2FHistoria',
  biography_es_translated = false
where id = 'gi-klee';
update public.characters set
  biography_en = 'Kokomi is the Divine Priestess of Watatsumi Island, and also serves as its supreme leader. She is well-versed in the art of war, is good at strategizing, and has keen insights into military affairs. She is also adept at handling domestic affairs, diplomacy, and other matters. 
Still, this unfathomable leader has a mysterious side to her...

The inhabitants of Watatsumi Island once lived in Enkanomiya, at the bottom of the sea.

It was only by the grace of the god Orobaxi bringing them up to the surface that the civilization of Watatsumi Island exists today.

When Orobaxi was slain by the Electro Archon, its body was left as a skeleton and its resentment permeated the land, giving rise to Tatarigami.

Yet its desire to protect Watatsumi Island never faded.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Kokomi%2FProfile',
  biography_es = 'La Sacerdotisa Divina y quien controla todos los asuntos de la Isla Watatsumi.

Sangonomiya Kokomi es una hermosa damisela. A pesar de su apariencia elegante, en realidad es la líder de la Tropas de Watatsumi. Ella es una asesora militar sabia e ingeniosa. Aunque siempre luce una sonrisa muy serena, en realidad lo tiene todo arreglado y a su alcance. Ella es el cerebro de la fuerza. Es la Sacerdotisa Divina de la Isla Watatsumi, la líder suprema de la Isla Watatsumi.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Sangonomiya%20Kokomi%2FHistoria',
  biography_es_translated = false
where id = 'gi-kokomi';
update public.characters set
  biography_en = 'Leader of the Tenryou Commission''s forces. A charismatic woman who acts as swiftly as a storm wind and always honors her word. She bears the title of "Devotee of the Divine" and has sworn her allegiance to the Raiden Shogun. The eternity that the Shogun pursues is the cause that she is willing to fight for.

The blood of the tengu runs through Kujou Sara''s veins, but she does not dwell in the forests and mountains as they do. She was fostered from a young age by the Kujou Clan and has served since then as part of the Tenryou Commission.

The Tenryou Commission is one arm of the Tri-Commission, and is in charge of the security of Inazuma. Today, Sara is a general of the Tenryou Commission, and hers is the vital task of maintaining order within Inazuma City itself.

She governs well and is ever determined to set a good example for her subordinates.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Kujou%20Sara%2FProfile',
  biography_es = 'La general de la Comisión Tenryou. Es una persona audaz, firme y muy buena en combate.
Kujou Sara es miembro e hija adoptiva del Clan Kujou, que sirve a la Shogun Raiden. Ella apoya su Decreto de captura de Visiones y lidera tropas para apoderarse de las Visiones. Kujou Sara también se describe como una "Guerrera Tengu" con "alas tan oscuras como un cuervo".

Antes de los eventos del juego, el amigo de Kaedehara Kazuha desafió a la Shogun por su Decreto. Kujou Sara aceptó el desafío en nombre de la Shogun y prevaleció contra su amigo en el duelo que siguió, matándolo. Antes de que pudiera reclamar su Visión Electro, Kaedehara Kazuha, que acababa de entrar para presenciar la muerte de su amigo, inexplicablemente lo arrebató y huyó de Inazuma.

General actual de la Comisión Tenryou. Es una guerrera firme, valiente y ágil en combate. Si la Shogun es el trueno sobre el cielo, Kujou Sara es el rayo del que es difícil protegerse.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Kujou%20Sara%2FHistoria',
  biography_es_translated = false
where id = 'gi-kujou-sara';
update public.characters set
  biography_en = 'The deputy leader of the Arataki Gang. She wears a unique mask and is rather stoic. Few people know why a talent of this caliber would run away to join a street gang. Even fewer people know what she hides under her mask.

In the Arataki Gang, where swaggering commotion is something of an aesthetic, the ever-masked and low-key Kuki Shinobu, the gang''s second-in-command, stands out all the more against the backdrop of the other, more clamorous members.

No matter what sort of mess the others have gotten themselves into, this deputy is often able to solve their problems in a manner that is both professional and highly efficient.

Making some snacks for children who had theirs snatched away, giving scratched lacquerware a new coat of paint, and serving as an advocate for detained comrades...

Such are her skills that onlookers often wonder if there is anything that she cannot do.

"I wouldn''t say that I''m certified for everything.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Kuki%20Shinobu%2FProfile',
  biography_es = 'La hábil y confiable subjefa de la Banda de Arataki. Menos mal que está ella, si no, la Banda de Arataki no tendría nada de “hábil” ni “confiable”.

Aunque Kuki Shinobu se unió a la Banda de Arataki en una etapa posterior, es una figura poderosa que transformó a toda la banda. Después de su llegada, el alcance comercial de la banda se expandió a todos los ámbitos de la vida, incluidos, consultas legales, negociaciones comerciales, servicio para banquetes, personalización de ropa, entre otros...

Lo que es aún más sorprendente es que la displicente Banda de Arataki pudo producir todos los certificados de práctica relevantes, todos firmados con el mismo nombre: Kuki Shinobu.

Se dice que esta segunda al mando había estudiado en el extranjero, y también se dice que tiene afiliaciones cercanas con la Comisión Tenryou.

Cuando los extraños escuchan esto, inevitablemente tienen muchas sospechas.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Kuki%20Shinobu%2FHistoria',
  biography_es_translated = false
where id = 'gi-kuki-shinobu';
update public.characters set
  biography_en = 'A key member of the Chenyu Vale Artisans Association, she is adept at weaving a dazzling array of rattan handicrafts, and her joyful, quick-witted nature is positively infectious.

When it comes time for the residents of Chenyu Vale to spruce up their homes, there is more than just the usual panoply of intricately carved wooden beds and tables on offer.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Lan%20Yan%2FProfile',
  biography_es = 'Una tejedora de mimbre procedente del Valle Chenyu. Tiene una mente clara, templada, y es ágil como el manantial de una montaña.

(Por añadir...)',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Lan%20Yan%2FHistoria',
  biography_es_translated = false
where id = 'gi-lan-yan';
update public.characters set
  biography_en = 'The Moonchanter of the Frostmoon Scions, also known as the Maiden of the Grove. She has a peculiar affinity for both animals and the moonlight.

When night falls, the Frostmoon Scions dwell within a "tower."

At the top of this tower is a seemingly unchanging full moon, and at its base is the soil of Hiisi Island. Its walls are made of white moonlight, allowing any to pass through.

Oh, how gentle the Moon Goddess is. Even if not all should believe in her, even if not all should know of her, she spreads her grace without reserve.

Thus spoke the old priestess of the Frostmoon Scions.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Lauma%2FProfile',
  biography_es = '"Bajo la atenta protección de nuestra bondadosa Cantalunas, ningún humano o bestia inocente resultará herido... *Suspira*, pero cuando la ley del más fuerte ya no está en pie, algunas bestias carnívoras lo pasarán mal y querrán probar bocado".

A pesar de ser los habitantes originales de la tierra en la que viven, los Descendientes Lunaescarcha parecen no encajar con la Nod Krai de hoy en día. 
Son una comunidad muy antigua, de ideas muy rígidas y con una fe demasiado arraigada en la adoración a una deidad que nunca han visto. 
Creen que las sombras de las arboledas son su refugio, y que la esplendorosa luz lunar hará desaparecer todas sus dolencias y aflicciones. 
Rezan a la luna, siempre con una pregunta: "Oh, gran Diosa de la Luna Escarchada, ¿cuándo responderá a nuestras plegarias?". 
Al no obtener respuesta, vuelven a preguntar: "Oh, venerable Cantalunas, ¿cuándo responderá la Diosa Lunar a nuestras plegarias?".',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Lauma%2FHistoria',
  biography_es_translated = false
where id = 'gi-lauma';
update public.characters set
  biography_en = 'A Rtawahist student who always looks sleep-deprived. Her dark eye circles have been worsening due to academic stress. Yet no matter how difficult the work at hand, she always manages to make the most brilliant deductions. Could she be writing her thesis in her dreams?

The Rtawahist Darshan of the six Darshans under the Sumeru Akademiya is dedicated to the study of Illuminationism.

Each of the Six Darshans focuses on a different field of study. Illuminationism, then, is centered around astrology and astronomy, learning of the cosmos that has clutched the world in its embrace since time immemorial.

It is among the researchers of Illuminationism that we find Layla.

Though she has only recently enrolled, she has already earned a great many nicknames for herself.

She has been called the Sleepwalking Eccentric, the Human Calculator, and even the Heaven-Sent Thesis by those who know her.

As the days go by, her titles only seem to grow in number.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Layla%2FProfile',
  biography_es = '"Siempre dice que está abrumada escribiendo su tesis y que dibujar mapas astrales la estresa, pero es más resistente que nadie, y se niega a quedarse atrás... ¿Por qué la conozco tan bien? Jeje..."
Estudiante de la Facultad Rtawahist, Laila se está especializando en astrología teórica y dibuja incansablemente mapas astrales que incluir en su tesis.

Debido a las altas expectativas de sus profesores, su escritorio siempre está cubierto de montones de papeles que no dejan de crecer por más que se esfuerce.

Al sufrir de una severa falta de sueño, si detiene la mirada fijamente sobre un papel en blanco, montones de estrellas comenzarán a titilar frente a sus ojos.

Es por eso que decidió tomarse un pequeño descanso, para ser capaz de afrontar la realidad con una mente lúcida y despejada.

Cuando abrió los ojos de nuevo, descubrió que una miríada de estrellas habían adornado el manuscrito que previamente dejó en blanco.

Laila se frotó los ojos para asegurarse de que no estaba soñando.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Laila%2FHistoria',
  biography_es_translated = false
where id = 'gi-layla';
update public.characters set
  biography_en = 'Advisor for the Adventurers'' Guild, a changeling, born of the fae but raised among humans.

Of the Adventurers'' Guild''s many advisors, Linnea is, without a doubt, the most special one of them all. Though she bears the title of "advisor," she is less a scholar before a desk and more a perpetual wanderer on the road. This is because for her, the world''s heartbeat can only be felt out in the wild, by walking untamed lands and measuring the earth with her own two feet, and by beholding its wonders with her very own eyes.

This unwavering devotion to fieldwork has made her a master of survival. Out in the wild, she is able to identify hundreds of plants through the seasons, as well as track many a rare beast using nothing but tracks in the earth and scents in the wind.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Linnea%2FProfile',
  biography_es = 'Creía que los trucos de los niños cambiados se habían convertido en leyenda tras el fin del gobierno de las hadas, hasta que un día, después de una función, conocí a esa vivaz aventurera... la cual me trajo maravillosos sonidos de distintas criaturas de todos los rincones del mundo. ¡Ella sí que es interesante, no como esos viejos cascarrabias de la tundra!Al principio, los niños que nacen en este mundo siempre se consideran a sí mismos el centro del universo. Darse cuenta de la brecha que existe entre uno mismo y el mundo suele marcar el fin de la infancia. Pero ¿qué ocurre cuando dicho niño es una criatura no humana que vive en la sociedad humana? Para ese niño, el camino hacia la madurez probablemente sea mucho más amargo. Aunque esta sea Nod Krai, el paraíso de los monstruos y los excéntricos...',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Linn%C3%A9a%2FHistoria',
  biography_es_translated = false
where id = 'gi-linnea';
update public.characters set
  biography_en = 'She is an intellectual witch who can never get enough naps. As the Librarian of the Knights of Favonius, Lisa is smart in that she always knows exactly what to do with whatever troubles her. As much as she loves her sleep, she still manages to keep everything under control in a calm, composed manner.

The librarian of the Knights of Favonius. In addition to her elegance and charm, Lisa is also highly educated.

She is said to have been the most talented sorceress to study at the Sumeru Akademiya in the last two centuries.

It is known that Lisa chose to return to Mondstadt after two years of advanced study in Sumeru, but the reason for her decision is not. At present, Lisa''s job is to oversee the book collection in the library owned by the Knights.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Lisa%2FProfile',
  biography_es = 'Lisa es una bruja muy inteligente con una gran afición por la siesta. Ella es la bibliotecaria de la Orden, siempre encuentra en los libros la mejor solución a los problemas. Aunque parezca perezosa, no teme a nada y mantiene todo bajo control
La perezosa pero sabia bibliotecaria de los Caballeros de Favonius. En realidad, fue considerada por la Academia de Sumeru como su graduada más sobresaliente en los últimos dos siglos.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Lisa%2FHistoria',
  biography_es_translated = false
where id = 'gi-lisa';
update public.characters set
  biography_en = 'Vice Captain of the Knights of Favonius 5th Company. A young knight who fights on the front lines, using himself as the arrow and his spear as its tip.

Barely had the expeditionary force begun its journey home when the bards were already on their way, carrying the heroes'' stories back to the taverns.

Even amid familiar names like Varka, the title "Frontline Suppression Officer" had started to command attention, recognized for both remarkable accomplishments and constant engagement in battle.

How could a long-range troop — meant to strike from afar — always find itself at the very front, charging straight into hand-to-hand combat with blades ready?

Why would a squad armed with crossbows and muskets follow a young knight wielding only a spear?

Such contradictions naturally drew questions, and where questions lingered, debate quickly followed.

Some could not hide their irritation: "So because they close in, their ranged attacks suddenly fail?',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Lohen%2FProfile',
  biography_es = '"Soy muy consciente de su decisión y sus preocupaciones sobre muchos de nuestros compañeros. Contar con un caballero así en la expedición cubriría ciertas de las limitaciones de nuestras fuerzas. La única pregunta es: ¿cómo voy a poder mantenerlos vigilados a ambos a la vez?".
Aunque Lohen es el Subcapitán de la Compañía de Ofensiva a Distancia, rara vez usa el arco.

Quienes viajan con él por primera vez siempre se quedan anonadados de que, cuando los demás miembros del escuadrón aún están en formación en la retaguardia con sus ballestas y mosquetes, el joven caballero, que debería estar buscando refugio, ya ha atravesado la línea de defensa, lanza en mano, para enfrentarse a los enemigos más peligrosos.

Los caballeros que alguna vez han preguntado el porqué a los miembros de la Compañía de Ofensiva a Distancia suelen recibir dos respuestas:

"Mientras Lohen esté en el frente, ningún enemigo será capaz de acercarse y todos podremos proporcionarle apoyo de fuego sin preocuparnos de na',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Lohen%2FHistoria',
  biography_es_translated = false
where id = 'gi-lohen';
update public.characters set
  biography_en = 'A magician''s assistant hidden in the shadows who refers to herself as a "Multi-Function Magic Assistant." Poker-faced, reticent to speak, and as unpredictable in her movements as a cat.

When asked who the most famous magician in the Court of Fontaine is, audiences will almost certainly think of the stylish, vibrant Lyney and his stage presence.

But if you were to ask after its most renowned magic assistant, people would scratch their hands and be at quite a loss to answer.

The adulation is not for her, after all, nor is the resounding applause directed at her skill and presence. As an assistant, she needs only misdirect the audience at opportune moments, ensuring the spotlight stays on the protagonist.

Whether on or offstage, Lynette habitually hides behind Lyney, in shadows that neither lights nor compliments can penetrate.

For an assistant, keeping a low profile is a professional matter.

And as for a child of the "House"... being cloaked in shadow is how one survives.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Lynette%2FProfile',
  biography_es = 'Una ayudante de magia poco habladora y expresiva. Es tan impredecible como un felino.

En comparación con sus hermanos Lyney y Fréminet, Lynette es la más reservada de los tres. Rara vez habla con los demás por su propia voluntad, dejando que Lyney hable por ella, y disuade esencialmente cualquier intento de hablar con ella diciendo respuestas extrañas. Cuando necesita hablar, lo hace de forma breve y franca.

Debido a tener sangre felina, Lynette tiene muchos rasgos similares a los de un gato, como disfrutar del pescado. También tiene la costumbre de romper o estropear las máquinas, por lo que no las utiliza con frecuencia. A Lynette le gusta preparar y beber té.

Como resultado de su traumático pasado con Lyney, Lynette no confía en la mayoría de la gente para que no se aprovechen de ella, viendo a su hermano como una verdad en un mundo lleno de mentiras y falsedades.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Lynette%2FHistoria',
  biography_es_translated = false
where id = 'gi-lynette';
update public.characters set
  biography_en = 'A genius of a magician famed throughout Fontaine. He moves his audience with a combination of sleight of hand and the gift of the gab. Eloquent, ingenious, and with a mind as hard to fathom as a cat.

The people of Fontaine love their tales of mystery. The intricate case setups and unexpected twists and turns are captivating for all.

Magic recreates this experience under the converging spotlights. For the price of a ticket and some of your free time, you can embark on a wondrous journey amidst thunderous applause and astounded cries.

If you were to ask around as to which of Fontaine''s "guides" is best at setting up such fantastical tours, most fans will tell you that it is Lyney.

Suave, romantic, and talented, he performs miracle after miracle with a casual air.

In this industry, one needs only a stable of staple tricks to ensure a renowned reputation and comfortable life.

However, Lyney''s shows always feature some new trick.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Lyney%2FProfile',
  biography_es = 'Un astuto y hábil mago de Fontaine que siempre se gana al público con sus ingeniosos trucos y su elocuencia.

"A veces desvía la atención con pequeños gestos, otras finge equivocarse y te muestra un error... Cuando la cosa se pone seria, los juegos de manos son más deslumbrantes que la propia magia. ¿Adivinas de qué estoy hablando?".

A excepción de los juicios que se celebran en la Ópera de la Epíclesis, los espectáculos de magia de Lyney y Lynette son sin duda lo mejor de la Corte de Fontaine. Un juicio utiliza la verdad para impartir justicia. La magia utiliza las apariencias para conmover al público. Aunque el público sabía perfectamente que todo lo que había en el escenario no era más que trucos e ilusiones, se siguen sorprendiendo cuando presencian un "milagro". La atronadora ovación del público llegaba incluso antes de que el telón se bajara elegantemente ante el mago. En el escenario, Lyney es el gran mago esperado por todos.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Lyney%2FHistoria',
  biography_es_translated = false
where id = 'gi-lyney';
update public.characters set
  biography_en = 'Natlan''s Archon and leader, the everlasting flame of hope for all living beings, and the cleansing flame that incinerates all evil.

When the name "Mavuika" is mentioned, the citizens of Natlan will not be stingy with their praise, for she has proven herself well-qualified and worthy of respect, be it as a leader or Archon.

She is the pinnacle of strength in Natlan, and she has the bearing to match. Even newly-arrived travelers need only hear her speak at the Stadium of the Sacred Flame to know that she merits being known as the sun.

She is exceedingly awe-inspiring, but is no unsmiling ruler whose ways may as well be set in stone.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Mavuika%2FProfile',
  biography_es = 'La líder de Natlan que heredó el nombre antiguo de “Kiongozi”. Ella se comprometió a iluminar el futuro de la Nación de la Guerra con el Fuego Sagrado.

Mavuika es la figura más venerada en todo Natlan, y se ha convertido en la ídolo de todos los guerreros de la nación. Fue elegida Arconte en el Peregrinaje del Retorno del Fuego Sagrado hace cientos de años, y, como tal, ahora porta la Gnosis, que es la fuente de su poder como Arconte y de su inmortalidad. Antes de convertirse en Arconte era parte de la tribu de los Retoños arbóreos, donde pasó su infancia y juventud junto a sus padres, su hermana Hine y su amigo Burkina, quien más tarde sería un gran guerrero de la tribu . Después de eso, perdió el contacto con sus seres queridos para dedicarse a su nación.

Su grandeza emocionó a Kachina cuando la diosa la llamó "heroína de Natlan", expresando que jamás habría soñado con tal honor.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Mavuika%2FHistoria',
  biography_es_translated = false
where id = 'gi-mavuika';
update public.characters set
  biography_en = 'A young knight who is a key member of the front-line scouting team. Quiet and unassuming, Mika treats every task seriously, and can cook up a mean serving of field rations. However, he can''t seem to hide his bashful and shy personality when meeting strangers.

Whenever he shows up at the Knights of Favonius headquarters, Mika always swiftly finishes any discussions to be had with his fellow knights, then quietly slips away to avoid becoming a hindrance to others'' work.

Mika always gets nervous when someone strikes up a conversation with him, frantically scampering away right after politely putting an end to the idle chatter.

The knights know that the young man''s name is Mika, and that he is Huffman''s younger brother and the second son of the Schmidt family.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Mika%2FProfile',
  biography_es = 'Un joven caballero procedente de una familia normal. Es el tímido y precavido topógrafo de avanzada de la Compañía de Reconocimiento.

Mika es el hermano menor de Huffman. También es miembro de la Compañía de Reconocimiento de Eula. Medio año antes de la llegada del Viajero a Mondstadt, Mika fue con el grupo de expedición de Varka para ayudar a explorarlos. Antes del comienzo del Festival de la Vendimia, Varka envió a Mika de vuelta a Mondstadt con una carta para que la dirigiera a los Caballeros que quedaban en la nación y los pusiera al corriente de los progresos del grupo. Mika se dirigió al grupo y leyó el contenido de la carta antes de volver a ponerse al día con sus viejos amigos de la Compañía de Reconocimiento.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Mika%2FHistoria',
  biography_es_translated = false
where id = 'gi-mika';
update public.characters set
  biography_en = 'A yumekui-baku, who also happens to be a clinical psychologist and a major shareholder of Aisa Bathhouse. If you ever find yourself gripped by seemingly insurmountable anxiety, she will surely be able to offer you the help you so need.

Mention the Aisa Bathhouse, and for most Inazumans, the first thing that springs to mind are its artificial hot springs — inspired by those present in Natlan, kitted out with imported facilities, and hailed as a "go-to destination for relaxation."

The bathhouse has recently undergone a major renovation, now offering "psychotherapy" services that have quickly won it widespread acclaim.

Enter Yumemizuki Mizuki, a clinical psychologist who, after having only recently returned to Inazuma, has quickly taken center stage.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Mizuki%2FProfile',
  biography_es = 'Una yumekui-baku que además es psicóloga clínica y accionista mayoritaria de los Baños Aisa. Si alguna vez te ves atrapado por una angustia que parece insuperable, seguro que ella sabrá darte la ayuda que necesitas.

Si mencionas los Baños Aisa, lo primero que le viene a la cabeza a la mayoría de los habitantes de Inazuma son sus aguas termales artificiales, inspiradas en las de Natlan, equipadas con instalaciones importadas y consideradas un "destino de referencia para relajarse".

El establecimiento ha pasado hace poco por una gran reforma y ahora ofrece servicios de "psicoterapia" que han cosechado enseguida un aplauso generalizado.

Y ahí entra Yumemizuki Mizuki, una psicóloga clínica que, pese a haber regresado a Inazuma hace muy poco, ha pasado rápidamente a ocupar el centro del escenario.',
  biography_source_es = 'https://genshin-impact.fandom.com/wiki/Mizuki%2FProfile',
  biography_es_translated = true
where id = 'gi-mizuki';
update public.characters set
  biography_en = 'A mysterious young astrologer who proclaims herself to be "Astrologist Mona Megistus," and who possesses abilities to match the title. Erudite, but prideful. Though she is often strapped for cash and lives a life of thrift, she is resolved to never use astrology for profit... It is this very resolution that has caused her to constantly fret about money.

Teyvat is a place where people of all sorts go about their business. Merchants move products, knights patrol, and farmers till the land.

But if one were to ask Mona — the enigmatic and prideful astrologist — what she busies herself with, she will reply by saying that she is servicing a debt known as "life."

She will, however, vigorously deny being "poor," giving the following explanation:

"Beautiful veneers may obscure simple truths.

Exquisite food may mask its nutritional value.

One lives simply, all the better to expose this world''s truths."

A frugal lifestyle, therefore, is a form of training to access the truth...',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Mona%2FProfile',
  biography_es = 'Una misteriosa y joven astróloga que se hace llamar “Astróloga Mona Megistus”. Está convencida de que posee las habilidades para estar a la altura del título. Erudita y orgullosa.

Una misteriosa joven astróloga que se auto proclama "Astróloga Mona Megistus". Erudita y orgullosa, está convencida de que posee las habilidades necesarias para estar a la altura de su propio título. Aunque siempre tiene dificultades financieras y vive una vida frugal, Mona se niega a lucrarse con la astrología. Sin embargo, es esta misma determinación la que le ha traído problemas financieros...',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Mona%2FHistoria',
  biography_es_translated = false
where id = 'gi-mona';
update public.characters set
  biography_en = 'One of the shining stars of the People of the Springs'' new generation of young guides. If you''ve come to Natlan for sightseeing, there''s no better companion you could choose.

If any traveler visiting the People of the Springs for the first time wants to try out the popular watersports here, like swimming, surfing, diving, or water polo... Everyone will recommend they go speak with Mualani, without exception.

Mualani operates the Leisurely Puffer, a store that specializes in products related to watersports. Her goods are expertly designed and of superb quality, while she herself has a vast wealth of knowledge in her capacity as a guide.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Mualani%2FProfile',
  biography_es = 'Si se lo propone a sí misma, para esa muchacha no existe ni un solo rincón de Natlan al que no pueda llegar. Entonces, ¿para qué viene a verme antes de partir queriendo saber si los augurios son buenos o malos? Bueno, le he vaticinado todos los días auspiciosos de la próxima década y parece que se ha quedado más tranquila.
Puede que ni las aves que sobrevuelan estas tierras conozcan Natlan mejor que los guías del Pueblo de los Manantiales. Hace mucho, mucho tiempo, sus ancestros midieron el mundo con sus propios pies y manos, convirtiendo cada una de las sendas retorcidas e intransitables de la región en sencillos trazos de un mapa.

Como miembro de la nueva generación del Pueblo de los Manantiales, la reputación de Mualani como guía se extendió pronto por toda Natlan.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Mualani%2FHistoria',
  biography_es_translated = false
where id = 'gi-mualani';
update public.characters set
  biography_en = 'Lesser Lord Kusanali dwells deep in the Sanctuary of Surasthana, and has never really been in the limelight, nor has she even been mentioned much. Her burden is heavy, but though she may experience loneliness, and though darkness is all she sees before her, she will not stop moving forward.

Greater Lord Rukkhadevata created Sumeru''s rainforest and bestowed wisdom upon the people of Sumeru through the Akademiya.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Nahida%2FProfile',
  biography_es = '"Yo diría que o presta mucha atención o es demasiado cariñosa con la gente... Aunque sus acciones puedan ser algo defectuosas, creo que su sentido de la responsabilidad como deidad de Sumeru es algo encomiable. Después de todo, ella es la deidad más joven, no como cierta otra persona que es propensa a la histeria...".

La Reina Menor Kusanali reside en las profundidades del Santuario de Surasthana.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Nahida%2FHistoria',
  biography_es_translated = false
where id = 'gi-nahida';
update public.characters set
  biography_en = 'The ever-beaming President of the Spina di Rosula, devoted to helping the people of Fontaine solve all kinds of thorny issues.

Fontaine''s laws are very strict, but its people are quite free-spirited. Fontainian society contains all manner of social organizations, clubs, or factions, all of which have their own origins, development, goals, and style.

For example, the short-lived Hat Jellyfish Association ostensibly promoted the protection of the waters and those living within, but was in truth founded by a band of explosives enthusiasts.

By comparison, the Spina di Rosula are a law-abiding, reliable lot, their overly rambunctious young President notwithstanding.

In official statements, the Spina proclaims itself to be a citizen-oriented society that involves many walks of life and focuses its efforts on solving difficult issues amongst the common folk, and that it will cooperate with the Fontainian authorities where needed.

If you ask Navia, she''d tell you that the Spina serves as',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Navia%2FProfile',
  biography_es = '"Cuando éramos pequeñas, jugábamos a una especie de juego de mesa en el que ella era la aventurera y yo la que dirigía el juego. Improvisar siempre ha sido mi fuerte, pero aun así, a menudo me quedaba perpleja ante sus decisiones y las respuestas que soltaba. No obstante, eso era lo que lo hacía tan interesante".
A juzgar por su aspecto, no cabe duda de que Navia es la viva imagen de una dama de Fontaine.

Le gusta engalanarse con vestidos ornamentados y sombreros elegantes, y lleva consigo un paraguas de lazos y joyas incrustadas.

Vestida de esta forma, recorre las calles de la Corte de Fontaine, los campos de la Montaña Equinoccio y los rincones menos conocidos del Río Ceniciento.

Aunque la parte trasera de su falda se arrastre tras ella y su paraguas sea mucho más pesado de lo que parece, ninguno entorpece lo más mínimo sus movimientos.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Navia%2FHistoria',
  biography_es_translated = false
where id = 'gi-navia';
update public.characters set
  biography_en = 'The incredibly resourceful owner of the Curatorium of Secrets.

Nasha Town is a "bustling" town.

During the day, mercantile debate and reckless arguments can be heard everywhere on the streets.

And at night, whispered schemes and the secret plots of thieves abound in the town''s more dimly lit rooms.

Like a butterfly languidly flitting in the summer, these wild ambitions and intrigues linger soundlessly around every corner.

Countless are those who have chased said butterfly, hoping to one day find a land of plenty and safety.

Meanwhile, the one true feline, the one capable of felling butterflies with a single pounce, crouches high above, gazing down upon those who chase illusions as they furiously clash and clamor, only to fall once more.

"Ashru."

At the sound of his owner''s call, the feline turned his gaze away from those with whom he was not at all concerned.

For no matter how the world changed, his owner would always have tasty dried fish in hand.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Nefer%2FProfile',
  biography_es = '"A veces hablo con las serpientes y me cuentan que incluso aquellas con la sangre más fría desean encontrar la rama perfecta en la que enroscarse... Menos mal que en Nod Krai hay árboles de sobra para que todas las serpientes puedan encontrar su propio lugar".

Gracias a su excepcional eficiencia para completar encargos y su precio relativamente bajo (el cual puede regatearse aún más si Jahoda está de servicio), la Cámara de Secretos posee una gran reputación entre los residentes de la Villa Nasha. 
Sea cual sea el encargo, la Cámara de Secretos garantiza poder realizarlo y dejar a sus clientes satisfechos, ya se trate de la búsqueda de un gato, una persona, un objeto, un rastro, un criminal o un amante infiel. 
Uno podría pensar que la Cámara de Secretos y el Gremio de Aventureros, que se encuentran a unas pocas puertas de distancia, son muy similares.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/N%C3%A9fer%2FHistoria',
  biography_es_translated = false
where id = 'gi-nefer';
update public.characters set
  biography_en = 'You wouldn''t exactly describe the Iudex of Fontaine as "approachable." It''s hard to say whether it''s just in his nature, or because he has secrets to hide.

Neuvillette is a solitary person.

Fontainians who have tried to get close to him have, without exception, been politely rejected. To this day, no one even knows his first name, since he has always asked that he be referred to by his last name.

He believes that close personal ties will lead to suspicions about the justness of one''s judgments, while he must remain a symbol of absolute justice.

Of course, there will always be people who just won''t give up. They will say, "Come now, Monsieur Neuvillette. Not everyone will stand trial, nor will you always have to remain in the judge''s seat."

But is that really the case? If there is an answer in his heart, Neuvillette will not reveal it.

Given enough time, every river will overflow and flood.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Neuvillette%2FProfile',
  biography_es = 'La verdadera prueba comenzará el día en que ellos regresen.

"En la anterior edición, su señoría Neuvillette calificó de ''amarillista'' la columna de secretos de la Arconte Hydro, así que esta vez nos centraremos en el enigmático juez supremo. Como sabemos muy poco sobre su auténtica forma de ser y ha rechazado nuestras entrevistas en múltiples ocasiones, decidimos recurrir a la opinión pública para hacernos con el material más verídico posible. En ese sentido, hemos descartado toda carta anónima o cuya veracidad fuera altamente dudosa. A continuación les mostramos una de las cartas más adorables que nos han llegado:

...

''Si de verdad existiera el Héroe Oscuro, ese solo sería un disfraz. Cuando el Héroe Oscuro se levanta por la mañana y se lava los dientes, sigue siendo el mismo, ya que solo adopta esa identidad a medianoche. Sin embargo, Neuvillette (Su Señoría) no es así.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Neuvillette%2FHistoria',
  biography_es_translated = false
where id = 'gi-neuvillette';
update public.characters set
  biography_en = 'Mage N, Nicole Reeyn. In summary: "The observer of the World."

Many of the stories Nicole envisions begin with a phrase as old as the stories themselves: "A long, long time ago..."

It was a time, a long, long, time ago, when the lights of myriad nations filigreed the earth in gleaming gold, when the daughters of heaven wandered in carefree grace betwixt divine courts and mortal cities... It was a time, a long, long, time ago, when the sovereign of ages past, who had descended into deepest darkness, had not yet brought disaster back to his homeland, when the radiant moons that hung aloft in the night heavens were still three...

The years brook no pause, the wheel spinning onward all the same. In a cycle emptied of hope, the spark of paradise perished alongside lives extinguished.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Nicole%2FProfile',
  biography_es = '"Editora de burbujas de recuerdos mágicas", "Defensora acérrima de las ardillas", "Persona supercreativa que siempre encuentra una solución"... "¿Alice? ¿Por qué son cada vez más largos los títulos de la fórmula mágica?".
Muchas de las historias visualizadas por Nicole comienzan con la frase "Hace mucho, mucho tiempo...".

Quizás, para algunos escritores, "mucho tiempo" no sea más que una excusa para evitar posibles preguntas.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Nicole%2FHistoria',
  biography_es_translated = false
where id = 'gi-nicole';
update public.characters set
  biography_en = 'Star of the Zubayr Theater. Her dance is as graceful as a water lily in first bloom, pure and pristine. But she is by no means a haughty and cold person. Even the most hurried traveler will not forget her innocent and radiant smile.

"Since you''re in Sumeru, you must not miss Nilou''s performances."

This is a fact that most people in Sumeru agree on.

There is no threshold for Nilou''s dances, so everyone can come and enjoy a most fascinating and engrossing time there.

Nilou''s audience comes from all walks of life.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Nilou%2FProfile',
  biography_es = '"No entiendo qué tiene de maravilloso ese teatrucho de tres al cuarto. Si aceptara venir de gira por Teyvat conmigo, podría ganar todos los Moras que quisiera y más... *Suspira*, esa chica es demasiado ingenua, no es capaz de comprender su propio valor". 

Si tienes tiempo, no te pierdas la actuación del Teatro Zubayr.

Bajo el tenue resplandor de los focos, Nilou se mueve al son de la música como si de una flor de loto inmaculada al viento se tratara.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Nilou%2FHistoria',
  biography_es_translated = false
where id = 'gi-nilou';
update public.characters set
  biography_en = 'Owner of the Jade Chamber in the skies above Liyue, there are stories abound about Ningguang, with her elegance and mysterious smile. As a Tianquan of the Liyue Qixing, not only does she embody law and order, she also represents fortune and wit.

The "Liyue Qixing" controls all of the commerce that takes place in Liyue Harbor. Its highly-revered position is also coveted by many. Their primary ruling is to play things safe and keep a low profile.

The "Tianquan" of the Qixing, Ningguang, is the only exception. 

She is seen as an excellent merchant in the eyes of her rivals, a friendly elder sister to kids, a socialite at the banquets of Yujing Terrace, and a connoisseur of desserts... Ningguang is the talk of the town, and everyone seems to know everything about her.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Ningguang%2FProfile',
  biography_es = 'Dueña de la Cámara de Jade que flota sobre los cielos de Liyue, sobre Ningguang corren mil historias, siempre acompañadas de su elegancia y su sonrisa enigmática. Como Tianquan de los Qixing de Liyue, no solo encarna la ley y el orden: también representa la fortuna y el ingenio.

Los "Qixing de Liyue" controlan todo el comercio del Puerto de Liyue. Su posición, muy respetada, es codiciada por muchos, y su norma principal es actuar sobre seguro y mantener un perfil bajo.

La "Tianquan" de los Qixing, Ningguang, es la única excepción.

Sus rivales la ven como una comerciante excelente; los niños, como una hermana mayor cariñosa; en los banquetes de la Terraza Yujing es el alma de la fiesta, y además es una entendida en postres... Ningguang está en boca de todos, y todo el mundo parece saberlo todo sobre ella.',
  biography_source_es = 'https://genshin-impact.fandom.com/wiki/Ningguang%2FProfile',
  biography_es_translated = true
where id = 'gi-ningguang';
update public.characters set
  biography_en = 'Like most of Mondstadt''s young people, Noelle always dreamed of being a knight of Favonius when she grew up. She may not have what it takes to be a knight just yet, but she is learning. Working as a maid at the Knights'' headquarters, she is constantly taking notes on what constitutes knightly speech, knightly conduct, and knightly customs. She holds firm to her belief that one day she will join their ranks — she just needs to keep trying her hardest at everything she does.

Noelle has much greater dreams and ambitions than other maids in the Knights of Favonius.

Like anyone else in this city protected by the Knights of Favonius, she too dreams of donning the honored armor.

Even if her skills are not enough to pass the rigorous selection trials, she still wishes to observe and learn from them every chance she gets.

Aside from her training, she enjoys her current life, helping everyone in need.

"You can leave absolutely anything to me!"

That''s her signature line.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Noelle%2FProfile',
  biography_es = 'Una sirvienta al servicio de los Caballeros de Favonius que sueña con unirse algún día a sus filas.
Al igual que otros jóvenes de Mondstadt, Noelle sueña en convertirse en una Caballera Honorable de Favonius. Aunque todavía no tiene las cualidades de un caballero, Noelle trabaja dentro del Ordo de Favonius como criada, a la vez que estudia con detenimiento cada palabra y cada movimiento de los caballeros. Tiene la firme convicción de que, siempre y cuando trabaje duro, llegará el día en el que portará la armadura de los caballeros con orgullo.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Noelle%2FHistoria',
  biography_es_translated = false
where id = 'gi-noelle';
update public.characters set
  biography_en = 'The prima ballerina of the Korolevskiy Troupe, clear and unyielding as the ice.

In other lands, the word "dancer" often brings to mind someone warm and familiar, a gentle presence that offers comfort along life''s long road.

When one mentions the same in Snezhnaya, however, the image conjured is a touch frostier.

Odette Spessiva, prima ballerina of the Korolevskiy Troupe, appears on promotional posters wearing the same composed expression. Her gaze is calm and distant, her lips lightly pressed together, her face as still as a statue touched by frost.

That cold reserve only makes the fervor of her admirers more striking. Their devotion is not difficult to understand. Odette possesses an impeccable physique, and her performances combine a cutting austerity with tremendous dramatic tension.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Odette%2FProfile',
  biography_es = '"Ella baila y baila... Las miradas y los corazones de todos siguen cada uno de sus gráciles movimientos, para luego caer cuando baja el telón ♪... Pero Odette, oh, Odette, Odette de Snezhnogrado, Odette de la Compañía Korolevski, Odette, la que no pertenece a sí misma ♪... ¿Anhela tu corazón ser el centro de atención en el escenario o poder bailar en solitario sobre las llanuras nevadas? ♪...".
En Snezhnaya, lograr que la gente de las tierras heladas acuda por voluntad propia a un teatro no es tarea fácil. En los días de viento gélido, las personas prefieren acurrucarse junto a la chimenea antes que caminar por la nieve para ver una función.

Sin embargo, la mayoría hace una excepción cuando se trata de ver los espectáculos de ballet de Odette.

Cada vez que su nombre aparece en los carteles del teatro, una larga fila se forma frente a las taquillas.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Odette%2FHistoria',
  biography_es_translated = false
where id = 'gi-odette';
update public.characters set
  biography_en = 'A young man from the Masters of the Night-Wind, who always seems to be calm and at ease, no matter what the situation. Catching him is no easy feat.

The Masters of the Night-Wind''s territory lies in the heart of Natlan, to the west of the Stadium of the Sacred Flame. From a distance, it appears much like a cloud of faintly glowing purple mist in the mountain valleys.
The impression left by members of their tribe on others is similar — profound, mysterious, and with a penchant for cryptic turns of phrase. Unless they''re out traveling on a commission, such as for healing or fortune-telling, they seldom show themselves outside.

Ororon, however, is an exception. This is not due to an inclination for mingling with the crowds, but rather that he prefers exploring the wilderness. He ventures deeper and deeper in directions where few dare to tread, and even ten Tatankasaurs could not drag him back.

What''s more, "where few dare to tread" is not simply limited to a literal sense.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Ororon%2FProfile',
  biography_es = 'Ni el peor de los pacientes es tan terco como él. Una vez que tiene una idea, es imposible hacerle cambiar de opinión. Sin embargo, no me tengo que preocupar por él, ya que tiene su propia forma de pensar. Creo que sabe sobrevivir bien en este caótico mundo. En una calurosa tarde cualquiera, un joven cierra la puerta de su casa y se despide de los brotes de verduras que hay en su jardín:

"Que tengan una buena tarde. Tengo que salir un rato, pero espero que a la vuelta se hayan vuelto aún más verdes. Ánimo".

Al cabo, vuelve con un amigo y, al pasar junto al gran árbol que hay en la entrada de su casa, le advierte amablemente:

"Ten cuidado de no tropezar. Últimamente, las raíces de Piñonzote están creciendo como locas".

Natlan es una tierra misteriosa y al buen médico Ifá, que ha vivido aquí desde siempre, ya no le parecen extrañas las cosas que hace Ororon.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Ororon%2FHistoria',
  biography_es_translated = false
where id = 'gi-ororon';
update public.characters set
  biography_en = 'The little "Witch Hunter" has journeyed far and wide in pursuit of the "wicked witch," though the story — and the grudge — driving this quest remains shrouded in mystery.

Just exactly when Prune''s grudge against the "witch" began, and what it is all about, is a story that remains untold by the many "writs of retribution" that can be found on the noticeboards of Mondstadt.

Ask any Mondstadter about the time they met the so-called "Witch Hunter," and you will likely hear of one of three types of reactions.

Those in the first group would tell you that they offered a kind smile before asking if she wanted a glass of Apple Cider. Those of the second persuasion would merely nod vaguely at her words, then ask where her family was.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Prune%2FProfile',
  biography_es = '"Querida Klee: Mamá sabe que Albedo está ocupado con su investigación, Durincito está con sus estudios y la Maestra Jean no le quita el ojo de encima al tío Varka, por lo que ninguno puede pasarse el día entero jugando contigo... ¡Pero no te preocupes! Hay una niña llamada Prune que va de camino a Mondstadt siguiendo las palabras de mamá. Aunque suele decir cosas un tanto complicadas, es como tú, Klee; tiene la edad perfecta para jugar sin preocupaciones. ¡Sé que ambas serán grandes amigas!".
Puede que últimamente te hayas encontrado con una visitante especial con una mirada un tanto desafiante por las calles de Mondstadt.

Esta pequeña cazadora se encuentra en la etapa más importante de su vida: su “periodo de caza”.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Prune%2FHistoria',
  biography_es_translated = false
where id = 'gi-prune';
update public.characters set
  biography_en = 'An apprentice and herb gatherer at Bubu Pharmacy. "Blessed" by the adepti with a body that cannot die, this petite zombie cannot do anything without first giving herself orders to do it. Qiqi''s memory is like a sieve. Out of necessity, she always carries around a notebook in which she writes anything important that she is sure to forget later. But on her worst days, she even forgets to look at her notebook...

Due to being a zombie, Qiqi lacks facial expression. She hopes that''s okay.

She may look like a zombie, but she''s surprisingly limber due to a strict calisthenics regimen.

Her memory is poor. She forgets easily, and that is partly why she can seem cold to others.

Her appearance is forever frozen at the point of her passing, so estimates of her age are unreliable.

Zombies require orders to act, but due to some reason or another, Qiqi is presently giving herself orders.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Qiqi%2FProfile',
  biography_es = 'Una aprendiz y recolectora de hierbas en la Farmacia Bubu. Una zombi con una tez blanca como el hueso, de pocas palabras y emociones.

Qiqi es una aprendiz y recolectora de hierbas de la Farmacia Bubu.

Un Adeptus la "bendijo" para que se convirtiera en una zombie que se da órdenes a sí misma para actuar.

Qiqi se caracteriza por tener muy mala memoria. Para cumplir con sus labores diarias, siempre lleva un cuaderno de apuntes con ella. Sin embargo, el cuaderno no le sirve de mucho, porque siempre se olvida de leerlo...',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Qiqi%2FHistoria',
  biography_es_translated = false
where id = 'gi-qiqi';
update public.characters set
  biography_en = 'The Raiden Shogun is the awesome and terrible power of thunder incarnate, the exalted ruler of the Inazuma Shogunate. 
With the might of lightning at her disposal, she commits herself to the solitary pursuit of eternity.

Since the dawn of life, humankind has always borne an intense yearning for and curiosity about the world. This is the anchor point of their cognition and is the foundation of all reason.

The world of the people of Inazuma is also thus. There, thunder, lightning, wind, and rain were primordial facts of life, as well as light, and the sea...',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Raiden%20Shogun%2FProfile',
  biography_es = 'Su Excelencia, la todopoderosa Narukami, quien le prometió al pueblo de Inazuma la inmutable eternidad.

Gobernante indiscutible de toda Inazuma

Llevando el nombre de "Su Excelencia, la todopoderosa Narukami", le prometió a los habitantes de Inazuma la inmutable eternidad.

Ha destruido el amor con el destello de un relámpago, forjando una tierra pura a partir de un corazón solitario.

Durante estos largos años, el camino hacia la eternidad ha sido oscuro y lejano, pero Su Alteza Shogun no ha dudado ni un momento.

Solo en el silencio, la eternidad inmutable revela su naturaleza serena.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Shogun%20Raiden%2FHistoria',
  biography_es_translated = false
where id = 'gi-raiden';
update public.characters set
  biography_en = 'Some say he is an orphan raised by wolves. Others say he is a wolf spirit in human form. He is most at home in the wild, fighting with claw and thunder. To this day the wolf boy can be found prowling the forest, where he and his wolf pack hunt to survive using nothing more than their animal instincts.

Razor is a boy whose identity is shrouded in mystery. He lives in Wolvendom and is rarely spotted by the citizens of Mondstadt.

According to a handful of eyewitness accounts, Razor has keen senses and is highly agile, traversing the forest at breakneck speed.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Razor%2FProfile',
  biography_es = 'Un chico que vive entre los lobos en el Reino de los Lobos de Mondstadt, lejos de la civilización. Es ágil como un relámpago.

Algunos dicen que es un huérfano criado por lobos. Otros dicen que es un espíritu lobo en forma humana. Se siente más a gusto en la naturaleza, luchando con garras y truenos. Se puede encontrar al niño lobo merodeando por el bosque, donde él y su manada cazan para sobrevivir usando nada más que sus instintos animales.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Razor%2FHistoria',
  biography_es_translated = false
where id = 'gi-razor';
update public.characters set
  biography_en = 'Rosaria, a sister in Mondstadt''s Church of Favonius. A sister of the church, though you wouldn''t know it if it weren''t for her attire. An unusual woman with sharp, piercing words and a cold manner. Her movements are unpredictable. She often leaves without notifying anyone. She acts with some kind of purpose, but others don''t seem to know exactly what she stands for...

Rosaria is one of the sisters of Mondstadt''s Church of Favonius.

Though she is just as much a woman of the cloth as the likes of Barbara and Jilliana, people tend to make a mental distinction between Rosaria and other members of the clergy.

While she might dress the part — at least, to a certain extent — her speech and actions do not reflect her office in the slightest.

Furthermore, she displays even less reverence towards the gods than the ordinary citizens, and she routinely skips her various church engagements.

She comes, goes, and acts in solitude, and if she were ever to make an appearance in the Cathedral, it w',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Rosaria%2FProfile',
  biography_es = 'Una monja que, aparte de por su ropa, nadie diría que pertenece al clero. Su frialdad hacia todo la hace extremadamente incisiva y siempre actúa en solitario.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Rosaria%2FHistoria',
  biography_es_translated = false
where id = 'gi-rosaria';
update public.characters set
  biography_en = 'Alain Guillotin would call her Marionette. Behind this name was the story of a loved one he could not forget and whose memories he had naively tried to revive by creating her. But the moment she opened her eyes and tentatively spoke his name, he resolved never to call her that again. It was wrong, he realized, to make this exquisite little creation bear the weight of his sister''s life, and of his own mistake. This little creation deserved a life of her very own, just like anyone else born into this world.

But from time to time, he still addressed her by that name, if only in his thoughts.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Sandrone%2FProfile',
  biography_es = 'La séptima de Los Once de los Fatui, conocida como “La Títere”. Además de interpretar todos los fenómenos a través del prisma de las matemáticas, es una elegante dama que nunca falta a las horas del té.

Sandrone fue mencionada por primera vez en la descripción del tráiler de Tartaglia, Tartaglia: Sello del Permiso, en la que se menciona que Javert solo ha recibido una orden de ella por un motivo desconocido.

Tanto Tartaglia como el Trotamundos la describen como alguien siempre ocupada en una investigación sobre Autómatas. Además, está estrechamente vinculada a Pulonia y a Fagio, máquinas relacionadas con su vida personal, su investigación y su estilo de combate.

Sandrone es la creadora de las Katherynes y forma parte de los Fatui, aunque su historia también está ligada a Fontaine, a Alain Guillotin y a la antigua Comunidad Cruz de los Narcisos.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Sandrone%2FHistoria',
  biography_es_translated = false
where id = 'gi-sandrone';
update public.characters set
  biography_en = 'Sayu, Shuumatsuban''s resident ninja, is obsessed with sleeping and growing taller. She has mastered all kinds of ninjutsu to run away and hide in pursuit of opportunities to laze around and sleep. Such an extraordinary skillset may have very unexpected uses.

Most Inazumans are unaware of the existence of the Shuumatsuban. In fact, the Shuumatsuban is a secret organization under the Yashiro Commission.

There is also a little ninja who goes by the name of Sayu in the Shuumatsuban, and this fact is even less known.

Sayu is a special existence in the Shuumatsuban. She has been raised in the Shuumatsuban since she was a child, and is extremely loyal to the organization.

That said, her most prominent trait is not "loyalty", but "laziness."

Lazing around is what Sayu does best.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Sayu%2FProfile',
  biography_es = 'Una ninja perteneciente a Los Ocelos. Muy bajita y siempre con aspecto de no haber dormido suficiente.

Una ninja perteneciente a Los Ocelos. Bajita, pero de movimientos extremadamente ágiles.

Oh, ¿su estatura?... Bueno, Sayu dejó de crecer hace mucho tiempo... Ella incluso piensa que se encuentra atrapada en un sueño donde el tiempo se detuvo.

¿Cuándo se supone que voy a crecer? ¿Será que no duermo lo suficiente?

A menudo se despierta con ese pensamiento, entonces vuelve a acurrucarse y a dormirse.

Sayu cree que, si continúa durmiendo, podrá recuperar energía y así crecer. Por eso, hace todo lo posible por holgazanear y practicar las técnicas ninja.

Saltar, camuflarse, rastrear, transformarse... No importa qué destreza sea, Sayu las domina todas con gran maestría.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Sayu%2FHistoria',
  biography_es_translated = false
where id = 'gi-sayu';
update public.characters set
  biography_en = 'A mysterious desert youth with a friendly smile who loves traveling by foot across both rainforest and desert.

A new face appeared in town, though none can recall when he first showed up.

The young man from the desert would show up at any occasion he was inclined to attend with a bearing so confident and natural that many only realized quite some time later that the person they had spoken with earlier was, in fact, a newcomer. After much asking around, they finally found out his name: Sethos.

"So, where did you meet again? He''s an old friend of yours, right?" People would ask each other such questions, before discovering to their surprise that none of them had known him for long.

Like a grain of sand blown over the high city walls by some wild desert wind, Sethos blended into the crowd with ease, speaking with them of homelands and travels.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Sethos%2FProfile',
  biography_es = 'Tendrás la astucia de un zorro, la agilidad de una serpiente voladora, y la sabiduría de Hermanubis te otorgará su favor. Te llamarás SethosEl vasto e infinito mar de arena a menudo atrapa a los viajeros inexpertos. De no ser por la oportuna guía de un alma bondadosa, su viaje de exploración podría haber llegado a un final prematuro y cruelmente truncado. Todos los que se han perdido y han vuelto con sus compañeros mencionan el mismo nombre: Sethos.

"Posee un gran sentido de la orientación", "apasionado y amable"... Estas son algunas de las impresiones que tienen todos los viajeros a los que Sethos ha guiado. Y, ciertamente, así es. Como habitante del desierto, Sethos conoce los caminos entre los distintos oasis como la palma de su mano. Es muy hábil orientándose con la posición del sol y utilizando distintas técnicas de orientación.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Sethos%2FHistoria',
  biography_es_translated = false
where id = 'gi-sethos';
update public.characters set
  biography_en = 'Shenhe was originally from a branch family of exorcists, but due to a series of coincidences, she became the disciple of an adeptus.

She is a student solely of Cloud Retainer in name, but her impressive constitution and intelligence quickly won several other adepti over.

She would go on to learn from them all, eventually becoming a master of adeptal arts in her own right as a mortal.

She very much looks the part as well in her unique temperament and manner of carrying herself — indeed, it would be no understatement to name her a true adeptus upon meeting her for the first time.

However, it is precisely due to the long years of tutelage that she has lacked company save for the adepti and odd passing illuminated beast.

This isolation has caused her to grow distant and indifferent.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Shenhe%2FProfile',
  biography_es = 'Recorrí numerosos mundos y enseñé a incontables discípulos. Entre ellos, Shenhe es la más parecida a míShenhe proviene de una rama familiar de un clan de exorcistas. Debido a ciertas razones, la Preservadora de Nubes la tomó como discípula.

Para Shenhe, la Preservadora de Nubes es una maestra conocedora y conversadora.

Una discípula de los Adeptus con una mirada perdida. Al haber vivido recluida en las montañas de Liyue, su carácter es tan frío y distante como el de los Adeptus.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Shenhe%2FHistoria',
  biography_es_translated = false
where id = 'gi-shenhe';
update public.characters set
  biography_en = 'The head nurse of the Fortress of Meropide. As a Melusine, she uses her unique perspective to observe and care for those around her.

Within the huge undersea facilities of the Fortress of Meropide, Sigewinne''s infirmary is one of the few places open to all people at all times.

A guard might have a terrible bout of illness while out on patrol at night, and have to be helped over to the infirmary by his colleagues, only to find that a hot drink and a clean bed had already been prepared, awaiting his arrival.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Sigewinne%2FProfile',
  biography_es = 'La enfermera jefa del Fuerte Merópide. Como melusina, utiliza su perspectiva única para observar y cuidar a quienes la rodean. En el Fuerte Merópide, donde el sol no brilla, la enfermería es el lugar más cálido.

Se dice que la enfermera jefa, encargada de la enfermería, fue quien la fundó. El Fuerte Merópide ha cambiado de manos varias veces en circunstancias caóticas a lo largo de los siglos, pero siempre ha existido un acuerdo tácito entre todos los que viven aquí de no perjudicar en modo alguno al personal médico.

La razón es sencilla: pocos médicos podrían soportar tratar a delincuentes y permanecer mucho tiempo en un lugar así.

Menos aún serían tan amables, simpáticos, atentos y considerados como Sigewinne.

En una ocasión, un recluso al que Sigewinne salvó la vida tras resultar gravemente herido al causar unos problemas, la proclamó emisaria de los cielos enviada para traer la salvación a los pecadores —un "ángel de la salvación"—, llegando a decir que predicaría dicho apodo p',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Sigewinne%2FHistoria',
  biography_es_translated = false
where id = 'gi-sigewinne';
update public.characters set
  biography_en = 'A mighty warrior of unknown origin. She claims to be the disciple of Surtalogi "The Foul," one of Khaenri''ah''s Five Sinners, and the master of "Childe" Tartaglia.

Her existence is like an unproven rumor...

Sometimes, past the stroke of midnight, a taverngoer will swear he had glimpsed her, waving hands painting a story of a person that nobody could be sure ever was.

For a very long time, Skirk has journeyed through Teyvat like a shadow, avoiding anything more than brief contact with others, only gathering intel when absolutely necessary.

It wasn''t until very recently that there came to be one who could claim to know her...

"Oh, my master? Haha, she''s the type to keep to herself."

"And, let''s see... She''s an alright cook. Could''ve been the creatures in that space tasting a little off in general, of course."

"We initially agreed to swing by my place after leaving. I wanted to let her try my family''s homemade sausages this year.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Skirk%2FProfile',
  biography_es = '"El mal infesta los cielos y los desastres se extienden por todo el universo. Nadie puede limitar tu libertad, pero tu destino sigue estando ligado a este mundo. De hecho, en un futuro no muy lejano, enviarás aquí a tu discípula".

"¿Cómo? ¿Voy a tener una discípula? Qué desgracia... para esa persona, quiero decir".
Arriba están las estrellas del velo nocturno.

Abajo, el Abismo del subsuelo.

Nadie sabe qué hay más allá del cielo estrellado, igual que nadie sabe qué tipo de existencia hay en el Abismo.

Como dice un augurio de la antigua Khaenri''ah:

"¿Aventurarse en el universo o en el más profundo de los abismos?

Quizás no importa, pues, al fin y al cabo, se trata de la más desconocida de las oscuridades".

Tras la caída de aquella civilización subterránea, en una tierra quemada que ya nadie recuerda...

Una persona que despreciaba al destino le quitó de las manos a una joven.

Cuando la joven creció, ella también salvó a otro niño que estaba atrapado por el destino.

Ojalá todo se',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Skirk%2FHistoria',
  biography_es_translated = false
where id = 'gi-skirk';
update public.characters set
  biography_en = 'An alchemist with an insatiable curiosity towards the world and everything in it. Attached to the Knights of Favonius as an assistant to Albedo, her area of focus is "bio-alchemy." She strives to enrich the world by transforming living things with the power of alchemy. Granted, the products of her research sometimes prove to be more weird than wonderful — but on the whole, she has made monumental contributions to the field of bio-alchemy.

Sucrose may be the assistant of the genius alchemist Albedo, but they could not be more different in research direction.

As opposed to studying the essence of alchemy and the ability to create new life, she is far more interested in using alchemy to modify existing life, all the better to add variety and color to this world.

Despite her youth, she has already achieved some brilliant results. For example, she has been able to increase the nectar output of Sweet Flowers by 70% by irrigating them with a special potion.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Sucrose%2FProfile',
  biography_es = 'Una alquimista con una insaciable curiosidad por el mundo y todo lo que hay en él. Adscrita a los Caballeros de Favonius como asistenta de Albedo, su área de interés es la "bio-alquimia". Se esfuerza por enriquecer el mundo transformando seres vivos con el poder de la alquimia. Es cierto que los productos de sus investigaciones a veces resultan más extraños que maravillosos, pero en general, ha hecho contribuciones notables en el campo de la bio-alquimia.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Sacarosa%2FHistoria',
  biography_es_translated = false
where id = 'gi-sucrose';
update public.characters set
  biography_en = 'Meet Tartaglia — the cunning Snezhnayan whose unpredictable personality keeps people guessing his every move. 
Don''t be under any illusion as to what he might be thinking or what his intentions are. Just remember this: Behind that innocent, childlike exterior lies a finely honed instrument of war.

Despite holding one of the most senior positions in the Fatui as one of the Eleven Harbingers, Childe very much looks like the young adult that he still is.

He is a wolf in sheep''s clothing, however, for under the cheerful and confident appearance lies a deadly swordsman.

He is the youngest among the Harbingers, but one of the most dangerous among their number.

That said, Childe doesn''t seem to fit in well with the others.

As a fighter first and foremost, he is quite at odds with this organization of deceit and treachery.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Tartaglia%2FProfile',
  biography_es = 'Tartaglia es un sujeto imprevisible proveniente de las tierras de Snezhnaya. No hace falta adivinar cuáles son sus intenciones. Solo hay que tomar esto en cuenta: detrás de esa apariencia inocente e infantil, se esconde una máquina de guerra precisa y perfecta.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Tartaglia%2FHistoria',
  biography_es_translated = false
where id = 'gi-tartaglia';
update public.characters set
  biography_en = 'The housekeeper of the Yashiro Commission''s Kamisato Clan, and a well-known "fixer" in Inazuma. Friendly and approachable, Thoma fits in with the crowd easily wherever he is. At first glance, he seems to be a very easygoing person, but he is in fact very responsible. He has an extraordinarily serious side, be it in his work or his interpersonal communications.

Thoma''s official title in the Kamisato Clan is that of a "housekeeper," and as such, he is responsible for matters such as cleaning and cooking.

Whenever he appears at the Yashiro Commission, Thoma is almost always busy with such work.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Thoma%2FProfile',
  biography_es = 'Thoma es, actualmente, el principal sirviente del Clan Kamisato y tiene un cierto nivel de asociación con los hermanos Kamisato, así como una gran red de contactos en Ritou debido a la ayuda que presta a los extranjeros para sobrevivir.

Nació en Mondstadt pero actualmente vive en Inazuma, donde es el amo de llaves del clan Kamisato de la Comisión Yashiro. También es un intermediario muy activo en Inazuma.

Influenciado tal vez por el ambiente relajado y alegre de su ciudad natal, Thoma es muy bueno para socializar. Y, a pesar de ser un forastero, ha construido una red de amigos inesperadamente grande en la región de Inazuma.

Es naturalmente amigable con todos y siempre es capaz de conversar sobre una amplia variedad de temas y entablar relaciones con diferentes personas.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Thoma%2FHistoria',
  biography_es_translated = false
where id = 'gi-thoma';
update public.characters set
  biography_en = 'An Avidya Forest Watcher and botanical scholar who graduated from Amurta. He leads a fruitful life of patrolling the rainforest, protecting the ecology, and lecturing fools every day.

Those who travel through Avidya Forest will sometimes meet a rather special Forest Watcher.

He has large ears, a long tail, and a slightly delicate face. If a less discerning eye were to appraise him, he might even look like some kind of small, rare animal native to the forests.

But anyone who has even been acquainted with him will know that there is clarity to his words and steadiness in his bearing.

"One moment, please. Judging from your equipment, you''re a traveling merchant bound for Sumeru City, aren''t you? Come back, please, you''re going the wrong way."

"I mean, just look over there. The leaves are dense and the air grows damper.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Tighnari%2FProfile',
  biography_es = '"Te dejo el mensaje. Traje del desierto dos bolsas de dátiles con miel. Siempre vienen bien para reponer fuerzas, ya sea de día o de noche. Muchas gracias por tener tanta paciencia con Collei y por ser tan paciente con ella. Espero que todo vaya bien en el trabajo y Collei esté esforzándose en sus estudios".

Incluso aquellos que se topan con todo tipo de infortunios en el Bosque Avidya serán afortunados si se encuentran con el guarda forestal que se hace llamar Tignari.

Pero si andas haciendo tonterías en el bosque por gusto, tal vez deberías evitar encontrártelo.

Tignari siempre se sirve de los métodos más profesionales para solucionar rápidamente cada problema y, al mismo tiempo, plasma toda su severidad en cada una de sus lecciones.

Existe un dicho que dice: Si menosprecias el bosque, acabarás metido en un aprieto. Si menosprecias a los guardas forestales, acabarás en el aula de estudio de técnicas de supervivencia.

En realidad, todo eso no son más que rumores.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Tignari%2FHistoria',
  biography_es_translated = false
where id = 'gi-tighnari';
update public.characters set
  biography_en = 'The keeper is fading away; the creator has not yet come.

But the world shall burn no more, for you shall ascend.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Traveler%2FProfile',
  biography_es = 'Un viajero de otro mundo a quien le arrebataron su único familiar, obligándolo a salir en un viaje para encontrar a Los Siete, dioses gobernantes de Teyvat.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Viajero%2FHistoria',
  biography_es_translated = false
where id = 'gi-traveler';
update public.characters set
  biography_en = 'An orchard owner who normally leads a laid-back life. However, when her fighting spirit is ignited, she dons a unique mask and exudes the indomitable air of a legendary hero.

"Time for training, Varesa!"

Every morning the coach would bellow her thunderous words, so loud in fact that a cloud of dust would rise up from the orchard.

A few moments later, a core member of the Collective of Plenty''s Patrol Team and the manager of a popular orchard — Varesa, who had overslept — would clumsily bumble her way into the gym, a slice of jam-coated bread in her mouth.

At this point, Varesa would listen to her coach''s instructions with sleep-heavy eyes and a blank expression, before dutifully starting her warmups and slowly regaining her strength...

Occasionally, her coach would point out — that jam contains too much sugar, which means it''s punishment time!',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Varesa%2FProfile',
  biography_es = '"Ah, Varesa... mi discípula más especial. Nadie podría imitar su estilo tan despreocupado. Esté dónde esté, siempre parece una niña que está de excursión y solo piensa en la comida local o en buscar un buen lugar para acampar y dormir. Ahora bien, si alguna vez luchas contra el Abismo junto a ella, te aconsejo tener cuidado. Una vez que se pone la máscara, su ritmo de ataque se vuelve... un tanto agresivo".
Al hablar de los habitantes de la Comunidad de la Feracidad, la primera reacción de la gente de Natlan es elogiar su buena forma física y, inmediatamente después, les viene a la cabeza el grato recuerdo de la fruta dulce y verdura fresca.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Varesa%2FHistoria',
  biography_es_translated = false
where id = 'gi-varesa';
update public.characters set
  biography_en = 'Grand Master of the Knights of Favonius and serving Knight of Boreas, guardian of Mondstadt. This title booms louder than the howl of the north wind, and his legend reverberates long after the ring of clashing blades falls still.

It is in bustling taverns that the grand tales of Varka are told, and they almost always begin with the extraordinary story of his birth.

Some claim that, when he was still in his swaddling clothes, two venomous serpents sought to slay the hero he was to be. Yet the infant, not a full month old, seized them, one in each hand, and tossed them from his cradle as if they were mere playthings. And thus, ''tis said, he grasped the secret to wielding twin blades!

Some say that, upon the very hour of his birth, a bitter north wind, the likes of which had not scourged Mondstadt in a century, tore through the sunlit skies. And from the depths of Wolvendom rose a chorus of wolf cries, one answering another.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Varka%2FProfile',
  biography_es = 'El Gran Maestro de los Caballeros de Favonius, así como el Caballero de Boreas que protege Mondstadt.

Según los comentarios de otras personas sobre él, Varka es una de las personas más poderosas de Mondstadt. Tartaglia lo llama el "Titán de los Caballeros de Favonius" y espera enfrentarlo algún día en combate, mientras que Bárbara dice que no hay nada de qué preocuparse mientras él lidere la expedición.

Sin embargo, parece que hay opiniones divididas sobre él. Para Diluc y Albedo, no parece ser una persona del todo de fiar, mientras Kaeya dice que admira sus métodos pero comenta que causó problemas a la gente de su alrededor hasta llegar a convertirse en leyenda. Uno de los personajes más cercanos a él es Mika y lo admira profundamente.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Varka%2FHistoria',
  biography_es_translated = false
where id = 'gi-varka';
update public.characters set
  biography_en = 'A bard that seems to have arrived on some unknown wind — sometimes sings songs as old as the hills, and other times sings poems fresh and new. Likes apples and lively places but is not a fan of cheese or anything sticky. When using his Anemo power to control the wind, it often appears as feathers, as he''s fond of that which appears light and breezy.

An unknown bard that came from nowhere. He sometimes sings outdated songs, other times he hums new ones that none have ever heard of.

He likes apples and lively atmospheres, but hates cheese and anything that is slimy.

When channeling Anemo, it appears in the form of feathers, because he likes things that look light.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Venti%2FProfile',
  biography_es = 'Uno de los muchos bardos de Mondstadt que deambula libremente por las calles y callejones de la ciudad.

Un bardo misterioso al que le gusta recitar tanto viejos poemas como nuevas canciones de moda. Le encantan las manzanas, el vino y los ambientes animados, odia el queso y es alérgico a los gatos.

Puede manifestarse en forma de plumas y viento, seguramente debido a su obsesión por los objetos ligeros y voladores.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Venti%2FHistoria',
  biography_es_translated = false
where id = 'gi-venti';
update public.characters set
  biography_en = 'If the measure of humanity is having a heart, then he cannot be deemed as such. If one without a heart experiences joy and sorrow, then he shall be a puppet most alike to humanity.

He needs not introduce himself, for ordinary folk will never get to know him.

Nor will he need to immerse himself in the sea of humanity, for he has long forsaken any worthless emotion.

Several times now he has risen and fallen, and now he lives only for himself.

"Wanderer" is how he believes he might be best described — he has no home, no kin, and no destination.

Like the breeze, he lives in this world, and he walks its length and breadth.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Wanderer%2FProfile',
  biography_es = '"Los creyentes forjan la gloria de los dioses, mientras que los incrédulos son testigos de su trascendencia. A él, sin embargo, no le asignaré a ninguna categoría, pues la incertidumbre es la base de su futuro camino".

Aquella noche, una sombra llegó a un lugar antiguamente conocido como "Tatarasuna". Los vecinos de la zona se habían marchado hacía tiempo, pero como si el destino lo hubiera decretado, un granjero llegó hasta allí mientras recogía percibetormentas para ganarse la vida. Así, bajo la luz de la luna, vio una figura fantasmagórica de pie en el borde de un precipicio.

Llevaba un sombrero ancho que ocultaba su rostro por completo. Sin embargo, el granjero podía oír su respiración a través del golpeteo de la lluvia.

Un momento después, la sombra habló: "Así es como deben de respirar los humanos".

El granjero se aterrorizó al pensar que podría haber encontrado un espíritu, y se escondió a toda prisa detrás de una roca. La sombra volvió a hablar: "¿De qué tienes miedo?',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Trotamundos%2FHistoria',
  biography_es_translated = false
where id = 'gi-wanderer';
update public.characters set
  biography_en = 'Administrator of the Fortress of Meropide, he was given Fontaine''s highest honorary title of "Duke." Both low-profile and dependable.

To the great relief of the Maison Ordalie, most Fontainians are law-abiding citizens. As such, the Fortress of Meropide is not a place that they will ever visit in their lives.

At the same time, there is an easily understood yet rather tragic truth, which is that those who have served time often find it difficult to reintegrate back into the "overworld," and few will actively speak of their experiences in the "underworld."

Rather than a specific place, the Fortress is more like an idea, a warning, a symbol of misfortune and castigation — a byword amongst Fontainians.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Wriothesley%2FProfile',
  biography_es = '"Navia, ¿recuerdas cuando, hace unos años, rechacé el título de conde con el que me quiso condecorar el Palacio Mermonia? Bueno, eso no es lo importante. Hoy por fin conocí al alcaide del Fuerte Merópide. Siempre pensé que un título tan importante como el de duque era algo completamente accesorio... Pero ese tal Wriothesley es mucho más avezado de lo que aparenta".

"Alcaide del Fuerte Merópide".

Si Wriothesley tuviera una tarjeta de presentación, eso sería lo único que pondría en ella.

Sin palabrería innecesaria, supervisa ese taciturno lugar del fondo marino al que van los criminales desterrados.

Como lugar de residencia de malhechores, y a pesar de la discreción del lugar, los conflictos de intereses del Fuerte Merópide son motivo de corrupción para muchos.

En realidad, aunque alguien tramara entrar a escondidas en este sitio, desaparecería tan rápidamente como un trocito de pan en una sopa.

Cuando alguien adula al Ilustrísimo Sr.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Wriothesley%2FHistoria',
  biography_es_translated = false
where id = 'gi-wriothesley';
update public.characters set
  biography_en = 'The Head Chef at the Wanmin Restaurant and also a waitress there, Xiangling is extremely passionate about cooking and excels at her signature hot and spicy dishes. Though still young, Xiangling is a true master of the culinary arts with all the skills of a kitchen veteran. She enjoys a good reputation among the hearty eaters at Chihu Rock. There''s absolutely no need to be nervous if she wants you to sample her latest creation. It will not disappoint. Promise.

"Coming, coming! Here''s your Stir-Fried Filet! And your Mora Meat.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Xiangling%2FProfile',
  biography_es = 'Una reconocida chef de Liyue. Le apasiona la cocina y sobresale al hacer sus platos calientes y picantes.

La jefa de cocina del Restaurante Wanmin y también camarera allí, Xiangling es una apasionada de la cocina y destaca en sus platos picantes y característicos. Aunque todavía es joven, Xiangling es una verdadera maestra de las artes culinarias con todas las habilidades de un veterano de la cocina. Disfruta de una buena reputación entre los comensales abundantes de Chihu Rock. No hay absolutamente ninguna necesidad de estar nervioso si quiere que pruebes su última creación. No te defraudará.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Xiangling%2FHistoria',
  biography_es_translated = false
where id = 'gi-xiangling';
update public.characters set
  biography_en = 'A mysterious woman who has just moved to Liyue Harbor and claims to be reserved, quiet, and socially inept.

According to the "Thrice Annotated Version of the Full Record of Pristine Pavilion," a roaming adeptus travels with the "Spirit of Eight Pure and Mighty Rose-Clouds," dancing through the air as though "riding light and striding lightning." Their lives, too, are long beyond mortal reckoning. What humans call a millennium is but time for a short rest for the adeptus in their abode. As the saying goes, "Night and day belong not in paradise."

As for where the adepti dwell, the "Full Record of Pristine Pavilion" asserts that the sky is their pillow and the earth their mat, and that they may dwell in the mountains, rivers, lakes, and seas — and this indeed seems to explain the countless adeptal encounters recorded in the annals of Liyue''s history.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Xianyun%2FProfile',
  biography_es = '¿Dices que alguien nuevo se ha mudado a la ciudad? Oh, es Preser... Ah, no, es Xianyun. No tengas en cuenta ese carácter que ella tiene... Cuando se le necesita en los momentos importantes, siempre estará ahí para quien lo necesite. Si algún día te ves en problemas, no dudes en acudir a ella, siempre es la primera en ofrecerse a ayudar

Todo el mundo tiene algo que decir sobre Xianyun: "Esa mujer alta de pelo despeinado", "Esa artesana con gafas", o quizás "Esa vecina a la que le gusta tanto hablar". Cada persona opina algo diferente, pero todos sus comentarios conforman la imagen de la impresión que ella deja en los demás: una mujer divertida, dicharachera, amable y de trato fácil.

No obstante, eso no tiene nada que ver con la imagen que Xianyun tiene de sí misma. A sus ojos, ella es una persona de pocas palabras, reservada, una vanidosa implacable...',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Xianyun%2FHistoria',
  biography_es_translated = false
where id = 'gi-xianyun';
update public.characters set
  biography_en = 'One of the mighty and illuminated adepti guarding Liyue, also heralded as the "Vigilant Yaksha." Despite his youthful appearance, tales of his exploits have been documented for millennia. He is especially fond of Wangshu Inn''s Almond Tofu. This is because it tastes just like the sweet dreams he used to devour.

Xiao may have the appearance of a young man, but his true age is something over two thousand years.

Fortunately, people do not tend to underestimate him on the basis of his appearance — one only needs to spend a short time with Xiao to clarify that he is not someone to be trifled with.

Xiao is a man of few words. He is highly dangerous, and has the most piercing gaze you''ve ever seen.

He enjoys a formidable reputation and high level of seniority among the adepti, but is relatively unknown in the mortal realm.

This is inevitable.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Xiao%2FProfile',
  biography_es = 'Un Yaksha y Adeptus que protege Liyue. También llamado el “Gran Cazador de Demonios” o “Guardián Yaksha”.

Uno de los poderosos e iluminados Adeptus que custodian Liyue. También llamado el "Guardián Yaksha". A pesar de tener una apariencia joven, algunas de sus hazañas ya aparecen en libros antiguos de hace miles de años atrás. Le gusta especialmente el tofu de almendras de la Posada Wangshu. Le encanta este plato porque le sabe igual que los sueños que solía devorar.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Xiao%2FHistoria',
  biography_es_translated = false
where id = 'gi-xiao';
update public.characters set
  biography_en = 'A blacksmith of the Nanatzcayan, she is especially skilled at finding a good balance between the heavy responsibilities of her job and living well.

All in Natlan know Xilonen for her great forging skills and her fame as a Name Engraver.

Many come from far and wide to pay homage to her superb skill. Some hope to commission her to forge them weapons, while others only seek to see the visage of this great smith, such that they might have information of great interest to talk about.

But Xilonen couldn''t care less about what all her customers are thinking. No matter what kind of ridiculous, fancy titles others give her, before all the honors and accolades, she is first and foremost an artisan. All she need do is refine the ore, and surely and steadfastly hammer it into its final shape one blow at a time, in accordance with the customer''s requirements.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Xilonen%2FProfile',
  biography_es = 'Una maestra forjanombres de Nanatzcayan experta en encontrar el equilibrio entre el ajetreo del trabajo y una vida cómoda.

Xilonen es muy conocida desde hace tiempo en Natlan por sus extraordinarias habilidades de forja.

La gente la admira por dichas habilidades y van a visitarla desde todas partes de la nación. De esas personas, algunas le encargan armas, y otras solo quieren conocer a esta herrera tan afamada y charlar un rato con ella.

Sin embargo, a Xilonen no le importa el motivo por el que la visiten.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Xilonen%2FHistoria',
  biography_es_translated = false
where id = 'gi-xilonen';
update public.characters set
  biography_en = 'The second son of the Feiyun Commerce Guild, Xingqiu has had a reputation for being studious and polite ever since he was a young child. But there is another side to the mild-mannered Xingqiu everyone knows. A daring, adventurous and much more mischievous side...

Every merchant in Liyue Harbor knows of Xingqiu from the Feiyun Commerce Guild.

All see him as a kind and well-mannered young man who is an excellent student, a top talent in every sense.

As the second-born son of the family, Xingqiu is not required to shoulder the burden of managing the Guild''s affairs.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Xingqiu%2FProfile',
  biography_es = 'Un joven que lleva una espada larga que se ve con frecuencia en las cabinas de libros. Tiene un corazón de oro y anhela la justicia y la equidad para todos.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Xingchiu%2FHistoria',
  biography_es_translated = false
where id = 'gi-xingqiu';
update public.characters set
  biography_en = 'Rock ''n'' roll is an avant-garde art in Liyue Harbor and Xinyan is the pioneer in this field. She rebels against ossified prejudices, using her music and passionate singing to awaken dazed souls fatigued by worldly matters. If you get the chance, do not miss out on her next performance!

Rock ''n'' roll originates in Fontaine and is just starting to find its feet in Liyue Harbor, where Xinyan is pioneering the art.

Every night, she slings on her self-built instrument, steps onto her self-constructed stage, and plays her self-composed songs to a crowd of enthusiastic supporters.

Her music reflects her personality: bold and defiant, loud and proud.

She is no virtuoso, but this doesn''t bother her dedicated fans one bit as they let loose and enjoy the show, singing their hearts out and shaking off the stress of the day.

In the heat of the moment, the fire that leaps from Xinyan''s Vision seems ready to turn night into day.

"She is a rare rock ''n'' roll talent and a master performer who rea',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Xinyan%2FProfile',
  biography_es = 'En Liyue, el rock and roll es una nueva forma de arte, y Xinyan es la pionera. A través de la música y la pasión de sus canciones, critica los prejuicios de la sociedad, intentando sacudir el espíritu conformista de la gente. Si tienes la oportunidad, no dejes pasar uno de sus conciertos.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Xinyan%2FHistoria',
  biography_es_translated = false
where id = 'gi-xinyan';
update public.characters set
  biography_en = 'The head shrine maiden in charge of Grand Narukami Shrine and a descendant of Kitsune lineage, Eternity''s servant and friend, and the intimidating editor-in-chief of Yae Publishing House, a publisher of light novels...

The head shrine maiden of the Grand Narukami Shrine, descendant of Hakushin''s lineage, Eternity''s servant and friend, and the intimidating editor-in-chief of Yae Publishing House, a publisher of light novels...

Come to think of it, Yae Miko''s nicknames are as myriad as her changeable moods.

The number of people who have tried to "figure her out" for various reasons could fill the streets from the Tenryou Commission estate to Yae Publishing House if you were to line them all up, but to this day, very few indeed have succeeded.

Not that Miko has ever intended to conceal anything, of course. Any capriciousness is but the result of doing as she wills and pleases.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Yae%20Miko%2FProfile',
  biography_es = 'La Suma Sacerdotisa del Gran Santuario Narukami y editora jefa de la Editorial Yae. Bajo su increíble encanto esconde una inteligencia y una astucia inimaginables.

Es la miko principal del Gran Santuario Narukami, heredera del linaje kitsune, parientes y amigos de la eternidad. Además, es la temible editora en jefe de la Editorial Yae. La Shogun Raiden la menciona cuando la Arconte habla de Zhongli. Es una "vieja amiga" de Morax y Baal, y también conoce a Ganyu.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Yae%20Miko%2FHistoria',
  biography_es_translated = false
where id = 'gi-yae-miko';
update public.characters set
  biography_en = 'A half-illuminated beast and highly-skilled legal adviser. She combines adherence to the legal codices and reasonable flexibility to find the perfect balance in her work. She devotes herself to protecting the fairness of contracts in Liyue with her identity as a legal adviser and her unique experience and methods.

Liyue is a port that prizes contracts and trade, and it is a place where wealth accumulates.

Merchants from various nations are active here, which has contributed to Liyue''s abundance, but has also brought up many disagreements. The Tianquan, Ningguang, has written a very comprehensive compendium of laws to deal with this, but not everyone has the patience to study them.

Thus was born the role of the legal adviser in Liyue society.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Yanfei%2FProfile',
  biography_es = 'Una reconocida asesora legal que vive en Liyue. Esta joven tan perspicaz tiene parte de sangre de bestia iluminada.
Yanfei es una asesora legal en Liyue, pero también es, en parte, una bestia iluminada tal y como Ganyu; las astas a los lados de su cabeza son su símbolo de su herencia como tal.

Ni siquiera Morax tiene control de todas las bestias iluminadas, siendo Yanfei de las pocas que no firmó un contrato con él. Ella nació en una época pacífica, así que no tenía necesidad de pelear en guerras como sus ancestros. Aún así, escogió la profesión de interpretar las leyes y ayudar a los demás con conflictos y disputas.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Yanfei%2FHistoria',
  biography_es_translated = false
where id = 'gi-yanfei';
update public.characters set
  biography_en = 'A young adepti disciple who is generous and sincere. She is used to taking care of everyone around her. She trains under her master at Liyue Harbor and regularly travels between the mountains and the city. Although she does not say it outright, she prefers bustling city markets to the tranquil mountains.

The adepti faithfully adhere to the contract that they have with Rex Lapis, and have thus defended Liyue for millennia.

When danger arises in Liyue, the adepti are sure to come forth, and they do show up from time to time when the land is at peace.

Sometimes, they do so to punish those who harbor evil in their hearts, and sometimes they intervene to save the imprisoned.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Yaoyao%2FProfile',
  biography_es = 'Yaoyao hace todo lo posible por actuar como una adulta joven adecuada con los demás, incluidos sus mayores, asegurándose de que tengan una dieta saludable y le gustan especialmente los rábanos. Tiene mucha curiosidad por el mundo exterior, ya que originalmente vivió una vida recluida con sus padres en la Aldea Chingtsé hasta que Madam Ping la acogió. Al igual que Dodoco de Klee, Yaoyao está muy apegada a Yuegui, a quien la Preservadora de Nubes hizo para ella.

Yaoyao tiene piel clara, ojos rojo oscuro pálido que son dorados en la parte inferior y cabello castaño dorado.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Yaoyao%2FHistoria',
  biography_es_translated = false
where id = 'gi-yaoyao';
update public.characters set
  biography_en = 'A mysterious person who claims to work for the Ministry of Civil Affairs, but is a "non-entity" on the Ministry of Civil Affairs'' list. Elusive, enigmatic, erratic - all of these are Yelan''s hallmarks.

Liyue''s Ministry of Civil Affairs is an organization marked by transparency — from ordinary staff members of the Eight Trades to prominent officials of Yujing Terrace, every employee has their basic information documented in the Ministry''s lists.

Yelan, despite claiming to work for the Ministry, is the sole exception. Most of her colleagues have never heard of her, nor is her name anywhere to be found on any rosters.

This does say something about her character — elusive, enigmatic, and erratic.

She is a ghost who walks in the middle of many crises under various names.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Yelan%2FProfile',
  biography_es = 'Una misteriosa persona que dice trabajar para el Ministerio de Asuntos Civiles, pero que “no existe” según los registros del propio Ministerio.

La identidad de Yelan siempre ha sido un misterio.

Como un fantasma, a menudo aparece de varias formas en el centro de los acontecimientos y desaparece antes de que pare la tormenta.

Las personas que están atrapadas en problemas esperan conocerla. Por alguna razón, la mayoría piensa que ella los ayudará, y si no, quieren que sea su aliada.

Pero el problema es que sus oponentes albergan la misma idea.

Cada una de estas personas ha conocido a una Yelan que tiene un nombre e identidad diferente, y cada uno de ellos piensa que puede llegar a asociarse con ella. Sin embargo, todo el mundo se ha mantenido en la oscuridad.

¿A quién quiere ayudar?',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Yelan%2FHistoria',
  biography_es_translated = false
where id = 'gi-yelan';
update public.characters set
  biography_en = 'A talented pyrotechnician. The current owner of Naganohara Fireworks known as the "Queen of the Summer Festival." 
A girl filled with fiery passion. The uncompromising childish innocence and the obsession with craftsmanship intertwine in her to create a spectacular blaze.

Yoimiya''s name is renowned throughout Hanamizaka.

She is the most skilled pyrotechnician in Inazuma and is known as the "Queen of the Summer Festival."

Yoimiya, who has inherited the mantle of "Naganohara", is able to give people an unparalleled experience with her ever-changing and spectacular fireworks.

In addition to being a craftsperson, she is also the "heroic sister" in the eyes of many children.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Yoimiya%2FProfile',
  biography_es = 'La dueña de la tienda Pirotecnia Naganohara y Reina del Festival de Verano. Deposita los deseos de la gente en sus artesanales fuegos artificiales.

Una pirotécnica de talento extraordinario. Como dueña de la tienda Pirotecnia Naganohara, es conocida como la "Reina del Festival de Verano". En Inazuma no hay nadie que no la conozca. Los fuegos artificiales creados con tanta originalidad de la mano de Yoimiya protagonizan las ceremonias de Inazuma de todos los años.

Sus fuegos artificiales creados con tanta originalidad de la mano de Yoimiya protagonizan las ceremonias de Inazuma de todos los años.

Sus fuegos artificiales rebosan creatividad y traen sorpresas únicas a todos los espectadores.

De carácter juguetón e inocente, a Yoimiya le gusta organizar juegos sencillos pero divertidos con los niños, acompañarles a buscar cristales brillantes y cachivaches.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Yoimiya%2FHistoria',
  biography_es_translated = false
where id = 'gi-yoimiya';
update public.characters set
  biography_en = 'The current director of the Yun-Han Opera Troupe, a renowned Liyue opera singer who is skilled in both playwriting and singing. Her style is one-of-a-kind, exquisite and delicate, much like the person herself.

Heyu Tea House has been a popular leisure spot for the people of Liyue.

Its business thrives on two things, one of them being its boss Fan Er''ye''s business acumen in inviting a top-notch Tea Master who tells the best stories of all.

Besides that, there is also the performance of the acclaimed troupe, Yun-Han Opera Troupe. Its director and soul — a famed opera singer named Yun Jin — takes the stage at the tea house from time to time.

While one can always get delicious delicacies or good storytelling as long as one knows where to look, Yun Jin''s performance does not just await one there.

As a result, you can always find fans of Yun Jin trying their luck at Heyu Tea House.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Yun%20Jin%2FProfile',
  biography_es = 'Una renombrada cantante de ópera de Liyue que es experta tanto en la creación de obras como en el canto. Su estilo es único, exquisito y delicado, como su propia persona.

¡Con una sola actuación de Yun Jin en nuestra casa de té podemos ganar Mora suficiente como para vivir durante todo un mes!Si alguna vez ves a Yun Jin sacudiendo su melena en un concierto de rock, por favor, abstente de contárselo a todo el mundo.
De lo contrario, sus mayores podrían regañarla de nuevo.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Yun%20Jin%2FHistoria',
  biography_es_translated = false
where id = 'gi-yun-jin';
update public.characters set
  biography_en = 'Wangsheng Funeral Parlor''s mysterious consultant. Handsome, elegant, and surpassingly learned. Though no one knows where Zhongli is from, he is a master of courtesy and rules. From his seat at Wangsheng Funeral Parlor, he performs all manner of rituals.

In Liyue''s traditional customs, "receiving adepti" and "sending adepti off" are equally important.

The Hus of the Wangsheng Funeral Parlor, who have been in this business for 77 generations, are the masters of handling funerals. However, Hu Tao, the current owner of Wangsheng Funeral Parlor, primarily focuses on the art of sending mortals on their way.

For the various ceremonies for sending adepti off, Hu Tao usually employs the help of a friend in more or less the same business. That person''s name is Zhongli. The adepti have been with Liyue for millennia, but only a handful have ascended in the past three thousand years, which means that everything regarding the traditions now only exists in texts.',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Zhongli%2FProfile',
  biography_es = 'Misterioso asesor de la Funeraria El Camino. Erudito y con información sobre todo tipo de cosas.

Un misterioso hombre invitado por la Funeraria El Camino. Un gran conocedor de todos los saberes. Zhongli no parpadea al pagar (o pedir a otros que paguen). Con gusto paga el precio, sin importar cuán irrazonable sea, y pagará incluso más por las cosas que le gustan. La parte divertida es que Zhongli siempre olvida llevar su dinero con él.',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Zhongli%2FHistoria',
  biography_es_translated = false
where id = 'gi-zhongli';
update public.characters set
  biography_en = 'The White Horse Adeptus from Liyue''s legends, known as Zibai, is the most mysterious figure in Liyue''s myths.

The legends of Liyue make mention of a mysterious White Horse Adeptus.

Traces of her story are scattered throughout books and folktales. Yet, across these diverse sources, accounts of her appearance are never quite the same.

Some say she became a steed as white as snow and, in the days of the Archon War, aided Rex Lapis in attaining supremacy over the mortal realm.

Others whisper that her eyes, like amber touched with gold, hold the power to gaze through the desolate wastelands of time itself.

Still others claim she has always lived on the moon, listening to the wishes of mortals, and keeping watch over the world of flickering lights below.

Yet, amidst all these different accounts, none could truly capture her visage, nor paint a likeness of her form.

Whether amidst gentle tea-time chatter, or in debates pouring out over ink-filled scrolls, each view was a glimpse throug',
  biography_source_en = 'https://genshin-impact.fandom.com/wiki/Zibai%2FProfile',
  biography_es = '"El viento siempre erosiona la bondad hasta convertirla en historias lejanas, y luego transforma esas historias en leyendas difusas, las cuales están destinadas a un olvido inevitable... ¿Por qué, entonces, escogiste este camino?".
En Liyue siempre han circulado historias populares sobre los Adeptus.

Ejemplos de ello son los «Registros del pabellón inmaculado» y su Adeptus ociosa que controlaba la lluvia para acabar con la sequía, o el texto «Yakshas: los guardianes Adeptus» y su mención a Alatus Nemeseos, el cual se dedicaba a erradicar las plagas.

Todos ellos eran seres poderosos que protegían la paz en cada rincón del mundo, y por ello eran venerados por la gente.

También está la Adeptus Yegua Blanca, cuyas huellas perduran tanto en los libros como en las leyendas populares.

Algunos dicen que tomó la forma de una yegua blanca y que ayudó al Rey Geo a conseguir su autoridad en el mundo de los mortales durante la Guerra de los Arcontes.

Otros dicen que sus ojos, dorados como el á',
  biography_source_es = 'https://genshin-impact.fandom.com/es/wiki/Zibai%2FHistoria',
  biography_es_translated = false
where id = 'gi-zibai';

-- ---------------------------------------------------------------------------
-- Honkai: Star Rail (81 personajes)
-- ---------------------------------------------------------------------------
update public.characters set
  biography_en = 'A drifter claiming to be a Galaxy Ranger. Her true name is unknown. She walks the cosmos alone, carrying with her a long sword.

A drifter claiming to be a Galaxy Ranger. Her true name is unknown, and she walks the cosmos alone, carrying with her a long sword. Though aloof and taciturn, her blade flicks out like lashing lightning. And yet, she always strikes with her scabbard, never drawing the sword free.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Acheron%2FLore',
  biography_es = '"... Los guerreros no eligen sus espadas, sus espadas los eligen a ellos. ██████████████████████████████████████████████████████████████████████████... Ese día, cuando vi que le dieron la espada que hice a esa chica, me di cuenta de que en la pelea contra ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇, ella eligió, o fue elegida, para aceptar el camino que ▇▇▇▇▇▇▇▇▇ la llevó hacia un nuevo mañana. ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ habrá un futuro brillante. A pesar del peligro que acecha al Reino Izumo, su gente mantiene la esperanza y cree que un día los ▇▇▇▇▇▇▇▇▇ serán derrotados y el mundo quedará liberado... ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇...".

Fragmento de un antiguo manuscrito',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Acheron',
  biography_es_translated = false
where id = 'hsr-acheron';
update public.characters set
  biography_en = 'In that holy city kissed by the dawn, the weaver caresses the golden threads, entwining fates. The Chrysos Heir that bears the "Romance" Coreflame gathered the world''s heroes, leading them on a long journey once more —to topple the gods, reclaim the divine flame, and grand rebirth to the nearly fallen Amphoreus.

In that holy city kissed by the dawn, the weaver caresses the golden threads, entwining fates. The Chrysos Heir that bears the "Romance" Coreflame gathered the world''s heroes, leading them on a long journey once more — to topple the gods, reclaim the divine flame, and grant rebirth to the nearly fallen Amphoreus.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Aglaea%2FLore',
  biography_es = 'Años después, cuando de manera inesperada encuentra una prenda que tejió en su juventud, la ternura emana de la seda, sacudiendo suavemente su corazón que llevaba tanto tiempo en silencio.

En la familia consagrada a Mnestia, a cada miembro, desde su juventud, se le enseñaba el arte de la belleza. Los retratos de los grandes maestros cuelgan en la pared de honor del baño privado, vigilando siempre a su descendencia. Mientras muchos se quedan sin habla bajo el escrutinio de esos maestros, ella se mueve con una gracia tan natural que parece no esforzarse bajo su mirada. "La pintura sucumbe a la falsedad, la música a la abstracción, la escultura a la pesadez, y el drama a lo mundano...". Los ancianos mostraban signos claros de derrota, pero su voz, joven y resuelta, acallaba cualquier objeción. "Pequeña Aglaea, ¿hay algo más bello que esto?". Saliendo del baño, danza de puntillas hasta el espejo. Su cabello dorado y pálido caía como una cascada. "No".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Aglaea',
  biography_es_translated = false
where id = 'hsr-aglaea';
update public.characters set
  biography_en = 'The Grove of Epiphany, where knowledge flourishes and philosophers are born. Yet here stands Anaxagoras the blasphemer, the Chrysos Heir who challenges the Coreflame of Reason. He is questioned: Would you defy the prophecy even if you must bear infamy, and insist on driving the thorns of doubt into the Sacred Tree of wisdom? ——"Ridiculous. In a world full of lies, I am the only truth."',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Anaxa%2FLore',
  biography_es = '"Ah, naciste en una polis lejana. Tus padres fallecieron muy pronto. Te quedaste solo con tu hermana mayor y vivían del poco dinero que ganaba domesticando animales. Eras solitario desde pequeño. Cuando los niños de tu edad estaban jugando en los campos, tú te escondías detrás de un árbol y recogías las hojas que habían caído.

"¿Por qué los dromas no pueden volar?", murmuras mientras observas al droma que creció a tu lado. "¡Es porque en su vida anterior era un ratón de biblioteca como tú!". Has oído esta frase muchas veces, pero nunca entendiste por qué se usaba como burla.

"Si los dioses son omnipotentes, ¿por qué temen a la muerte?". En el templo donde se leen las enseñanzas sagradas, las cosas que deberían ser incuestionables te hacen dudar. "¡Lárgate, Anaxágoras!". Los sacerdotes enfurecidos a menudo te echaban del templo.

Tu hermana nunca te culpaba. En lugar de eso, empleaba una parte de sus escasos ingresos para comprarte los libros y las herramientas que tanto anhelabas.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Anaxa',
  biography_es_translated = false
where id = 'hsr-anaxa';
update public.characters set
  biography_en = 'Despair plays in cycles between the past and future. Countless ideals were incinerated before that red garment. Yet, do not let this smear of ashes fool you — Should someone create a phantasmal sweet dream under the guise of false ideals, then he will burn again, facing down the hypocrites of the world till the very end. No matter where he is, he always remains the steadfast champion of justice.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Archer%2FLore',
  biography_es = 'Como regla general, es un hombre racional, capaz de mantener la calma y completar su trabajo. Pero, igual que ciertos empleados veteranos, a veces no puede evitar mostrar una visión pesimista de la vida, que se manifiesta en forma de desprecio hacia sí mismo. Por eso, a menudo dice cosas que pueden parecer duras.

"No, eso no es del todo cierto". "La mayoría de la gente no puede deshacerse del desprecio que sienten por sí mismas a medida que maduran, porque no pueden luchar contra su yo del pasado". "Pero luchar no siempre es la solución". "... Mejor olvidemos este tema".

En resumen, siempre que evite cruzarse con su versión más inmadura del pasado o con alguien que se le parezca demasiado, este hombre demuestra ser un Servant excepcionalmente estable y maduro. Aunque a menudo se queja de las responsabilidades que tiene ahora, lleva a cabo cada tarea con absoluta entrega y atención meticulosa.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Archer',
  biography_es_translated = false
where id = 'hsr-archer';
update public.characters set
  biography_en = 'A paragon knight of the Knights of Beauty who is piously seeking his missing Aeon, Idrila the Beauty. Forthright and candid, he wanders the cosmos espousing the virtues of Idrila''s good name.

A paragon knight of the Knights of Beauty. He embodies righteousness and honor, possessing an admirable nobility. As a solitary wanderer in the cosmos, he wholeheartedly embraces the principles of "Beauty." Upholding the honor of beauty in the universe has been Argenti''s sacred duty. From the very beginning, he approached this duty with piety and unwavering conviction.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Argenti%2FLore',
  biography_es = 'La guerra arrasó con su hogar por años, y los horrores del derramamiento de sangre y los incesantes bombardeos contaminaron sus recuerdos de la infancia. En medio del caos, buscó refugio bajo tierra y por suerte encontró una ocarina debajo de una baldosa de piedra. Con sus manos temblorosas, trató de tocar una melodía con el instrumento. Sin embargo, su "música" era horrible.

Sí, las notas etéreas que emanaban de su ocarina se convirtieron en su santuario, un escape espiritual de la cruda realidad.

Con el tiempo, los acordes melódicos se desvanecieron en los huecos de su memoria y se convirtieron en un momento misterioso y escurridizo. Años después, durante una gira de los bardos, cuando salvó a un niño de las llamas de la guerra y recibió una preciosa ocarina en forma de agradecimiento, las melodías de su pasado regresaron. Al sostener el bellísimo instrumento en sus manos, examinó su impecable y noble fabricación.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Argenti',
  biography_es_translated = false
where id = 'hsr-argenti';
update public.characters set
  biography_en = 'The head of Herta Space Station''s Security Department. This quiet boy hopes to protect the researchers who value their pursuit of knowledge, and to help them to complete their work.

The inarticulate head of the Security Department. While scientific research is beyond his understanding, Arlan is willing to risk his life to protect the staff who value research so very much. He is used to pain and wears his scars like badges of honor. Only when holding Peppy does the boy let down his guard and show a rare smile.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Arlan%2FLore',
  biography_es = '¿Cómo se puede evaluar el trabajo de seguridad de Arlan? -Es el faro que guía al Departamento de Seguridad; ¡el núcleo en el que se apoyan todos! Sin él, la Estación Espacial se desmoronaría en un día; sin él, la vida de la gente se arruinaría en diez días; ¡sin él, la estación sería un infierno en solo cien días! -Pero juega al holodisco volador con Peppy en horas de trabajo. -Porque termina todas las tareas diarias de seguridad antes de lo previsto. Su mera presencia es una inspiración para todos nosotros. -Pero juega al holodisco volador con Peppy durante las horas de trabajo. -¿Cómo sabes que jugar al holodisco con Peppy no forma parte de su trabajo?

"No está permitido mirar el teléfono mientras estás de patrulla. Dámelo". "Arlan, la gente está hablando mal de ti en el chat. ¿No te importa?". "No, estoy demasiado ocupado". "¿Eh? ¿Tienes una misión urgente? Déjame ir contigo. ¿Qué pasó?". "Voy a llevar a Peppy al veterinario y luego jugaremos al holodisco volador".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Arlan',
  biography_es_translated = false
where id = 'hsr-arlan';
update public.characters set
  biography_en = 'The lead researcher of Herta Space Station and a lady from a renowned family. She''s an astronomer overflowing with curiosity, and excels at managing the disparate staff of the space station.

A fiercely inquisitive and energetic young girl. She is the Lead Researcher of the . Whether it is managing opinionated staff, or courteously but firmly responding to the Intelligentsia Guild''s devious demands, Asta handles it all effortlessly. After all... commanding a space station is much easier than taking over the family business!',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Asta%2FLore',
  biography_es = 'Cuando aún era pequeña y empezaba a elegir su propio telescopio, Asta oía a menudo los débiles murmullos de los ancianos alabándola. Estaba bastante orgullosa de eso, porque era capaz de distinguir el artesano y el sistema de guía astral de cada telescopio con un simple vistazo. No fue hasta un día que se puso más cerca cuando se enteró de que en realidad se burlaban de ella: ¿cómo podía una niña tan pequeña querer un objeto tan extremadamente caro? Las aficiones personales no existían a los ojos de esa gente. Lo único que veían era una princesita mimada. "¿Te gustan las estrellas? Oh, lo entiendo, cariño. Te gustan las cosas brillantes, ¿no?". "Eh... Bueno, sí. Ahora mismo estoy investigando protoestrellas, y espero descubrir algún día un nuevo sistema estelar. Le pondré mi nombre... Como aquellos famosos astrónomos de antaño". "¿Eso es todo? Podemos ponerle tu nombre a un planeta por tu cumpleaños. ¿O qué tal dos? En realidad, es bastante barato". "..." "Oye, ¿a dónde vas? ¡Asta!".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Asta',
  biography_es_translated = false
where id = 'hsr-asta';
update public.characters set
  biography_en = 'A high-ranking executive of the IPC''s Strategic Investment Department. A risk-taker, his constant smile makes it difficult for people to discern his true feelings.

Senior manager of the Strategic Investment Department at the IPC and one of the Ten Stonehearts. His Cornerstone is the "aventurine of stratagems." An ostentatious risk-taker, he often wears a smile that masks his true motives. He won his current position by wagering against fate itself. He views life as a high-stakes, high-return investment, and he plays this particular gamble with masterful ease.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Aventurine%2FLore',
  biography_es = '"Tengo algo de que informarte sobre el nuevo empleado".

"¿Por qué estás tan preocupado, Erwin?".

"Son quejas sobre él, tanto formales como informales. Están inundando mi buzón como trozos de papel infinitos. Me pregunto... si vale la pena reconsiderar su inclusión en el Departamento de Inversiones Estratégicas".

"¿Qué dicen esas quejas?".

"Principalmente sobre sus orígenes. Esos ojos suyos...". "Una vez engañaron al Departamento de Desarrollo de Mercados afirmando falsamente que había fuentes de energía ocultas en la tierra estéril de Sigonia, aún no desarrolladas ni utilizadas eficazmente. Invertimos una enorme cantidad de fondos en su excavación para darnos cuenta de que todo era una estafa". "Y luego está el tristemente célebre «Caso de Aventurino Egyhazo». Engañó a la Sociedad del Conocimiento haciéndole creer que los restos de Tayzzyronth el Imperator Insectorum estaban enterrados allí.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Aventurino',
  biography_es_translated = false
where id = 'hsr-aventurine';
update public.characters set
  biography_en = 'The High Elder of the Vidyadhara, who is also known as the "Healer Lady" on the Luofu. She uses her unique medical science and the medical treatment that can only be provided by the Vidyadhara dragon race to save lives.

A vivacious young lady of the Vidyadhara race, she is known as the "Healer Lady" due to her expertise with medicine. She often dishes out unorthodox prescriptions such as "Stay well hydrated" and "Get a good night''s rest." Bailu cannot bear to see people suffer, and that''s why you''ll see her with her eyes shut tightly as she cures ailments. "As long as they''re cured, that''s all that matters, right?"',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Bailu%2FLore',
  biography_es = '"Recopilación de casos y tratamientos de la Comisión de Alquimia, volumen 48, caso de estudio 1246

Doctora encargada: Bailu.

Paciente: Yuezhui, mujer raposiana de sesenta y dos años.

Afección: Por accidente, comió un dulce de chocolate que le vendió un comerciante foráneo. Experimentó una sed extrema por la que tomó agua en exceso; mucho dolor, en particular en el estómago; dificultad para respirar y pérdida de mechones de la cola.

Diagnóstico: Intoxicación alimentaria.

Receta: 1 mas de ginseng amargo, 1 mas y 1 condrín de regaliz crudo, 1 botella de elixir de jade de cinco granos y una copia del folleto «Lo que debe saber de los alimentos prohibidos».

Instrucciones: Hervir el ginseng amargo y el regaliz crudo en el elixir de jade de cinco granos hasta que se reduzca a la mitad, colar para eliminar los restos, beber hasta que vomite.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Bailu',
  biography_es_translated = false
where id = 'hsr-bailu';
update public.characters set
  biography_en = 'A Memokeeper of the Garden of Recollection. An indolent and mysterious soothsayer. "Remembrance" of men are hers to heed, threads of fate are hers to tug.

A Memokeeper of the Garden of Recollection. A mysterious and elegant soothsayer. She often wears a warm smile and is willing to patiently listen to the words of others, thus using such means as a pretext to enter "memories" and gain omniscience over certain matters. A lady passionate about collecting unique memories, yet the thoughts that guide her are hard to glean.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Black%20Swan%2FLore',
  biography_es = '"Es una niña inusual, y lo supe desde el día en que nació. Parecía como si la naturaleza celebrara su llegada: los pájaros cantaban y la luna y el sol se unieron en el cielo. Las cartas en mi mano parecían insinuar el surgimiento de un alma impregnada de nostalgia. Desde temprana edad, le fascinaban las historias del pasado. Se quedaba absorta pensando en nuestros orígenes, nuestros creadores e incluso el mismísimo inicio del mundo. Sus preguntas harían que hasta los eruditos más estudiosos se rascaran la cabeza. Sí, algunos niños la molestaban por hacer preguntas tan profundas, pero ¿acaso no son preguntas importantes? La vida es similar a un laberinto serpenteante donde los recuerdos son lo único que nos acompaña". — Los recuerdos de una madre

Su madre tenía amnesia y olvidaba muchas cosas, lo que le dificultaba reconocer a su familia o recordar eventos recientes. Aferrada al diagnóstico de la amnesia, abrazó con fuerza a su madre tratando de leerle en voz alta su último diario.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Cisne%20Negro',
  biography_es_translated = false
where id = 'hsr-black-swan';
update public.characters set
  biography_en = 'A member of the Stellaron Hunters, and a swordsman who abandoned his body to become a blade. Pledges loyalty to "Destiny''s Slave," and possesses a terrifying self-healing ability.

A swordsman who abandoned his body to become a blade. Birth name unknown. He pledges loyalty to "Destiny''s Slave," and possesses a terrifying self-healing ability. Blade wields an ancient sword riddled with cracks, just like his body and his mind.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Blade%2FLore',
  biography_es = 'Lo único que percibió fue una mancha carmesí en los ojos y un sabor metálico en la boca. Sus extremidades no respondían.
Debía estar muerto.

"¿Ya lo has aprendido?".
Abrió la boca, perdido, con la voz tan ronca como la de una bestia salvaje.
Su garganta dejó de emitir sonidos abruptamente, tan pronto como el objeto frío y duro perforó su torso.
Una y otra y otra vez, el proceso se repitió mil veces.

Maravilloso. Mientras sus fibras musculares se desgarraban, oía el sutil sonido que producían los tendones al unirse y conectarse de nuevo.
Qué maravilla. El monstruo dentro de su cuerpo se alimentaba, pero quería más, quería convertirse en una bestia enorme.
¡Qué maravilla! Ya había perdido toda voluntad de sobrevivir, pero aun así su cuerpo se regeneraba solo.
Simplemente maravilloso.

Antes de que la espada perforara una vez más su piel, la agarró con las manos desnudas y se incorporó lentamente.
"¿Ya lo has aprendido?".
Se encontró con los ojos de la mujer, rojos como la sangre.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Blade',
  biography_es_translated = false
where id = 'hsr-blade';
update public.characters set
  biography_en = 'A cyborg cowboy drifting among the stars. Extremely optimistic and unrestrained. He is a member of the Galaxy Rangers who swore to punish the wretched by any and all means... His flamboyant and brash actions were all to draw the attention of the Interastral Peace Corporation — the target of his revenge.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Boothill%2FLore',
  biography_es = '"¡Graey, hay un niño ahí en la nieve!". Graey y Nick se acercaron con cautela y levantaron al niño, que tenía la cara toda roja y lloraba sin cesar. El niño tenía un nombre llamativo y bonito que en la antigua lengua de Aeragan-Epharshel significaba "arma cargada".

Creció con el amor y la protección de Graey y Nick, mientras jugaba alegremente con sus hermanos. Aunque todos venían de lugares diferentes, ahora pertenecían a este vasto continente llamado "Aeragan-Epharshel". Graey lo llevó a conocer las plantas, los animales y los ríos. Nick le enseñó a domar caballos y a criar ovejas. Ya de muy joven, montaba su potro sobre los arroyos y seguía a Nick cuando trasladaban su ganado a los campos ricos en agua y verdor bajo el sol pleno de la mañana. Nick siempre cantaba a viva voz cuando la luz brillaba sobre las grandes nubes. Cuando lo escuchaba cantar, abría la boca y se ponía a cantar también, con voz clara y nítida.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Boothill',
  biography_es_translated = false
where id = 'hsr-boothill';
update public.characters set
  biography_en = 'Heir apparent to the Supreme Guardian of Belobog. She possesses pride befitting of a princess, but also the determination and integrity of a soldier.

Heir to the Supreme Guardian of Belobog, she is the young and capable commander of the Silvermane Guards. Bronya received a rigorous education from an early age, and as such, possesses the grace and affinity as expected of an heir. However, after witnessing the abysmal conditions in the Underworld, seeds of doubt begin growing in the mind of Belobog''s future leader. "Can all the training I''ve received really help me lead the people to the lives they want?"',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Bronya%2FLore',
  biography_es = 'Aprendió a ocultar sus pensamientos desde una edad temprana. Todos los días recorría los mismos caminos con los demás niños, jugaba a los mismos juegos y chismeaba de las mismas cosas. Pero nunca se sintió abrumada por la naturaleza trivial y anodina de la vida: cada vez que estaba sola, se sentaba en su banco de piedra blancuzca, mirando al cielo e imaginándoselo perfecto y completo, sin la obstrucción de ese disco plano. Veía a los jornaleros chorreando sudor, sus ansias de vivir aplastadas por la presión de la supervivencia. Al ver la mirada cansada, pero sincera de sus ojos, se sumió en la confusión. ¿La vida de veras tiene que ser así? Igual que la inmensidad del cielo fue diseccionada por aquel monstruoso disco de acero, quizás la libertad que ella anhelaba también estaba destinada a ser incompleta. Luchó por salir de ese atolladero, grabando en silencio en aquel camino de piedra polvoriento los ideales que llegaría a implantar en su vida. "Hacer del mundo un lugar mejor".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Bronya',
  biography_es_translated = false
where id = 'hsr-bronya';
update public.characters set
  biography_en = 'Aidonia, the snowy land that respects and worships death, has already sunken into sweet slumber. O Castorice, daughter of the River of Souls, the Chrysos Heir in search of the Coreflame of "Death," set forth! Guard the lament of the souls in this world, and embrace the solitude of destiny. — Life and death is a journey. When a butterfly rests on that dead branch, the withered will be reborn again.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Castorice%2FLore',
  biography_es = 'Desde que tiene uso de razón, la nieve en Aidonia siempre ha estado ahí. Es como si el tiempo se hubiera congelado en esta tierra blanca y silenciosa. De pequeña, le preguntó a Amunet qué era la nieve. Amunet respondió que era la alegría y la tristeza de la vida mortal.

Siempre permanecía ensimismada, con la mirada fija en la gente de la polis. Cada día, el guerrero bajito iba a entrenar ante las puertas del templo, el sacerdote de mediana edad cabeceaba ocasionalmente bajo la alta torre, y el erudito asceta repartía galletas de sereniflor a los niños. En la lejanía, los críos se empujaban y reían en una batalla de bolas de nieve. Sus risas caían sobre su corazón como frutos maduros. Desde la torre, intentaba distinguir sus rostros, pero siempre fracasaba.

La Doncella Sagrada. Así es como la llamaban cuando aparecía ante la gente, y nadie se atrevía a mirarla a los ojos. Cuando ella se acercaba con valentía, todos retrocedían un paso y bajaban la mirada.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Castorice',
  biography_es_translated = false
where id = 'hsr-castorice';
update public.characters set
  biography_en = 'The Northern Empire, a lost dynasty, where its frozen lands burn with the fever of conquest. Sovereign Cerydra, the Chrysos Heir who wields the Coreflame of "Law," weaves her schemes, contends with the gods, passes judgment upon the faithless, and lays the foundation of Flame-Chase into this world. ..."This is far from the end. Amphoreus''s journey is set to blaze across the stars!"',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Cerydra%2FLore',
  biography_es = 'El Imperio del Norte, Hiperión. Unas tierras gélidas que arden con ambiciones insaciables. Desde la caída del monarca sin herederos, el trono vacante ha dejado al imperio fragmentado en una interminable guerra civil.

Los refugiados que han perdido sus hogares recurren a la mendicidad para sobrevivir. Una niña herida, de inusual cabello azul, resalta con fuerza sobre la nieve inmaculada. "Solo aquellos que pertenecen a la realeza bendecida por Talanton poseen ese cabello azul que ondea como las llamas, y solo los elegidos por el cielo tienen sangre dorada corriendo por sus venas...". Con una mirada fugaz, un noble ambicioso acoge a la niña mendiga y comienza a esparcir rumores sobre una princesa perdida.

La llevan a un magnífico estrado donde el noble alza su brazo. De la punta de su dedo herido gotea una sangre tan dorada como el amanecer.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/C%C3%A9ridra',
  biography_es_translated = false
where id = 'hsr-cerydra';
update public.characters set
  biography_en = 'In the fallen city of bandits, Dolos, the 300 Rogues run wild and free. Race onward, fleet-footed Thief Star Cifera, Chrysos Heir of the "Trickery" Coreflame. May your web of lies spread with the breeze throughout all lands— "Tryna trick me? Not a chance!"',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Cipher%2FLore',
  biography_es = '"Al final del Mes del Tejido, el templo perdió unos panes, una bolsa de frutos secos y varias velas. Aunque estos objetos no son de gran valor, profanar lo sagrado y perturbar el orden son crímenes graves. Tras una investigación, se descubrió que la sospechosa es una chica delgada, con pelo gris y orejas de gato. Es muy ágil y astuta, por lo que se recomienda tener cuidado. Se ofrece una recompensa de 5000 por pistas y una de 10 000 a quien la atrape viva".

Cartel de "Se busca" en la ciudad de Doros

"¡Atrápenla, atrápenla!". Los latigazos y los gritos resuenan en la plaza llena de cárceles que apesta a aguas residuales. Una joven vestida con harapos sale disparada de entre la multitud, dejando un rastro de sangre dorada a su paso.

Pasa corriendo por una plataforma donde un sacerdote corpulento está dando un sermón a los creyentes de la ciudad. "Por Kefale, alabemos y demos gracias por este mundo maravilloso".

"Integridad, sinceridad, perdón...".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/C%C3%ADfer',
  biography_es_translated = false
where id = 'hsr-cipher';
update public.characters set
  biography_en = 'A vagrant girl who lives with robots. She is introverted, gentle, and has a pure heart. She wishes for all Underworlders to become a family.

A young girl raised by a robot. Her perceptiveness and tenacity are far beyond her years. For Clara, Svarog''s logical calculations are the laws of the world and are infallible. That is, until she realizes that the results from the calculations don''t always necessarily bring joy to everyone. The once shy little girl then decides to cast aside her timidness.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Clara%2FLore',
  biography_es = '"Registro ████/██/██ Era de la Fortificación". "Encontramos una niña pequeña en un vertedero al sureste de Villarroca". "El escáner mostró que la niña no tenía daños estructurales ni disfunciones, pero su estado mental era relativamente inestable. Se resistía a las preguntas sobre su estado y claramente quería evitar el tema". "Continuamos con los intentos de comunicación y logramos obtener alguna información". "La niña comenzó a llorar, lo que duró tres horas y siete minutos". "La niña se llama Clara, y su origen es desconocido". "Conclusión: Llevarla de vuelta a la base para observarla, y recoger más información para generar un plan de seguimiento para atenderla."',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Clara',
  biography_es_translated = false
where id = 'hsr-clara';
update public.characters set
  biography_en = 'A meteor streaks across the night sky, stirring ripples in the river of life, shimmering with thirteen hues. Daughter of Aedes Elysiae, nurturer of the Chrysos Heir of "███," plants the Seed of Memory, letting yesterday''s flowers bloom in tomorrow —"Now, let''s write a different kind of poem together♪"

A meteor streaks across the night sky, sending ripples through the river of life, gleaming in thirteen hues. Daughter of Aedes Elysiae, Chrysos Heir who nourishes "██," sow the Seed of Memory, so that flowers of the past may bloom in tomorrow. "Now, let''s write a different kind of poem together ♪"',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Cyrene%2FLore',
  biography_es = 'Un meteoro surca el cielo nocturno y agita el río de la vida, reluciendo con trece tonalidades distintas. Hija de Aedes Elysiae y nodriza de la Heredera de Crisos de "███", siembra la Semilla del Recuerdo para que las flores de ayer broten en el mañana. "Y ahora, escribamos juntos un poema diferente♪".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/wiki/Cyrene%2FLore',
  biography_es_translated = true
where id = 'hsr-cyrene';
update public.characters set
  biography_en = 'A cold and reserved young man who is reticent about his past. To avoid his kin, he decided to travel with the Astral Express.

A cold and reserved young man who wields a spear known as Cloud-Piercer. He acts as the Express'' guard on its long trailblazing expedition. Dan Heng never talks much about his past. In fact, he joined the Express Crew to escape from a past of his own making. But can the Express really help him outrun his past?',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Dan%20Heng%2FLore',
  biography_es = 'Comienza un nuevo día. No es más que otro día extremadamente normal a bordo de esta gigantesca nave. Los mercados ya abrieron, y el rocío de la mañana aún está fresco. Sin embargo, el joven que cruza la calle no había visto nunca semejante espectáculo. Incluso antes de arreglárselas para notar todas las diferencias entre la ciudad real y la descripción del libro, ya está disfrutando del calor del sol en la nuca. Era la primera vez que veía su propio cuerpo con claridad. Este cuerpo que le pertenece, el cuerpo que pertenece a este nombre actual. Cuando llegó al puerto, el soldado que lo escoltaba le quitó los últimos grilletes. Caminó hacia adelante sin mirar atrás. Podía sentir, muy débilmente, varios transeúntes, mirándolo llenos de odio. No fue hasta que la nave espacial despegó que volvió la cabeza y echó un último vistazo atrás. Realmente era una nave espacial magníficamente grandiosa, tal como decía el libro.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Dan%20Heng',
  biography_es_translated = false
where id = 'hsr-dan-heng';
update public.characters set
  biography_en = 'Member of the Intelligentsia Guild. Eccentric temperament, sharp-tongued but with an elegant demeanor. The face under the strange alabaster head sculpture is apparently unexpectedly handsome.

A candid and self-assured Intelligentsia Guild member, who often conceals his appearance with a strange plaster sculpture. He demonstrated unparalleled intelligence and talent since his youth, but now refers to himself as a "Mundanite." Firmly believing that intellect and creativity are not confined to geniuses, he seeks to distribute knowledge to the entire universe to cure the persistent disease named ignorance.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Dr.%20Ratio%2FLore',
  biography_es = 'Veritas Ratio, que se hace llamar "Dr. Ratio", es tan controvertido como sus investigaciones. Existen al menos ocho documentales sobre las legendarias hazañas de Ratio y más de una docena de memorias sobre él en su mundo natal. Hay numerosos comentarios, pero ninguno de ellos ofrece un punto de vista persuasivo. Para llenar ese vacío, visité al profesor Rond, que ejerció una gran influencia en la juventud de Ratio. El profesor Rond tenía dificultades para hablar debido a su avanzada edad, pero no pudo contener su emoción al mencionar el nombre de Ratio. Con la ayuda de su familia y sus alumnos, conseguí una carta de recomendación amarillenta pero bien conservada.

 "Al respetado comité de admisión de la Universidad de Veritas Prime:

Soy Rond, Profesor Emérito del Departamento de Matemáticas de la Universidad Galáctica Libre.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Dr.%20Ratio',
  biography_es_translated = false
where id = 'hsr-dr-ratio';
update public.characters set
  biography_en = 'In the Memory Zone secluded from the world, candlelight reflects the past, silently extinguishing in the mist. Evernight, child of Remembrance emerging from those shadows, the Chrysos Heir who conceals the Coreflame of "Time," raises the waves of "Oblivion" to protect the wishes of those in the mirror "Don''t worry, I will guard the path of Trailblaze for you... at any cost. ♭"',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Evernight%2FLore',
  biography_es = '"Querida Siete de Marzo:

Verte es como ver los primeros rayos del amanecer, me llena de expectación. Quizás fui demasiado impaciente al aparecer así ante ti, pero por suerte las feromonas te hicieron creer que no era más que una ilusión.

La última vez que estuvimos así de cerca fue cuando intentabas explorar el pasado. Comparado con ese momento, parece que has madurado un poco más. Tú y tus compañeros —(Trazacaminos), Dan Heng, Himeko, Welt y ese caballeroso amigo— lucharon juntos en perfecta sincronía... ♭ Incluso a mí me costó un poco de esfuerzo enfrentarme a semejante grupo. ♭

La memoria es algo maravilloso... Sin que nos hayamos dado cuenta, tu viaje ya lleva mucho tiempo en curso.

Aún recuerdo los innumerables ojos avariciosos que, tras las estrellas titilantes, espiaban este cuerpo y codiciaban este secreto.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Larganoche',
  biography_es_translated = false
where id = 'hsr-evernight';
update public.characters set
  biography_en = 'The Xianzhou Yaoqing''s Merlin''s Claw and one of the Seven Arbiter-Generals. Unconventional and straightforward, she exudes effortless charm. She is skilled in all forms of martial arts and has honed herself into a supreme weapon. She is widely adored by Xianzhou soldiers and civilians alike as "The Vanquishing General." However, she bears the burden of the Moon Rage affliction. If she were to hunt down all the abominations in her limited lifetime — then the only enemy Feixiao has would be herself.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Feixiao%2FLore',
  biography_es = 'Un atisbo de sangre y malestar flota en el aire.

"Neergul...". Ella da unas suaves palmaditas a su temblorosa acompañante, "Presiento... Una oportunidad de libertad. Esta noche es la noche". "Saran, los cuerpos de los tres esclavos raposianos que intentaron escapar siguen colgados en las puertas...". "No, esta noche es diferente". Levanta la cabeza y mira a lo lejos mientras una luz gigante recorre lentamente el cielo. "Esta noche, habrá estrellas fugaces". Toma la mano de su acompañante. "Está bien. Solo sigue mirando hacia adelante y no mires atrás".

Bajo la luz fría y brillante de las estrellas fugaces, dos delicadas siluetas corren por las interminables llanuras. El aire ensangrentado azota sus rostros mientras los escalofriantes aullidos de los lobos despiertan sin cesar el miedo enterrado profundamente en su sangre. Sin embargo, ella nunca dudó de que escaparían de la persecución de la manada borisin.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Feixiao',
  biography_es_translated = false
where id = 'hsr-feixiao';
update public.characters set
  biography_en = 'A member of the Stellaron Hunters, clad in a set of mechanized armor known as "SAM." Her character is marked by unwavering loyalty and steely resolve. Engineered as a weapon against the Swarm, she experiences accelerated growth, but a tragically shortened lifespan. She joined the Stellaron Hunters in a quest for a chance at "life," seeking to defy her fated demise.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Firefly%2FLore',
  biography_es = 'Miembro de los Cazadores de Estelaron, cubierta por una armadura mecanizada conocida como "SAM". La definen una lealtad inquebrantable y una determinación de acero. Concebida como arma contra el Enjambre, experimenta un crecimiento acelerado a cambio de una vida trágicamente corta. Se unió a los Cazadores de Estelaron buscando una oportunidad de "vivir" y desafiar así el final que tiene escrito.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/wiki/Firefly%2FLore',
  biography_es_translated = true
where id = 'hsr-firefly';
update public.characters set
  biography_en = 'Head of the Divination Commission on the Luofu. The person who uses the third eye and Matrix of Prescience to foretell the route of Xianzhou and the outcomes of events.

The head of the Xianzhou Luofu''s Divination Commission and a confident, no-nonsense sage. Using her third eye and the Matrix of Prescience, Fu Xuan calculates the Xianzhou''s navigational route and predicts the fortune of future events. She firmly believes that everything she does is the "best solution" for the situation. Fu Xuan is waiting for the general''s promised "abdication." However, that day still seems... very far away.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Fu%20Xuan%2FLore',
  biography_es = 'Años después, Fu Xuan siempre recordaría el día en que le permitieron entrar en la biblioteca para hacer preguntas.

"¿En qué piensas?". Un anciano ciego con gafas oscuras y un bastón en la mano movía los ojos de un lado a otro esperando su respuesta.

"¿Todas nuestras decisiones están predeterminadas? Entonces, si mis cálculos hubieran sido más precisos en ese momento, incluso solo una millonésima más precisos, ¿podría haber tomado la decisión correcta para que no tuvieran que marcharse?". La joven entrecerró los ojos, aparentemente preguntando y respondiéndose ella misma.

"En todo momento estamos en el centro de un laberinto trazado por nuestras propias huellas". El anciano ciego golpeó ligeramente el suelo con su bastón. "No puedo darte las respuestas. Solo puedo darte las preguntas... y la capacidad de ver el problema. Teniendo en cuenta el viaje que te trajo aquí, lo que buscas probablemente no es una respuesta".

"Entonces dame el "ojo".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Fu%20Xuan',
  biography_es_translated = false
where id = 'hsr-fu-xuan';
update public.characters set
  biography_en = 'A tactful foxian girl, whose appearance, name, and identity have all been stolen. The fates have left her a thread of chance at survival, yet the brand of Destruction still writhes with anticipation. The one in a fugue who has experienced life and death and is given a new life... when would she be able to return home?

The former chief representative of the Whistling Flames merchant guild in the Sky-Faring Commission who nearly lost her life in a strange and catastrophic incident on her return journey. Her face, name, and identity were stolen by the one who orchestrated it all. Yet, by a twist of fate, a sliver of hope remained, and from the aftermath of the Destruction, she reclaimed her life. Now, she goes by the name "Fugue." Whether it be the bitterness of never returning home or the allure of wandering through the starry seas that drives her, one thing is certain — she has risen once more and set out on her path anew.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Fugue%2FLore',
  biography_es = 'El brazalete de jade que una vez la protegió yacía hecho añicos, la campana de bendición había caído al barro, y el abanico plegable vibrantemente adornado se había hecho cenizas. Solo podía observar cómo el fuego fantasmal de la oscuridad consumía todo lo que había poseído, reduciéndolo a llamas y ruinas.

Por un momento, solo se lamentó por quedarse a un paso por detrás de la vida. "Acabo de cerrar un gran trato con ese comerciante itinerante... Una oportunidad desperdiciada...". "Todo ese esfuerzo por esta cola tan bien cuidada, ahora se reduce a nada...". "Ni siquiera podré cumplir mi promesa... de llevarles regalos a todos...". Un millar de pensamientos se agolpaban en su mente, pero su cuerpo permanecía quieto, inmóvil, mientras las lágrimas se acumulaban silenciosamente en las comisuras de sus ojos.

Los recuerdos parpadeaban y se apagaban como la luz de una vela moribunda. "Cuánto desearía ver a la señora Yukong surcando el cielo con el arco que le compré...',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Fugue',
  biography_es_translated = false
where id = 'hsr-fugue';
update public.characters set
  biography_en = 'A security officer of the Bloodhound Family at Penacony. He is always courteous toward visiting guests but keeps his vigilance about him. He seems to carry a weight of a complicated past, yet he never voluntarily divulges any details.

A security officer from the Bloodhound Family in Penacony. He is also a slovenly and indolent drinksmith. Though unorganized in apparel and casual in how he makes his drinks, he is always courteous toward visiting guests but keeps his vigilance about him. He seems to carry a weight of a complicated past, yet he never voluntarily divulges any details.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Gallagher%2FLore',
  biography_es = '"Olor a tabaco, caramelos y champú barato... Desprende el típico olor de un soltero de mediana edad. Aunque su ropa es pulcra, siempre está arrugada y muestra falta de estilo. Tampoco demuestra interés alguno en cuidar de su aspecto. No tiene muchos amigos, y su pasatiempo favorito después del trabajo es disfrutar de unas copas del Especial Dulces Sueños. Siempre se sienta en el mismo sitio, con la misma bebida y con los mismos camareros... Nunca ha cambiado en más de una década.

Aun así es un hombre que se ganó la admiración y el respeto de los miembros de la familia Sabueso, lo que probablemente esté relacionado con esa cicatriz grabada en su rostro. En un dulce sueño prácticamente desprovisto de accidentes, una fea cicatriz es un raro honor para un oficial de seguridad, símbolo de antigüedad y prestigio.

Cuando se enfrenta a un caso, lo primero que hace es desenvolver un caramelo y llevárselo a la boca.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Gallagher',
  biography_es_translated = false
where id = 'hsr-gallagher';
update public.characters set
  biography_en = 'A captain in the Silvermane Guards and an outstanding warrior of Belobog. He is meticulous and vigilant to the core and is always true to himself.

The honorable and upstanding captain of the Silvermane Guards who bears the noble Landau family name. In the frost-whipped city of Belobog, life can still go on in normality... This is in no small part thanks to Gepard and his Silvermane Guards who protect the peace of everyday life.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Gepard%2FLore',
  biography_es = 'El joven capitán estaba en lo alto de la muralla norte.

Contempló los páramos blancos que tenía ante sí, y observó a los extraños seres del Fragmentum que formaban un enjambre inquieto en la distancia. Vio a la intrépida Guardia Crinargenta alineada en formación para vigilar la ciudad, como un parapeto defensivo.

Esta era su posición original. Cuando aún era un humilde soldado raso, había jurado ser el escudo más fuerte de Belobog y se comprometió a morir con sus camaradas, incluso como capitán. No se trata de una broma de la Guardia Crinargenta, porque Qlipoth es testigo de este juramento.

Sin embargo, justo en ese momento, no estaba donde debía estar, y todo era por la petición de la Guardiana Suprema.

¿En qué estaba pensando exactamente la Guardiana Suprema? El joven capitán no tenía ni idea, pero pronto se obligó a centrarse en el conflicto que tenía entre manos.

"Recuerda, Gepard Landau". "La duda engendra arrogancia, y la duda engendra maldad.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Gepard',
  biography_es_translated = false
where id = 'hsr-gepard';
update public.characters set
  biography_en = 'The King of Heroes from the dawn of human history, hailing from a world beyond the stars. Possessing a nature two-thirds divine and one-third mortal, he claims a natural-born prerogative to rule over all of creation.

The King of Heroes from the dawn of human history, hailing from a world beyond the stars. Being two-thirds divine and one-third mortal, he claims a natural-born prerogative to rule over all of creation. Today, as ever, his boisterous laughter echoed through the heavens... until a certain goddess and eternal rival dragged him into a foreign realm. Now, he sets forth once more to reclaim all that belongs to a king.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Gilgamesh%2FLore',
  biography_es = 'El Rey de los Héroes de los albores de la historia humana, procedente de un mundo más allá de las estrellas. Con una naturaleza dos tercios divina y un tercio mortal, reclama como derecho de nacimiento el gobierno sobre toda la creación. Hoy, como siempre, su risa estruendosa resonaba por los cielos... hasta que cierta diosa y eterna rival lo arrastró a un reino ajeno. Ahora se pone en marcha de nuevo para reclamar todo aquello que pertenece a un rey.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/wiki/Gilgamesh%2FLore',
  biography_es_translated = true
where id = 'hsr-gilgamesh';
update public.characters set
  biography_en = 'A performance artist visiting the Xianzhou Luofu — in other words, a street performer. She''s chasing a new life on the Luofu when not concerned with food and shelter.

An outworlder who ended up residing on the Xianzhou by accident. She is now a passionate and vivacious street performer. With her real name being Guinevere, Guinaifen is the Xianzhou name given to her by her good friend Sushang. Faced with a whole new life on the Luofu and relying on her adoration of Xianzhou culture, Guinaifen quickly learned skills that would keep her clothed and fed — such as slurping noodles in a handstand, smashing slabs without harming the people it was placed upon, catching bullets with bare hands, and so on.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Guinaifen%2FLore',
  biography_es = 'Hola, hola... ¿Me oyen? ¡Buenas noches, familia! Les doy la bienvenida al directo de la Pequeña Gui...

¡Gracias GranFlor_49886 por el super chat! "Pequeña Gui, hace un par de semanas que no haces ningún directo. ¿Ya no te tomas esto en serio?". ¡De ninguna manera! Estoy pasando por muchas cosas en mi vida en este momento y sí, hace tiempo que no hago ningún directo. Lo siento... De hecho, todo lo que he estado viviendo es bastante interesante. Hablaré de ello en otro momento.

Hoy, como escribí en el título del directo, es la "¡Noche de música! ¡La Pequeña Gui cantará música folclórica de Xianzhou!".

En fin, creo que cosas como las acrobacias es mejor hacerlas fuera de línea, así que en este directo voy a interpretar música folclórica. Solo estoy tanteando el terreno... Si les gusta, ¡recuerden dar me gusta, suscribirse y compartir! Si envían un regalo o un super chat, ¡participarán en el sorteo de premios de este directo!

¡Gracias, MegaMalteada, por el superchat!',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Guinaifen',
  biography_es_translated = false
where id = 'hsr-guinaifen';
update public.characters set
  biography_en = 'One of the judges of the Xianzhou Luofu''s Ten-Lords Commission. Ordained by the Ten-Lords and wielding the authority of the Oracle Brush, she reads the multitudes of human sins and transgressions, then issues punishments and karmic retribution.

One of the judges of the Ten-Lords Commission on the Luofu. She is in charge of "interrogation" among the four judges of detention, interrogation, incarceration, and punishment. She is in charge of discerning the sins of criminals and using her Oracle Brush to write down karmic punishments to be meted out. Since her daily work relies heavily on oneiromancy, she has been constantly struck by a tremendous influx of mara-tainted karmic information and grown detached from worldly matters. Only when in the presence of her sister, Xueyi, does she reveal a glimpse of her tender nature.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Hanya%2FLore',
  biography_es = 'El ataúd colosal, que parece un recipiente desolado perdido en una tormenta, se balancea en medio de las turbulentas corrientes del océano de la consciencia. Olas de ira, añoranza, odio, miedo y cansancio chocan contra ella como aluviones grises, que la empujan de un reino turbulento a otro.

Como un alma ahogada, por fin suelta su individualidad y se diluye en el infinito océano del caos...

Hubo un tiempo en que fue oficial de la Comisión de Administración del Territorio, tenía montañas de deberes mundanos y aspiraba a un ascenso.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Hanya',
  biography_es_translated = false
where id = 'hsr-hanya';
update public.characters set
  biography_en = 'Member 83 of the Genius Society. The real master of the space station. An incredibly intelligent yet unsympathetic scientist.

true master. As the human with the highest IQ on the Blue, she only does what she''s interested in, dropping projects the moment she loses interest — the best example being the space station. She typically appears in the form of a remote-controlled puppet. "It''s about seventy percent similar to how I looked as a child." — Herta',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Herta%2FLore',
  biography_es = 'Los manuscritos de la señora Herta son activos muy valiosos.

Su principal rareza no radica en que la señora Herta apenas se molesta nunca en poner la pluma sobre el papel, sino en que, para una genio como ella, nada es digno de ser conservado por escrito.

Una investigación científica que a los investigadores normales les llevaría diez años, o incluso toda una vida, podría iluminar un ámbito de investigación totalmente nuevo. Pero para Herta, es tan aburrido como una luz LED al azar. ¿Quién perdería el tiempo tratando de registrar sistemáticamente asuntos tan triviales?

No se trata solo de la señora Herta: cualquier trabajo escrito por un miembro del Círculo de Genios es un tesoro de valor incalculable. Sin embargo, Herta es más generosa y comprensiva con la gente normal. Deja sus papeles en lugares aleatorios de la Estación Espacial y permite a los investigadores estudiar los objetos raros que recopiló.

Por supuesto, todos sabemos que no es que la señora Herta sea perezosa.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Herta',
  biography_es_translated = false
where id = 'hsr-herta';
update public.characters set
  biography_en = 'The one who repaired the Astral Express. To witness the vast starry sky, she decided to travel with the Astral Express. Her hobby is brewing hand-made coffee.

An adventurous scientist who encountered the Astral Express as a young woman when it got stranded in her homeworld. Years later, when Himeko finally repaired the Express and began her journey into the stars, she realized that this is only the beginning. On her journey to trailblaze new worlds, she would need many more companions... And while they may have different destinations, they all gaze at the same starry sky.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Himeko%2FLore',
  biography_es = 'Una chica perdida. No recordaba cuándo se había perdido. Simplemente caminó y caminó sin parar en la noche oscura, persiguiendo el sol y la luna, una y otra vez, hasta que se cayó. Recordó cómo se veía cuando inició la universidad. Recordó su especialización elegida, la dinámica de navegación interestelar. Y ahora estaba tendida boca abajo en el barro... Miró las estrellas y, en ese momento, vio meteoros cayendo: uno, dos, tres... Y, luego, otros más pequeños que parpadeaban y destellaban muy levemente antes de que un magnífico resplandor resquebrajara el cielo nocturno. Sus extremidades la arrastraron hacia adelante, hasta donde la tierra se encontraba con el océano. En la costa, las aguas se agitaban contra ella como la marea contra un tren varado, solo y perdido. Entró y vio que el paisaje exterior empezaba a cambiar. El tren le mostró miles de mundos magníficos muy lejos, más allá de su mundo natal, pero lo suficientemente cerca como para poder llegar en tren.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Himeko',
  biography_es_translated = false
where id = 'hsr-himeko';
update public.characters set
  biography_en = 'Boss (self-proclaimed) of an Underworld adventure squad, The Moles. She loves freedom and sees life as a series of adventures.

Head of the adventure squad "The Moles," she calls herself Pitch-Dark Hook the Great. She doesn''t like to be called a "kid" and believes she can handle things herself without any help from adults. Adults adventure into the Fragmentum, Mr. Sampo adventures on the surface, and patients take their risky adventure seeking treatment from Natasha... Under the leadership of Hook, children can also have their own adventures!',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Hook%2FLore',
  biography_es = '"██/██/██ Clima: Bueno Estado de ánimo: Muy malo".

"Hoy rompí uno de los tuvos de ensallo tubos de hensayo tubos de ensayo de la vieja bruja y me gané una buena regañina".

"¡La vieja bruja es terrible! Nunca nos deja jugar después de la comida y nos obliga a dormir la siesta. ¡La odio!".

"¡Debemos revelarnos rebelarnos contra su tiranía! ¡No podemos dejar que sesalga se salga con la suya!".

"Voy a formar un grupo llamado Los Topos, y obligaré secuestraré invitaré a todos los niños de la clínica. ¡Derrocaremos a la vieja bruja! Y luego podremos comer lo que queramos y divertirnos juntos, ¡y nadie podrá detenernos!".

"¡Y yo seré la jefa de Los Topos! ¡Y la jefa de la clínica también! Le daré a esa vieja bruja una buena regañina todos los días, y la obligaré a hacer todas las capeas tareas. ¡Mua, ja, ja!".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Hook',
  biography_es_translated = false
where id = 'hsr-hook';
update public.characters set
  biography_en = 'A trainee Ten-Lords Commission Judge of the Xianzhou Luofu, she is a young foxian girl possessed by a heliobus. She is a timid and weak girl who is afraid of all kinds of strange things, but is responsible for luring and subduing evil spirits.

While this foxian girl may seem fragile and weak, she is actually a judge-in-training of the Ten-Lords Commission, responsible for capturing evil. The judges sealed a heliobus named "Tail" onto her tail, making her a "Cursed One" with a tendency to attract evil beings. Despite trembling at the sight of evil spirits, she is always entrusted with the arduous task of eradicating their presence. She is well aware of her incompetence but lacks the courage to resign, so she forces herself to press on despite her fear.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Huohuo%2FLore',
  biography_es = 'Cuando Huohuo despierta en la Comisión de los Diez Líderes, no se sorprende por estar ahí, sino por la atmósfera escalofriante.

Al ver su inquietud, una jueza de cabello blanco le habla con dulzura.

"Dime, pequeña, ¿cómo atravesaste el fuego?". "... Estaba al borde de la carretera, a punto de extinguirse, entonces yo... quise ayudarlo". "¿Y pusiste ese fuego en tu cola? ¿Por qué lo hiciste?". "No... No lo sé... pasó antes de que me diera cuenta... Lo siento mucho". "No te disculpes, chica de buen corazón. Sin embargo, estarás bajo custodia de ahora en adelante". "Gra-gracias, señorita". "Llámame Hanya". "Ah, gracias, Hanya. Me... me llamo Huohuo".

Los pensamientos de la jueza Hanya volvieron a unos días atrás.

La Comisión de los Diez Líderes había recibido una llamada de auxilio, y ella asumió la tarea de encontrar a la chica raposiana que estaba a punto de ser consumida por el heliobus.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Huohuo',
  biography_es_translated = false
where id = 'hsr-huohuo';
update public.characters set
  biography_en = 'As the city-state in the clouds crumbles through time, the Twilight Courtyard opens its gates once more, bringing a glimmer of light to Evernight. Physician Hyacinthia is the Chrysos Heir who watches over the Coreflame of Sky. Carrying the will of her ancestors, she mends the torn fabric of dusk and dawn. May the rainbow light pour down, dissolve all grudges, and bring the dawn back to this land.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Hyacine%2FLore',
  biography_es = '"Extiende lentamente tus alas... Sí, como hicimos la última vez. Respira profundamente conmigo, ¿de acuerdo?". "Relájate, todo está bien... Sí, las alas se están expandiendo. Estás comiendo mucho, ¿verdad?". La luz de las velas proyectaba un cálido resplandor sobre la suave cabecita mientras la joven levantaba al caballito y lo colocaba con cuidado en la balanza.

"No te preocupes. Pronto serás tan grande y fuerte como las demás bestias aladas, ¿sí?". La joven se colocó los auriculares del estetoscopio y comenzó a realizar un examen completo. Al palpar un lado del caballito, sintió una nueva "herida" debajo de sus costillas. "¿Te lastimaste?".

Acarició con suavidad sus alas y llenó el agujero con algodón antes de sacar una aguja e hilo. "Esto va a doler un poco, pero no te preocupes, mis puntos son firmes". "Has vuelto a entrenar demasiado, ¿verdad? ¿Es porque todos te dicen que tu madre, tu abuela y todos tus antepasados son increíbles?',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Hyacine',
  biography_es_translated = false
where id = 'hsr-hyacine';
update public.characters set
  biography_en = 'Styxia, the coastal city of intoxication and dreams, where echoes of old songs still drift among the waves. Helektra, Daughter of the Sea, Chrysos Heir who cleanses the Ocean''s Coreflame, dispels the murky undercurrents and orchestrates a banquet of revelry for the heroes beyond the sky. The show must go on. Even if hope is as fragile as bubbles, the waves will keep surging forward.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Hysilens%2FLore',
  biography_es = 'Cuando la luz del sol se filtraba a través de la superficie, la respiración del mar se volvía multicolor, siendo este el momento más alegre del día para las sirenas. ♫ Plop ♫ ♫ Pica ♫ ♫ Bum ♫ La princesa de las sirenas persigue alegremente las burbujas, adorando ese instante en que se posan brevemente sobre la punta de su nariz antes de estallar, haciendo que las ondas del agua brillen con los siete colores del arcoíris.

Las sirenas cantaban entre los vastos arrecifes de coral, y las perlas brillantes que allí se encontraban eran perfectas para adornar el arco del violín. La música fluía de los dedos de Hysirenia como una suave corriente de agua, acariciando a sus compañeras que disfrutaban plácidamente del hidromiel.

♫ "Mira, en ese barco brillante y bullicioso, qué felices deben de estar los humanos". ♫ ♫ "Aún anhelas a aquel que salvaste, mientras su voz resuena en lo profundo de tu alma". ♫ ♫ "Noble princesa, despreocupada Hysirenia, ¿a dónde irás?',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Hysilens',
  biography_es_translated = false
where id = 'hsr-hysilens';
update public.characters set
  biography_en = 'Dan Heng''s true form from his Vidyadhara lineage carries the residual power left behind by his past incarnation, the Imbibitor Lunae. Upon accepting the majestic horns atop his crown, he must accept all the merits and faults attributed to that sinner.

Dan Heng''s true Vidyadhara form, revealed after accepting the residual powers from the previous reincarnation of "Imbibitor Lunae." Upon accepting the majestic horned crown atop his forehead, he must accept all the merits and faults attributed to that person. However, he was never himself.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Dan%20Heng%20%E2%80%A2%20Imbibitor%20Lunae%2FLore',
  biography_es = 'Comienza un nuevo día. No es más que otro día extremadamente normal a bordo de esta gigantesca nave. Los mercados ya abrieron, y el rocío de la mañana aún está fresco. Sin embargo, el joven que cruza la calle no había visto nunca semejante espectáculo. Incluso antes de arreglárselas para notar todas las diferencias entre la ciudad real y la descripción del libro, ya está disfrutando del calor del sol en la nuca. Era la primera vez que veía su propio cuerpo con claridad. Este cuerpo que le pertenece, el cuerpo que pertenece a este nombre actual. Cuando llegó al puerto, el soldado que lo escoltaba le quitó los últimos grilletes. Caminó hacia adelante sin mirar atrás. Podía sentir, muy débilmente, varios transeúntes, mirándolo llenos de odio. No fue hasta que la nave espacial despegó que volvió la cabeza y echó un último vistazo atrás. Realmente era una nave espacial magníficamente grandiosa, tal como decía el libro.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Dan%20Heng',
  biography_es_translated = false
where id = 'hsr-imbibitor-lunae';
update public.characters set
  biography_en = 'A senior manager in the IPC Strategic Investment Department and one of the Ten Stonehearts, known for her cornerstone "Jade of Credit." A cold and elegant moneylender, she is skilled at understanding the human heart, with a personal hobby called "Bonajade Exchange." She''s willing to wait patiently for high-value acquisitions and adept at extracting value from seemingly destitute clients.

A senior manager in the IPC Strategic Investment Department and one of the Ten Stonehearts, known for her cornerstone "Jade of Credit." A beautiful and elegant moneylender, skilled in deciphering the depths of people''s minds, she often exacts a price from her adversaries and secures the IPC''s profits through collateral and contractual agreements. She is willing to go to great lengths to lay the groundwork for acquiring something of greater value, and to extract benefits from seemingly penniless clients.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Jade%2FLore',
  biography_es = 'A la galaxia Cadena de Plata se acercaba una tormenta de iones, de esas que tienen lugar una vez cada cien Eras del Ámbar. Una joven de una familia que se dedicaba al comercio de joyas estaba en la terraza, contemplando un cielo inundado de colores inusuales.

 "Es hora de irse, señorita. El Sr. Horus alquiló una nave estelar entera, y debemos dirigirnos al puerto estelar de Basvia para refugiarnos". "Pero los plebeyos de la Cadena de Plata no saben de la tormenta, ¿no?". "No tenemos opción. Es para prevenir posibles disturbios". "... Vete si quieres, pero yo me quedaré aquí y buscaré la ayuda de esa mujer". "Pero esta tormenta de iones borrará toda tu riqueza...". "Siempre hay cosas que no se pueden medir simplemente por su valor, como... la bondad y la vida". El anciano mayordomo dejó escapar un profundo suspiro.

La joven entró en la casa de empeños. "Bienvenida a la Casa de Empeño Bonajade. ¿Quién eres? ¿Y qué buscas?".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Jade',
  biography_es_translated = false
where id = 'hsr-jade';
update public.characters set
  biography_en = 'A foxian healer and counselor from the Xianzhou Yaoqing. Often greets people with a smile on his face and a scheme in his heart. Born into a prestigious Alchemy Commission family, he once withdrew from practicing medicine due to a broken heart. However, he returned to the field to treat "the Merlin''s Claw," General Feixiao. Skilled in the study of alchemical prescription that views food as medicine, especially those that induce a sensation of spiciness. He invented a cauldron-based medicinal formula known as the "nine-squared grid.""',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Jiaoqiu%2FLore',
  biography_es = 'El Lago Vendaval, el Yaoqing. En la lluvia neblinosa, el follaje y las flores de falso nenúfar amarillo decoraban el lago mientras los peces juguetones saltaban fuera del agua de vez en cuando. En el borde de este lago abundan flores de loto y castañas de agua, y las tortugas muy viejas tomando el sol en la playa de guijarros dibujan una escena cotidiana.

Un joven raposiano que llevaba a la espalda una canasta para guardar los ingredientes que recolectaba remaba en un pequeño bote. Las gotas de lluvia le caían por las orejas antes de que se las quitara con suavidad. Mientras recogía las plantas de corazón flotantes y las flores de loto, pelaba los tallos de arroz silvestre y los lanzaba a su boca con indiferencia. "Qué dulce y refrescante, deleita mi paladar...". Después de recoger las plantas, dirigió el bote a la orilla y cruzó el borde del lago con gran facilidad antes de cambiarse a un atuendo de sanador. ...',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Jiaoqiu',
  biography_es_translated = false
where id = 'hsr-jiaoqiu';
update public.characters set
  biography_en = 'The Divine Foresight, one of the Seven Arbiter-Generals of the Xianzhou Alliance, leads the Cloud Knights of the Xianzhou Luofu. A student of the Luofu''s previous Sword Champion, though not known for his martial prowess.

The Divine Foresight, one of the Seven Arbiter-Generals. Although his appearance may be one of indolence, he is more meticulous than seemingly meets the eye. He does not consider saving a situation from the brink of disaster to be a show of wisdom, and is thus fastidious with routine affairs to avoid any potential problems. Due to his careful management, Xianzhou has enjoyed many years of peace, with Jing Yuan''s seemingly lazy demeanor having earned him the moniker of the "Dozing General."',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Jing%20Yuan%2FLore',
  biography_es = '"Gran Adivina, ¿por qué usamos un tablero cuadrado, pero piezas redondas para el ajedrez estelar?". "¿Es por el cielo redondo? Las antiguas civilizaciones creían que la tierra era plana. El juego se inspira en los viejos tiempos y la conquista imperial, así que es cuadrado. Y las piezas... La gente creía que el cielo era una cúpula redonda, y las piezas giraban como las estrellas. Los de abajo también eran redondos". "No, no". "Ya predije tus próximos cuarenta y ocho movimientos. Jing Yuan, si quieres distraerme con preguntas, te sugiero que abandones mientras llevas la delantera". "Ah, ¿cómo puedes sospechar que tengo esa intención?". "No interrumpas. Continúa hablando". "Es cierto que el ajedrez es una metáfora y describe la condición humana. Las reglas de la guerra están claramente establecidas, con las acciones de cada bando: avanzar, retirarse, saltar... Avanzar o retroceder, por aquí o por allá. Por eso el tablero es cuadrado.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Jing%20Yuan',
  biography_es_translated = false
where id = 'hsr-jing-yuan';
update public.characters set
  biography_en = 'Former Sword Champion of the Luofu, and the creator of the Cloud Knights'' legends of undefeated might. Now, her name has been wiped from the records, and she is a traitor of the Xianzhou walking on the fine line between sanity and mara-struck.

Former Sword Champion of the Luofu, and the reason behind the Cloud Knights'' mythical reputation of implacable might. Now, her name has been wiped from the records, and she is a traitor of the Xianzhou walking on the fine line between sanity and mara-struck.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Jingliu%2FLore',
  biography_es = 'Una espada de más de un metro de largo que no pesa nada. No está forjada de hierro ordinario, sino condensada a partir de un eje de hielo afilado. Brilla con una luz tenue, como si fuera un rayo de luz de luna en la mano de quien la blande.

"Una espada de más de un metro de largo que pesa unos 3 kilos. Sostenla en la mano y atraviesa al enemigo con el extremo afilado". La mujer con uniforme militar mueve ligeramente la mano. Como si estuviera viva, la espada salta del estante para armas y se desenvaina tan pronto como aterriza en la palma de la mujer. La hoja se clava en el suelo junto a los pies de la chica y se queda vibrando con un zumbido estridente. "¿Lo has aprendido? Si es así, ve a luchar contra las bestias de guerra más comunes que los borisin usan en sus fuerzas terrestres. Una vez que hayas matado a 10 guivernos, daré por terminada tu primera lección". Ella permanece en silencio y mira a su alrededor.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Jingliu',
  biography_es_translated = false
where id = 'hsr-jingliu';
update public.characters set
  biography_en = 'A member of the Stellaron Hunters. A dashing, collected, and professional beauty. Used the enchantment of Spirit Whisper to set up (Trailblazer) to absorb the Stellaron. Her hobby is shopping for and organizing her collection of coats.

On the Interastral Peace Corporation''s wanted list, Kafka''s record only shows her name and a note about her "interest in collecting coats." Little is known about this Stellaron Hunter aside from her being one of "Destiny''s Slave" Elio''s most trusted members. In order to achieve Elio''s envisioned future, Kafka gets to work.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Kafka%2FLore',
  biography_es = '"Kafka, mujer humana oriunda de Pteruges-V: Nueva Babilonia. Miembro principal de los Cazadores de Estelaron, segunda al mando del Esclavo del Destino. Culpable de los siguientes delitos: invasión de Pier Point, dos cargos; robo en Pier Point; desaparición del sistema estelar Trovys; los incidentes relacionados con el Estelaron de Jemorse, Bayjhana, Shilla-39C, Ulmora, 7-Midville, Loar-51 y Dro''a; ciberataques contra Pier Point, cuatro cargos; ciberataques contra el planeta Tornillia; ciberataques contra la Estación Espacial Herta; la rebelión de Jepella. Se sospecha que está relacionada con las siguientes infracciones: los incidentes relacionados con el Estelaron de Sich-Lala, Inupeis, Oun-G7, Zukov, Lidovia, Illily, Attouine y Buhayama. Nivel de búsqueda: el más alto. Viva o muerta". Orden de captura de la Corporación para la Paz Interastral.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Kafka',
  biography_es_translated = false
where id = 'hsr-kafka';
update public.characters set
  biography_en = 'The new Cauldron Master of the Xianzhou Luofu''s Alchemy Commission is one perceptive and intelligent Vidyadhara healer. With a keen sense of smell, she diagnoses ailments and calms minds with aromatic therapy. Adept at navigating complex social relationships, she can remain impeccably composed even when turmoil rages within.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Lingsha%2FLore',
  biography_es = 'A medida que nubes de humo negro rodean el caldero, la joven se sienta expectante en el cojín, mirando fijamente el traqueteo de la tapa con sus brillantes ojos. Tras una explosión que resonó en todo el cuarto, la joven corre con entusiasmo al consultorio de la maestra sujetando una píldora cristalina, a pesar de que todo su cuerpo luce como un pergamino quemado que dejaron muy cerca de una vela. "¡Maestra Yunhua! Mire, ¡lo logré!".

La líder Yunhua está atendiendo pacientes en un consultorio abarrotado. Al ver a su maestra enfocada y concentrada, la joven se esconde detrás de su maestra obedientemente y baja su cabeza para oler el aroma de la píldora medicinal. "Este pulso... es uno difícil...". La joven escucha la sospecha de su maestra y se acerca al paciente para oler. "Pequeña Dan Zhu, ¡tu sentido del olfato es insuperable! ¿Me podrías decir algo sobre la condición de este paciente?". Yunhua le indica a la joven que avance y la mira de manera alentadora. "Humm...',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Lingsha',
  biography_es_translated = false
where id = 'hsr-lingsha';
update public.characters set
  biography_en = 'The boxing champion in Belobog''s Underworld, and one of Wildfire''s most capable fighters. The consecutive reigning champion of the Fight Club, whose enthusiasm inspires children of the Underworld to dream big.

An optimistic and carefree fighter with a mechanical arm. Skilled in mixed martial arts and is a Wildfire member. From the fight cage to the battlefield, and from a fighter to a warrior, Luka uses his strength to protect the people of the Underworld. He wishes to bring hope to others precisely because he had experienced despair himself.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Luka%2FLore',
  biography_es = 'Levanta el martillo de acero una y otra vez.

Las chispas estallan ante sus ojos y el sonido del metal ahoga el ruido sordo de los músculos y articulaciones. El joven todavía no es lo suficientemente alto como para alcanzar las herramientas situadas sobre el armario de hierro, pero la fuerza con la que blande el martillo de acero se asemeja a la de los artesanos más hábiles.

Esta tienda es su vida. Su padre se sienta frente a la entrada y limpia una y otra vez el oxidado letrero de la puerta. De vez en cuando, se tumba sobre su cama dura e imagina su futuro, pero no importa a dónde lo lleve su mente, la figura de su padre siempre aparece en el fondo de sus pensamientos.

De pronto, se oyen pasos acercándose. Por un momento deja a un lado su trabajo. Su padre se pone de pie, con su figura robusta, pero ligeramente encorvada. Son los miembros de Llamarada otra vez.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Luka',
  biography_es_translated = false
where id = 'hsr-luka';
update public.characters set
  biography_en = 'Carrying a coffin wherever he goes, he is a foreign trader who came from beyond the stellar seas. Has excellent medical skills.

An elegant and handsome blond young man who carries a giant coffin on his back. As an intergalactic merchant, he was unfortunately caught in the Xianzhou Luofu''s Stellaron crisis. And that is how he found his mastery of medicine to come in handy.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Luocha%2FLore',
  biography_es = '"¿Y usted es...?".
"Un comerciante ambulante".
"¿Cuál es el propósito de su visita?".
"Negocios".
"¿Jura no violar las leyes y normas de la Alianza Xianzhou, llevar a cabo actividades comerciales de acuerdo con la ley y no realizar ninguna actividad fuera del alcance de su visado?".
"Sí, lo juro".
"¿Jura no realizar ninguna investigación ilegal relacionada con la longevidad?".
"Eh... Sí, lo juro".
"Estupendo, firme aquí".

"Sr. Luocha, bienvenido al Luofu de Xianzhou".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Luocha',
  biography_es_translated = false
where id = 'hsr-luocha';
update public.characters set
  biography_en = 'A Belobogian Snow Plains Explorer, and the youngest of the Landau siblings. Calm and collected, with a strong drive for action. Often embarks on solo adventures to explore the snowy wilderness.

The youngest daughter of the Landau family, and one of Belobog''s best extreme environments explorers. She is highly capable of action despite her apparent lack of motivation. She only appears introverted and lazy to avoid unnecessary socialization. As for what counts as unnecessary socialization — "Um, aren''t all socialization unnecessary?"',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Lynx%2FLore',
  biography_es = 'Los paisajes de las llanuras nevadas están demasiado lejos de la vida cotidiana de Belobog, tan lejos que la niña solo puede verlos en sus sueños.

En la escuela, había leído en los libros de historia lo vasto y colorido que era el mundo antes del Hielo Eterno. Sin embargo, cuando Lynx preguntaba más detalles a su profesor, este siempre respondía decepcionado: "Por desgracia, esto solo se encuentra en las profundidades de las llanuras nevadas...".

En la clase de geografía, a menudo oía al profesor hablar sobre un extraño fenómeno celeste conocido como "aurora boreal" e imaginaba aquella luz brillante por todo el cielo.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Lynx',
  biography_es_translated = false
where id = 'hsr-lynx';
update public.characters set
  biography_en = 'A girl who once slumbered in eternal ice and knows nothing about her past. To find out the truth about her origins, she decided to travel with the Astral Express. As of right now, she has prepared about 67 different versions of her life story for herself.

March 7th in a Xianzhou-styled outfit. A sword-wielding female martial artist. Learning swordplay from both Yunli and Yanqing, she is eager to create more beautiful memories on the Xianzhou.

A spirited and quirky young girl who is into all the things girls her age are interested in, such as taking photos. She was awakened from a piece of drifting eternal ice, only to find that she knows nothing about herself or her past. Though initially feeling dejected, she decided to name herself after the date of her rebirth. And thus, on that day, March 7th was born.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/March%207th%2FLore',
  biography_es = '¿Por qué le gusta tomar fotos a Siete de Marzo? "Primero, a una chica como yo debería gustarle tomar fotos". "Segundo, nunca olvidas aquello que fotografiaste".

¿Qué sabe Siete de Marzo de fotografía? "Primero, cuando tomes fotos de platos de comida rara, todos los detalles deben poder verse en la foto porque «tomar fotos de comida equivale a comérsela. Cada detalle importa»". "Segundo, si tomas fotos con los ojos cerrados, capturarás la expresión de otro con sus ojos cerrados".

¿Por qué Siete de Marzo siempre lleva su cámara? "La próxima vez que alguien intente congelarme, ¡por lo menos tendré mi cámara!".

¿Y por qué no toma Siete de Marzo fotos directamente con su teléfono? "Ah, sí, por qué no... ¡espera, es porque me gustan las cámaras!".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Siete%20de%20Marzo',
  biography_es_translated = false
where id = 'hsr-march-7th';
update public.characters set
  biography_en = 'A girl who once slumbered in eternal ice and knows nothing about her past. To find out the truth about her origins, she decided to travel with the Astral Express. As of right now, she has prepared about 67 different versions of her life story for herself.

March 7th in a Xianzhou-styled outfit. A sword-wielding female martial artist. Learning swordplay from both Yunli and Yanqing, she is eager to create more beautiful memories on the Xianzhou.

A spirited and quirky young girl who is into all the things girls her age are interested in, such as taking photos. She was awakened from a piece of drifting eternal ice, only to find that she knows nothing about herself or her past. Though initially feeling dejected, she decided to name herself after the date of her rebirth. And thus, on that day, March 7th was born.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/March%207th%2FLore',
  biography_es = '¿Por qué le gusta tomar fotos a Siete de Marzo? "Primero, a una chica como yo debería gustarle tomar fotos". "Segundo, nunca olvidas aquello que fotografiaste".

¿Qué sabe Siete de Marzo de fotografía? "Primero, cuando tomes fotos de platos de comida rara, todos los detalles deben poder verse en la foto porque «tomar fotos de comida equivale a comérsela. Cada detalle importa»". "Segundo, si tomas fotos con los ojos cerrados, capturarás la expresión de otro con sus ojos cerrados".

¿Por qué Siete de Marzo siempre lleva su cámara? "La próxima vez que alguien intente congelarme, ¡por lo menos tendré mi cámara!".

¿Y por qué no toma Siete de Marzo fotos directamente con su teléfono? "Ah, sí, por qué no... ¡espera, es porque me gustan las cámaras!".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Siete%20de%20Marzo',
  biography_es_translated = false
where id = 'hsr-march-7th-imaginaria';
update public.characters set
  biography_en = 'A well-behaved young man serving as a hotel bellboy in Penacony. Misha has a great longing for the Nameless and dreams of one day embarking on a journey of his own.

A lovable and thoughtful bellboy at The Reverie Hotel. He wishes to become an intergalactic adventurer like his grandfather. He is extremely hardworking and is skilled at fixing a variety of machines. He also has a fondness for listening to the interstellar rumors the guests share with him. He hopes he can grow up faster and looks forward to embarking on his star-treading journey.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Misha%2FLore',
  biography_es = 'Cuando el reloj de bolsillo dio las seis de la mañana, el familiar aroma a leche y tostadas viajó desde la cocina hasta su estrecha habitación.

Los huéspedes estaban a punto de llegar, así que se levantó a toda prisa de la cama y se colocó en la entrada. Cuando varias personas altas atravesaron el umbral, le llegó un olor a aceite de motor, cuero y tabaco.

"Bi-bienvenidos...".

Los aventureros, que habían viajado desde planetas lejanos, apenas prestaron atención a la pequeña figura que les daba la bienvenida en la puerta, absortos como estaban en sus animadas historias de encuentros peculiares. Estas historias nunca dejaban de despertar cierta emoción en Misha y atraían su atención por completo.

"¿Has visto un enorme rayo bajar del cielo y quemar un planeta exuberante? Yo estaba allí, y una ráfaga de viento se llevó nuestra nave. Arriesgué mi vida para tomar unas fotos...". "Ja, déjame decirte que eso no es nada comparado con las locuras que he vivido yo.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Misha',
  biography_es_translated = false
where id = 'hsr-misha';
update public.characters set
  biography_en = 'A Shadow Guard of the Yaoqing, Moze is taciturn and solitary, always acting on his own. As an expert in intelligence services and other operations that must remain covert, Moze rarely shows himself before others. The moment he reveals his blade usually spells doom for his enemies. He commands a vast wealth of assassination techniques, coupled with an extraordinary obsession for orderliness and cleanliness.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Moze%2FLore',
  biography_es = '"Misericordioso del Sanctus Medicus... Ahora, escúchanos. Traga esto... No solo curará tu enfermedad, sino también serás igual a una raza de larga vida... Vivirás una vida muy larga...". Intenta tragar la medicina, pero no se atreve a inhalar.

No tiene idea de cuántas veces tendrá que soportar este sufrimiento. El líquido espeso pasa a través de su esófago como si estuviera tragando agujas. Un potente deseo de vomitar golpea todo su pecho. "Trágatela. No la escupas. Es medicina...". Su cuerpo también le transmitía esa sensación. Trágatela. Trágatela. Trágatela. Trágatela y nunca más tendrás que enfrentar la amenaza de bestias salvajes, nunca más caerás en las mandíbulas grandes y ensangrentadas del miedo. Trágatela, y tu cuerpo ya no será débil, nunca más tendrás que quedarte parado y ver cómo mueren tus camaradas. Trágatela.

Cuando sus órganos y carne empiezan a consumir la medicina, un extraño poder lo atraviesa.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Moze',
  biography_es_translated = false
where id = 'hsr-moze';
update public.characters set
  biography_en = 'Kremnos, the mist-shrouded city of chaos and war! Its royal lineage is tainted with patricide, and its god bears the name of calamity. The undying Mydeimos, the lion apart from the rest. Chrysos Heir who seeks the Coreflame of Strife, must suffer a thousand deaths, be bathed in blood on the path home, and bear the madness of fate alone. — Kingslayer be king, godslayer be god. Iron-hooves pound across the wilderness for the campaign, and must eventually soak in the blood of their homeland.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Mydei%2FLore',
  biography_es = '"En las antiguas leyendas de las polis costeras, se dice que el mar Estigio dio vida a seres comparables a los dioses. Los marineros hablaban de un ''rey marino'' que aparecía entre las olas con forma de niño, de rostro feroz, labios azules y tez rojiza. Se bañaba en las aguas corrosivas del mar Estigio, luchaba contra bestias feroces, bebía sangre y devoraba carne y huesos.

Dicen que, cada vez que el rey marino se sumergía en el mar Estigio, no tardaba en regresar a la vida. En aproximadamente nueve años, se regeneró más de diez mil veces hasta que finalmente desgarró a un monstruo gigantesco y tiñó el mar de rojo en mil leguas, sin que ninguna bestia se atreviera a acercarse a devorar la carne.

Cuenta la leyenda que podía arrastrar bancos de peces enteros hasta la playa de un solo coletazo. Una vez, él y su tripulación salvaron a unos pescadores náufragos que rezaban al cielo.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Midei',
  biography_es_translated = false
where id = 'hsr-mydei';
update public.characters set
  biography_en = 'A doctor from the Underworld and a caregiver of children. Alongside her kindness and caring, she also has a hidden dangerous side.

A fastidious doctor who always wears an enigmatic smile. In the Underworld where medical resources are scarce, Natasha is one of the very few doctors whom the people can turn to. Even the rambunctious Hook would politely greet her... "Hi, big sis Natasha."',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Natasha%2FLore',
  biography_es = '"¡Rápido, presiona aquí! ¡Presiona fuerte para detener la hemorragia!".

Natasha lanzó una mirada de pánico a su hermano. Ante ella yacía un hombre cubierto de vendas de la cabeza a los pies, con el torso retorciéndose por el intenso dolor mientras murmuraba.

"¡¿A qué estás esperando?! ¡Rápido, sujeta esto!".

Había rabia en la orden de su hermano, y también una pizca de decepción, ella era lo suficientemente perspicaz como para darse cuenta. Natasha se apresuró a agarrar el brazo derecho del hombre y reunió todas sus fuerzas para presionar la venda de algodón que tenía en el hombro.

El hombre dejó escapar un grito desgarrador, pero no podía aflojar hasta que su hermano se lo ordenara.

Después de quién sabe cuánto tiempo, el paciente que tenía delante dejó de respirar y ella se quedó mirando el cuerpo sin vida.

"Hiciste lo que pudiste", dijo su hermano con su habitual tono desenfadado. "Descansa un poco.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Natasha',
  biography_es_translated = false
where id = 'hsr-natasha';
update public.characters set
  biography_en = 'An intelligence officer for the Silvermane Guards. She has a serious personality and is revered by other members of the Silvermane Guards.

The meticulous Intelligence Officer of the Silvermane Guards. While young, she is undeniably brilliant. Whether it relates to maneuvering troops, distributing supplies, or analyzing terrain, Pela can answer any problems with calm certainty. As for her phone case... "It has nothing to do with work, captain."',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Pela%2FLore',
  biography_es = 'El siguiente es un extracto de la página 102 del «Registro de reclutamiento de la Guardia Crinargenta: Departamento de Inteligencia, Vol. 24»:

Información básica de la candidata:

"Me llamo Pelageya Sergeyevna, pero pueden llamarme Pela". "Me gradué con honores en la Facultad de Ciencias Sociales y en la Facultad de Ciencias de la Escuela de Cadetes de Belobog con una doble licenciatura en Estudios Bélicos e Inteligencia". "¿Mis aficiones? Disculpe, deme un minuto para recomponerme...". "... Mi afición es el estudio de la música prehistórica de Belobog. Eso es todo". "No, no tengo otras aficiones... De verdad... Por favor, créame".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Pela',
  biography_es_translated = false
where id = 'hsr-pela';
update public.characters set
  biography_en = 'The chest of Georios, the body of the fallen dragon supporting the shattered earth, enduring millennia of pain. Dan Heng, the Nameless and the Chrysos Heir who guards the Earth''s Coreflame, steadies the world before it falls and guides all life across the land to a new home beyond. Rivers flow to the sea, mountains echo in harmony, and the eternal path stretches ten thousand miles.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Dan%20Heng%20%E2%80%A2%20Permansor%20Terrae%2FLore',
  biography_es = 'Comienza un nuevo día. No es más que otro día extremadamente normal a bordo de esta gigantesca nave. Los mercados ya abrieron, y el rocío de la mañana aún está fresco. Sin embargo, el joven que cruza la calle no había visto nunca semejante espectáculo. Incluso antes de arreglárselas para notar todas las diferencias entre la ciudad real y la descripción del libro, ya está disfrutando del calor del sol en la nuca. Era la primera vez que veía su propio cuerpo con claridad. Este cuerpo que le pertenece, el cuerpo que pertenece a este nombre actual. Cuando llegó al puerto, el soldado que lo escoltaba le quitó los últimos grilletes. Caminó hacia adelante sin mirar atrás. Podía sentir, muy débilmente, varios transeúntes, mirándolo llenos de odio. No fue hasta que la nave espacial despegó que volvió la cabeza y echó un último vistazo atrás. Realmente era una nave espacial magníficamente grandiosa, tal como decía el libro.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Dan%20Heng',
  biography_es_translated = false
where id = 'hsr-permanser-terrae';
update public.characters set
  biography_en = 'Aedes Elysiae, a remote frontier village isolated from the world, now lives on only in cryptic legends. The Nameless hero, ████████, the Chrysos Heir holding the Coreflame of "Worldbearing," memorizes the ideals of the entire world, carries the fate of millions, and brings the first light of dawn to the new world —"But if dawn should never come, let this fury consume this body, and rise as tomorrow''s blazing sun!"',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Phainon%2FLore',
  biography_es = 'En el pasado, Fainón perdió todo lo que juró proteger. Debido a esto, un miedo quedó de forma permanente en su corazón.

En algún momento, fue reconocido por el oráculo como uno de los Herederos de Crisos. Tras la llegada del Trazacaminos y Dan Heng a Amphoreus y con la ayuda de Midei, derrotaron al TItán del Conflicto, Nikador. Fainón llevó la Yesca al Vórtice de la Creación, donde comenzó el ritual para convertirse en un semidios pero falla y no puede heredar el poder.

Fainón le pide a Tribbie que le muestre el pasado y, junto al Trazacaminos y Trinnon, exploran la vida de Tribios.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Fain%C3%B3n%2FHistoria',
  biography_es_translated = false
where id = 'hsr-phainon';
update public.characters set
  biography_en = 'Diviner of the Divination Commission on the Xianzhou Luofu, and a librarian. Always slacks off and is about to be demoted to a "door guardian."

An ordinary diviner at the Divination Commission. She would never slack off in slacking off. Following her parents'' wishes, Qingque qualified for the Divination Commission, but the relaxing post she was expecting was in fact a brutal, high-intensity workplace. After several years of work, Qingque has honed her skills — no matter which department she''s transferred to, she''s still the lowest-leveled diviner. She would browse books and play ancient tile games to wile away the hours... What more could one ask for than a life like this?',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Qingque%2FLore',
  biography_es = 'La leyenda de Qingque comienza en la escuela.

Desde su primer año hasta su graduación, cada vez que se publicaban las notas de los exámenes, la palabra Qingque iba siempre seguida del mismo número, escrito con todas las letras: sesenta, un aprobado raspado.

Al principio, sus tutores pensaron que Qingque era una estudiante mediocre inadecuada para el mundo académico, por lo que no le dieron importancia. Pero, como el mismo número seguía apareciendo en los resultados de todos los exámenes, empezaron a sospechar que no se trataba de una coincidencia.

Muy pronto, las largas conversaciones con los tutores se convirtieron en algo habitual para Qingque. Quien esté familiarizado con este tipo de situaciones reconocerá estas frases hechas: al principio, ella era "tranquila y bien educada," o "dotada".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Qingque',
  biography_es_translated = false
where id = 'hsr-qingque';
update public.characters set
  biography_en = 'A peculiar girl who appears in Penacony like a flashbang at the darkest hour of night, identifying herself as a ninja and attributing everything in the world to "ninjutsu." Upholding the recitation of ninja mantra, creating Dazzling Ninja Seals, and studying ninja scrolls — That is, the Way of the Ninja involves rap, graffiti, and manga — Through rigorous self-discipline, she roams the stars, upholding justice and righteousness. As a member of the Galaxy Rangers, she relentlessly pursues the villain known as Evil Ninja Osaru, chasing them to the very edge of the Cosmos.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Rappa%2FLore',
  biography_es = 'Escrituras del ninjutsu cósmico, relato de la purificación deslumbrante. Nodo de prueba: El shuriken cruel >>Iniciando sistema...>> >>¡El usuario ha iniciado sesión!>> >>Verificando nivel ninja...>> >>¡Te doy la bienvenida a tu exclusivo juego ninja!>>

Sistema de prueba: Las calles de la Capital Ninja están envueltas en una luz de luna verde escalofriante. Dentro de la casa de Osaru, una mucosidad maloliente supura de unos jarrones de cristal destrozados y se escuchan sin cesar gruñidos monstruosos. Sistema de prueba: Equipada con el instrumento ninja: tinta cromática deslumbrante que te ha dado el maestro, viajas a través de la lluvia ácida incesante, cortas el aire podrido y corres hacia el interior de la casa de Osaru. Sistema de prueba: Los ninjas malvados te ven y se abalanzan en tu dirección mientras pronuncian palabras desconocidas para ti.

¿¿¿???: "¡La sujeto de prueba se revela!". ¿¿¿???: "¡Santo cielo! ¡Has roto dispositivos muy caros!".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Rappa',
  biography_es_translated = false
where id = 'hsr-rappa';
update public.characters set
  biography_en = 'Hailing from a world beyond our universe where magic and magecraft coexist, this young mage tirelessly hones her skills. She is the Sixth Head of the Tohsaka family, a prestigious lineage of Fuyuki City mages. Currently studying under a renowned Clock Tower mentor with deep ties to the Holy Grail War, she finds herself hopping across dimensions and planes just to finish an internship project... "Huh? Where even am I?? Why isn''t there a single wisp of magical energy here???" "The... Holy Grail? Oh, thank goodness, I''m saved! Sorry, don''t mind if I borrow this!"',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Rin%20Tohsaka%2FLore',
  biography_es = 'Venida de un mundo ajeno a nuestro universo, donde la magia y la hechicería conviven, esta joven maga pule sus habilidades sin descanso. Es la sexta cabeza de la familia Tohsaka, un linaje prestigioso de magos de la ciudad de Fuyuki. Actualmente estudia con un reputado mentor de la Torre del Reloj muy vinculado a la Guerra del Santo Grial, y ha terminado saltando entre dimensiones y planos solo para completar un proyecto de prácticas... "¿Eh? ¿¿Dónde estoy?? ¿¿¿Por qué no hay ni un hilo de energía mágica aquí???". "El... ¿Santo Grial? Ay, menos mal, ¡estoy salvada! Perdona, no te importará que lo tome prestado, ¿no?".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/wiki/Rin%20Tohsaka%2FLore',
  biography_es_translated = true
where id = 'hsr-rin-tohsaka';
update public.characters set
  biography_en = 'A Halovian singer who was born in Penacony and has risen to cosmic fame. An elegant and demure young lady. This time, she has been invited home by The Family to grace everyone with song during the Charmony Festival. She can use the power of "Harmony" to broadcast her music, manifesting "resonance" among not only her fans but all manner of lifeforms.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Robin%2FLore',
  biography_es = '"Dice que su vida es como una canción. El comienzo es oscuro y solemne.

Cuando era apenas un bebé, el Estelaron descendió sobre su ciudad natal. «Pena, lamentos, oraciones... Esos son los primeros sonidos que recuerdo. Rezábamos por la salvación con canciones tristes, pero la mirada de los dioses nunca se posó en nosotros...».

La cantante, que siempre está sonriendo, se queda extrañamente en silencio por un momento.

«Entonces, ¿dirías que de ahí viene tu inspiración musical?».

«No recuerdo la mayoría de las canciones que cantábamos porque era demasiado pequeña, pero sí recuerdo cuando el Estelaron empezó a devorar el paisaje onírico... Mi madre nos abrazó a mi hermano y a mí, e intentó calmar nuestros miedos con sus canciones...».

«¿Aún recuerdas la canción que les cantaba?». Viendo su expresión de sufrimiento, pensé no preguntarle nada, pero me respondió tras una pausa breve.

«No podía escuchar nada... Todos los demás sonidos a mi alrededor eran muy fuertes y aterradores.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Robin',
  biography_es_translated = false
where id = 'hsr-robin';
update public.characters set
  biography_en = 'A member of the Genius Society and an expert in life sciences. She teamed up with Herta and others to develop the Simulated Universe.

A scholar of exquisite temperament, member #81 of the illustrious Genius Society, and an expert in the field of life sciences. She earned Nous'' attention with her talent and terrifying perseverance, and began her research on the origin of life in a secretive corner of the universe. Subsequently, she was invited by Herta to collaborate with Screwllum and Stephen to develop the Simulated Universe. Privately, she revels in traditional theater and desserts, and she is also very interested in embroidery.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Ruan%20Mei%2FLore',
  biography_es = 'Durante su infancia, su madre la expuso a la ciencia, ya que ella misma era científica.

Su vida en una casita con su familia de entusiastas de la ciencia estuvo llena de amor, pero no pasó mucho tiempo antes de que se diera cuenta de que había diferencias sutiles en el "amor", y que cada tipo tenía aromas diferentes.

Su abuela de cabello plateado era fanática del teatro tradicional, con sus tarareos y gorjeos, mientras que su padre usaba un par de botas grandes y peludas. Sus padres se querían, aunque discutían de vez en cuando. Era una chica impasible que cometía errores todo el tiempo, pero a la que también solían perdonar.

"Yo era más cercana a la tía Arlice en comparación con mis otros parientes, ya que ella me compraba bocadillos. Su amor era el mejor".

Pronto, la joven aprendió a ser terca. Su comprensión del "amor" rompió con las fórmulas que se enseñan en los libros de texto. A medida que creció, su madre se volvió estricta con ella.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Ruan%20Mei',
  biography_es_translated = false
where id = 'hsr-ruan-mei';
update public.characters set
  biography_en = 'The solitary Heroic Spirit traverses the long night of fate. The banner of the round table remains unfurled in a dream. Alas, the knight-king of Camelot has yet to reach that ever-distant utopia. Though still a young maiden, she has heeded the call for this most unique iteration of the Holy Grail War. With the Sword in the Stone offering its choice once more, how shall she shatter the illusions of the past? — "The wishes I did not fulfill will end here."

The solitary Heroic Spirit traverses the long night of fate. The banner of the round table remains unfurled in a dream. Alas, the knight-king of Camelot has yet to reach that ever-distant utopia. Though still a young maiden, she has heeded the call for this most unique iteration of the Holy Grail War. With the Sword in the Stone offering its choice once more, how shall she shatter the illusions of the past? "The wishes I did not fulfill will end here."',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Saber%2FLore',
  biography_es = 'Si la nación idílica de la que hablan los filósofos requiere un gobernante, entonces la joven que tienes delante es la mejor opción. Ella lucha por la felicidad de todos los seres del mundo y dedica su vida a ayudar a los débiles y enfrentarse a los fuertes. Por ejemplo, la razón de que los caballeros bajo su liderazgo sean conocidos como los de "la mesa redonda" es porque enfatiza la igualdad entre el rey y los caballeros...

"¡Qué pedante! ¿No puedes escribir algo más práctico?".

Es cierto. La prosperidad y la paz del reino son lo único que le importa a un rey. En comparación, la lucha personal y la gloria individual no son más que una pieza en el tablero que se mueve para lograr un objetivo. Sin embargo, lo más interesante es que ahora es una Servant, una forma de vida especial invocada en el mundo gracias a la existencia de muchos Misterios.

El ascenso y la caída de su nación han sido registrados en los libros de historia.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Saber',
  biography_es_translated = false
where id = 'hsr-saber';
update public.characters set
  biography_en = 'A merchant who freely travels between the Overworld and the Underworld. He acts like he is everyone''s friend, is enthusiastically humorous, and is good at bantering.

A silver tongued salesman. Where there is profit to be made, you can be sure Sampo is nearby. The information that only Sampo possesses makes it hard not to approach him for help, but becoming his "customer" is not necessarily a good thing. After all, "customers" can quickly turn into "commodities" for the right price.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Sampo%2FLore',
  biography_es = '"¡Hola a todos! Soy Brughel Poisson, de «El Cristal de la Actualidad», y estoy en la plaza de la fuente del distrito administrativo. A mi lado hay un integrante de la Asociación de Víctimas de la Estafa Azul Oscuro y voy a entrevistarlo".

"Hola, caballero. ¿Podría contarnos al público y a mí su experiencia como víctima de estafa?".

"Oh... ¡Estoy tan enfadado! Ese rufián de pelo azul... ¡Espero que se muera!".

"Señor, estamos en directo en la radio ahora mismo. Por favor, cálmese".

"Ejem... De acuerdo. «El Cristal de la Actualidad», ¿verdad? Muy bien, deberían informar más sobre el sufrimiento de la gente común y prestar menos atención a los chismes de los Arquitectos".

"¡Le digo que ese rufián de pelo azul otra vez está rondando por el distrito administrativo! Ayer robó tres botes de especias para pan de centeno de mi tienda, ¡tres botes grandes! ¿Sabes cuánto tiempo les duran esos botes de especias a los dignatarios?',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Sampo',
  biography_es_translated = false
where id = 'hsr-sampo';
update public.characters set
  biography_en = 'A resident of the Underworld and the backbone of Wildfire. She goes by the alias "Babochka." She has a frank personality, but there is a delicate and sensitive hidden side to her deep in her heart.

A spirited and valiant member of Wildfire who grew up in the perilous Underworld of Belobog. She is accustomed to being on her own. The protectors and the protected, the oppressors and the oppressed... The world Seele grew up knowing was just a simple dichotomy... That is, until "that girl" appeared.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Seele%2FLore',
  biography_es = 'La primera pelea que tuvo Seele en su vida fue por ella misma. Por aquel entonces, deambulaba sin rumbo por los callejones todos los días. Cuando tenía sed, mendigaba agua en el orfanato; cuando tenía hambre, cambiaba los restos de tela que encontraba por galletas con los vendedores. Todo el mundo en Villarremache conocía a esa intrépida vagabunda, y todos querían evitar a esa pequeña bribona salvaje y testaruda. Una tarde calurosa, sintió sed de tanto jugar. Llegó al orfanato y descubrió que en el cubo del pozo no había agua. Otro anciano indigente también buscaba agua y, tras una lucha de poder, el hombre huyó, y Seele se ganó el derecho a saciar su sed sola. Seele vio al hombre tres días después. A través de la ventana de la clínica, pudo ver una figura vieja y enjuta a las puertas de la muerte, tumbada en una camilla. Desde entonces, siempre deja un poco de agua para el siguiente visitante.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Seele',
  biography_es_translated = false
where id = 'hsr-seele';
update public.characters set
  biography_en = 'A Belobog mechanic who used to be a researcher for the Technology Division of the Architects. As Gepard Landau''s elder sister, her personality stands in stark contrast to her brother''s. She loves an ancient form of music known as "rock ''n'' roll" that was popular before the Eternal Freeze.

The free and rebellious eldest daughter of the Landau family. Once a close friend of Cocolia''s, she is now a mechanic purely because she likes this job. In the Everwinter-stricken Belobog, she opened a workshop called "Neverstop" that puts business on hold from time to time for outdoor rock ''n'' roll performances. And should anyone ask her about the workshop''s profits... "This is just a hobby, dear. I''m not short on money."',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Serval%2FLore',
  biography_es = 'Es la mecánica con más talento de todo Belobog, además de ser la hermana del capitán Gepard Landau, de la Guardia Crinargenta. ¿Mencionamos que también es una estrella de rock local? "Para, un momento. Deja el comienzo y el final, y quita la parte del medio". "No pases por encima de mi identidad de esa forma... Yo, Serval Landau, no soy un accesorio de nadie". "Oh, ¿ya no hay nada más? Genial, entonces déjame añadir esto: Si algo está roto, pásate cuando quieras por mi Taller del Nuncainvierno en el distrito administrativo para verme". "¿Dices que quieres escuchar algo de rock? Pues mejor aún: pásate por mi Taller del Nuncainvierno, en el distrito administrativo, para hacer vibrar esta ciudad... ¡con Fiebre Mecánica!".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Serval',
  biography_es_translated = false
where id = 'hsr-serval';
update public.characters set
  biography_en = 'A member of the Stellaron Hunters and a genius hacker. She sees the universe as a massive immersive simulation game and has fun with it. She''s mastered the skill known as "aether editing," which can be used to tamper with the data of reality.

The universe is just another game to this super hacker. No matter how thorny the defense system, Silver Wolf can crack it with ease. Her hacking battle with Screwllum of the Genius Society has become stuff of legends in the hacking world. How many more levels are there to beat in the universe? Silver Wolf looks forward to finding out.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Silver%20Wolf%2FLore',
  biography_es = 'Jugaba con el mando día sí, día también. Un restaurante de comida rápida con una sola empleada, un sótano convertido en salón recreativo, varios videojuegos antiguos: así fue su infancia.

No tenía ni nombre legal ni número de identificación, tan solo un apodo que le había puesto la propietaria. No tenía amigos, pero no se sentía sola. Le gustaba jugar Pong: dos barras y una pelota de luz, el más sencillo de todos los juegos de pelota. Se podía pasar el día entero jugando a él. Le gustaba Battle Wheel 32: ocho bloques de diferentes colores en un espacio dibujado con una matriz. Solo había una regla: ganar, como fuera. Le gustaban Geometric Wars, Odysseus y Star Cheetah. Los registros de puntuación de estos juegos estaban repletos de cifras astronómicas que otros clientes habían dejado.

Jugaba con el mando día sí, día también. Hasta que un buen día, en todos los registros de puntuación solo quedó un nombre.

Dejó el mando a un lado y miró a su alrededor en el sótano vacío.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Silver%20Wolf',
  biography_es_translated = false
where id = 'hsr-silver-wolf';
update public.characters set
  biography_en = 'A member of the Masked Fools. Inscrutable and unscrupulous. A dangerous maestro of theatrics, utterly engrossed in the art of performance. Adorned with innumerable masks, she is the hero with a thousand faces. Wealth, status, power... None of those matters to Sparkle. The only thing that can get her attention is "amusement."',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Sparkle%2FLore',
  biography_es = 'La niña, abandonada en un orfanato, vivió sin saber nada de sus orígenes o destino hasta que se encontró con una compañía de teatro ambulante. Desde lejos, vio a una chica de cabellos azabaches con dos coletas que se movía con la fluidez de un pez por el escenario. A pesar de sus diversas máscaras, ninguna le impedía reír o llorar durante su actuación, logrando cautivar al público incluso desde la lejanía. El pez saltó delante de ella y luego se sumergió de nuevo, creando pequeñas olas en la superficie del agua.

Poco a poco, se dio cuenta de que estaba viendo el espectáculo desde debajo del escenario.

Intrigada, siguió yendo a ver los espectáculos durante muchos días, pero siempre como parte del público, sin subirse al escenario. Al finalizar una de las actuaciones, fue a los bastidores. Allí, la chica de cabello negro le dio una máscara. "¿Yo también puedo actuar?". "¿Por qué no? Si te pones la máscara y la gente cree que eres «Sparkle», entonces lo eres.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Sparkle',
  biography_es_translated = false
where id = 'hsr-sparkle';
update public.characters set
  biography_en = 'The dream of the Order has dissipated, yet there are still those who will not give up on their original intent. — The traveler whose wings were clipped... whereto shall his footsteps lead?',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Sunday%2FLore',
  biography_es = '"Querida hermana:

¡Me comí todos los postres que me dejaste! No pude evitarlo, ¡las tartaletas estaban tan deliciosas que me comí tres antes de la clase de música! Desafortunadamente, la maestra bruja gritona dijo que mi voz sonaba como un gruñido y que cantaba como un patito, así que me castigó. ¿Y adivina qué? ¡Terminé comiendo una cuarta tartaleta fuera del aula!

Por suerte, he estado practicando el piano con mucho esmero, y el Sr. Grandote siempre elogia mi talento. Ya sé tocar una melodía en su forma original después de escucharla una sola vez. ¡Soy tan genial como tú! Cuando vuelvas, podemos tocar a dúo en el mismo piano y hasta podríamos ofrecer otro concierto.

No tienes por qué preocuparte por nuestro pajarito. Cada día vuela un poco más alto. Con el buen tiempo que hemos tenido últimamente, ¡sin duda pronto se marchará volando! Esta tarde, mientras limpiaba la tumba de mamá, vi varios pájaros parecidos al nuestro.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Sunday',
  biography_es_translated = false
where id = 'hsr-sunday';
update public.characters set
  biography_en = 'Born on the Xianzhou Yaoqing, sent to the Cloud Knights of the Luofu for military training. She wields her family sword, a gift from her mother, and longs for the future she will go on to write.

A naive and enthusiastic newcomer to the Cloud Knights who wields a greatsword. She yearns for the historic legends of the Cloud Knights, and is eager to become such a legendary figure herself. As such, Sushang firmly believes in the philosophies "be eager to help those in need," "do one good deed a day and reflect on oneself three times a day," leading her to busy days full of helping others.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Sushang%2FLore',
  biography_es = 'Oh, Puerta de Jade tan brillante; oh, elevados cielos de jade. Los astroesquifes se pasean por la Gran Feria, y los turistas se amontonan en la puerta del cielo. Quien suba o baje del Luofu podrá ver un amplio umbral fronterizo al mirar hacia arriba, con una corriente arremolinada que marca la brecha en el espacio. Es un espectáculo grandioso ver cómo despegan las naves interestelares, grandes y pequeñas.

Esta puerta del cielo se llama Puerta de Jade y es la entrada a los dominios de Xianzhou. Bajo el dintel, los viajeros entran para ir al Luofu. Entre ellos, hay una joven con un vestido color melocotón. Debe tener entre 16 y 17 años, pero por los estándares de Xianzhou, es imposible adivinar su edad real, ni tampoco se puede saber qué extraña fuerza la ayuda a sostener esa espada tan pesada que lleva en la mano.

Es una espada muy poco común, de unos sesenta centímetros de largo. Está envuelta en una tela blanca, parece una antigüedad.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Sushang',
  biography_es_translated = false
where id = 'hsr-sushang';
update public.characters set
  biography_en = 'Esteemed Genius Society #83, human, female, young, beautiful, attractive. It''s said that she lives in the far edge of the Cosmos, almost never leaving. Sounds like her appearance this time... ...must be for some issue that requires a personal touch, right?

Genius Society #83, Madam Herta, resides deep within the Clock Tower at the edge of the cosmos, pursuing the ultimate mysteries of the universe as a sorceress. Thanks to de-aging technology, she maintains the youthful appearance of her prime. Disliking mundane affairs, she typically delegates such tasks to her puppets.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/The%20Herta%2FLore',
  biography_es = 'N.º de perfil: ███████ Nombre del objeto raro: Caleidoscopio de la infancia de un genio Observaciones: ¡No mirar! ¡¡No mirar!! ¡¡¡No mirar!!!

¿De verdad quieres echar un vistazo?

¿Estás Trailblazer?

Bueno, ya que has bajado hasta aquí... Pero recuerda, no me hago responsable de las consecuencias. Descripción: Propiedad privada y secreta del miembro n.º 83 del Círculo de Genios, la señora Herta, con apoyo técnico del Jardín de los Recuerdos. Diseñado exclusivamente para que la dueña reviva momentos hermosos desde una perspectiva en primera persona. Advertencia: Material peligroso que no debe ser visto por personas ajenas. La visualización no autorizada tiene una gran probabilidad de provocar graves consecuencias psicológicas. Estudio de caso: Dos auditores miraron a escondidas. Uno comenzó a balbucear sin cesar, olvidando incluso su propio nombre, mientras que el otro solo repetía: "¡La señora Herta es magnífica!".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Sra.%20Herta',
  biography_es_translated = false
where id = 'hsr-the-herta';
update public.characters set
  biography_en = 'Amicassador of the Sky-Faring Commission of the Xianzhou Luofu. She travels with business delegates, forging trade relationships and alliances with many worlds.

A silver-tongued foxian girl, Tingyun is the Head Representative of the Whistling Flames, a merchant guild officially approved by the Sky-Faring Commission. She has such a way with words that often leaves her audience eagerly waiting for more of her captivating tales. As a result of her supervision, the Xianzhou trade fairs are now known throughout the cosmos. "Try one''s best to avoid conflict when possible, and persuade those who can be persuaded" — that''s Tingyun''s motto.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Tingyun%2FLore',
  biography_es = 'Hay un dicho: "Los raposianos están hechos para los negocios". Si se pasa un rato en el Conde Insomne, se puede comprobar esta realidad.

"Hay algo que usted no sabe", dijo la mujer raposiana, agitando su exquisito abanico de hueso mientras miraba al escéptico hombre que tenía delante. "El agua y la tierra son la base de la vida. Las semillas de los arenacítricos de la Confederación del Agua Amarga, cuando se trasplantan a los suelos sagrados de Vonwacq, se convierten en naranjas dulces. Esto se debe a los fértiles suelos biodinámicos de Vonwacq. Y, si se importan los alevines de pez linterna de Thalassa y se suministran a los vidyadhara del Desfiladero de Escamas para que los críen, pueden duplicar su tamaño hasta alcanzar más de un metro de largo".

"El último plan de Llamas Silbantes consiste en seleccionar las especies con potencial comercial y transportarlas de manera segura en astroesquifes comerciales.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Tingyun',
  biography_es_translated = false
where id = 'hsr-tingyun';
update public.characters set
  biography_en = 'Topaz is the Leader of the Special Debts Picket Team and high-level manager of the Strategic Investment Department under the Interastral Peace Corporation. A member of the "Ten Stonehearts" at a young age, Topaz''s foundational expertise is "debt retrieval." Her partner, the Warp Trotter "Numby," is also capable of keenly perceiving where "riches" are located, ensuring that jobs based in security, debt collection, and actuarial varieties are of no great challenge. At presently they are traveling the cosmos together, seeking all manner of liability disputes that might be affecting the stable progression of the IPC''s businesses.

Topaz, Senior Manager of the Strategic Investment Department in the Interastral Peace Corporation, and leader of the Special Debts Picket Team. Already a member of the "Ten Stonehearts" at a young age, Topaz''s Cornerstone is the "topaz of debt retrieval." Her partner, the Warp Trotter "Numby," is also capable of acutely perceiving where riches are located.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Topaz%2FLore',
  biography_es = '"Destor, ¿has visto este currículum?".

"¿Cuál? Oh, ese. Acaba de terminar las prácticas en el equipo de investigación de mercados y causó un gran revuelo... en el buen sentido".

"¿Ya terminó las prácticas? Oh...".

"¿Pasa algo, Sr. Dvorski?".

"No, nada, es solo que siento curiosidad. Al fin y al cabo, la edad a la que empezó su carrera profesional es la más joven jamás registrada en este departamento... Además, su currículum es impresionante. A ver... ¡Oh! ¿Hasta firmó un contrato de por vida? No esperaba que encontráramos un talento así en un planeta tan desgraciado...".

"Ya lo comprobé con nuestros colegas. Todo lo que pone en su currículum es cierto. Ni siquiera escribió los resultados de su examen de empleo. Al parecer, sacó una nota alta en ciencias actuariales, microeconomía y macroeconomía, finanzas intergalácticas y ciencias de administración. Hasta su examen físico fue casi perfecto. Solo falló en...".

"¿Eh? ¿En qué?".

"... En protocolo empresarial.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Topaz',
  biography_es_translated = false
where id = 'hsr-topaz';
update public.characters set
  biography_en = 'A Trailblazer who boarded the Astral Express. They chose to travel with the Astral Express to eliminate the dangers posed by the Stellaron.

A Trailblazer, (Trailblazer), decides to travel with the Astral Express to eliminate the threat of the Stellaron.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Trailblazer%2FLore',
  biography_es = 'Un Trazacaminos que subió a bordo del Expreso Astral. Decidió viajar con el Expreso Astral para acabar con los peligros que provoca el Estelaron.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/wiki/Trailblazer%2FLore',
  biography_es_translated = true
where id = 'hsr-trazacaminos-fisico';
update public.characters set
  biography_en = 'A Trailblazer who boarded the Astral Express. They chose to travel with the Astral Express to eliminate the dangers posed by the Stellaron.

A Trailblazer, (Trailblazer), decides to travel with the Astral Express to eliminate the threat of the Stellaron.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Trailblazer%2FLore',
  biography_es = 'Un Trazacaminos que subió a bordo del Expreso Astral. Decidió viajar con el Expreso Astral para acabar con los peligros que provoca el Estelaron.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/wiki/Trailblazer%2FLore',
  biography_es_translated = true
where id = 'hsr-trazacaminos-fuego';
update public.characters set
  biography_en = 'A Trailblazer who boarded the Astral Express. They chose to travel with the Astral Express to eliminate the dangers posed by the Stellaron.

A Trailblazer, (Trailblazer), decides to travel with the Astral Express to eliminate the threat of the Stellaron.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Trailblazer%2FLore',
  biography_es = 'Un Trazacaminos que subió a bordo del Expreso Astral. Decidió viajar con el Expreso Astral para acabar con los peligros que provoca el Estelaron.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/wiki/Trailblazer%2FLore',
  biography_es_translated = true
where id = 'hsr-trazacaminos-hielo';
update public.characters set
  biography_en = 'A Trailblazer who boarded the Astral Express. They chose to travel with the Astral Express to eliminate the dangers posed by the Stellaron.

A Trailblazer, (Trailblazer), decides to travel with the Astral Express to eliminate the threat of the Stellaron.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Trailblazer%2FLore',
  biography_es = 'Un Trazacaminos que subió a bordo del Expreso Astral. Decidió viajar con el Expreso Astral para acabar con los peligros que provoca el Estelaron.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/wiki/Trailblazer%2FLore',
  biography_es_translated = true
where id = 'hsr-trazacaminos-imaginario';
update public.characters set
  biography_en = 'From that holy land blessed by the tripartite prophecy, the messenger split into a thousand forms, embarking on a long journey. Tribios, Holy Maiden of Janusopolis, the Chrysos Heir who stole Passage''s Coreflame, toiled for the masses and brought the news of deliverance to all domains. —Seek the children of humanity with golden blood in their veins, shatter the dimmest dark in this world, and walk toward the tomorrow where the stars gleam.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Tribbie%2FLore',
  biography_es = 'Desde aquella tierra sagrada bendecida por la profecía tripartita, la mensajera se dividió en mil formas y emprendió un largo viaje. Tribios, Santa Doncella de Janusópolis y Heredera de Crisos que robó la Llama Central del Tránsito, se afanó por los suyos y llevó la noticia de la salvación a todos los dominios. "Buscad a los hijos de la humanidad con sangre dorada en las venas, romped la más densa oscuridad de este mundo y caminad hacia el mañana en el que brillan las estrellas".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/wiki/Tribbie%2FLore',
  biography_es_translated = true
where id = 'hsr-tribbie';
update public.characters set
  biography_en = 'A seasoned member of the Express crew. The passion buried in his heart burns anew as he enjoys this fresh adventure. Occasionally, he would sketch the experiences in a notebook.

The wise and sophisticated former Anti-Entropy Sovereign who inherits the name of the world — Welt. He has saved Earth from annihilation time and time again. After the incident with St. Fountain came to a close, Welt had no choice but to venture with the initiator of the incident to the other side of the portal. Perhaps even he didn''t expect the new journey nor companions that awaited him there.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Welt%2FLore',
  biography_es = 'De camino al portal, Welt sacó un lápiz y comenzó a delinear un boceto. En los últimos ocho años, había estado repitiendo esta tarea. Antes de eso, construía objetos de una manera diferente, siempre que pudiera hacerse una imagen mental. Sin embargo, nunca consideró esto como una "creación", porque eran solo objetos originales que aparecían en el mundo y que no tenían nada que ver con su mente. Esta es la responsabilidad diaria de Welt, quien heredó el nombre del mundo. Si hay que rescatar al mundo, se convertirá en ese héroe sin dudarlo. Ya cayó muchas veces y fue objeto de burlas muchas más, pero siempre estará frente a todos, desde el pasado hasta el futuro, y nunca cambiará. Solo que ahora se ha embarcado en un nuevo viaje.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Welt',
  biography_es_translated = false
where id = 'hsr-welt';
update public.characters set
  biography_en = 'Judge of the Ten-Lords Commission, which presides over the jurisdiction of life and death on the Luofu. For years after her death, she inhabited a puppet body and returned to the world to fulfill her mission.

One of the judges of the Ten-Lords Commission on the Luofu. She is in charge of "detention" among the four judges of detention, interrogation, incarceration, and punishment. With iron chain and Mara-Sunder Awl in hand in tireless pursuit of recidivists, she will forthwith ensnare and subdue them all. The mortal coil of her past being has been reduced to ashes. She is reanimated via a puppet body. For each villain she captures, she gets in return half a day in the world of the living.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Xueyi%2FLore',
  biography_es = '"Veredicto de redención kármica de los Diez Líderes".

Vestida de blanco nieve, la jueza salió de la calle en penumbra, lo que oscureció su huida final.

El hombre se acercó, pero el estridente temblor en su voz delataba su miedo: "¿Cómo que... no es suficiente atraparlos?".

Puede que haya comenzado con un "Cómo", pero no como una pregunta abierta, sino más bien como una pregunta retórica. El análisis semántico va y viene en la mente, y no hay otra información más que "el objetivo sabía claramente con quién había complicidad".

Ella decidió ejecutar la misión que se le había asignado de inmediato.

Los globos oculares, la frente, la barbilla, el corazón, el extracto glandular, la parte inferior del abdomen... Con una mirada, marcó todas las partes que podrían servir para un único golpe efectivo. A pesar de que los raposianos eran conocidos por sus reacciones rápidas, su oponente había quedado completamente expuesto, y una ronda...',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Xueyi',
  biography_es_translated = false
where id = 'hsr-xueyi';
update public.characters set
  biography_en = 'General Jing Yuan''s retainer. A gifted swordsman who hasn''t even come of age. No one can best Yanqing when he holds a sword in hand.

The spirited lieutenant of the Xianzhou Luofu, and also its most proficient swordsman. He was born for the sword and is obsessed with it. Whenever a sword rests in Yanqing''s hand, none would dare underestimate this genius still in the early days of his youth. Perhaps the only thing capable of dulling his treasured blade''s sharp edge is time.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Yanqing%2FLore',
  biography_es = 'El teniente más joven en la historia de los Nimbocaballeros, guardaespaldas del general Jing Yuan y coleccionista de espadas de la Comisión de Artesanía... Con todos estos títulos y los rumores en torno a este niño prodigio, es increíble que solo sea un niño.

Desde que tenía uso de razón, Yanqing sigue a Jing Yuan como una sombra y ayuda a la Sede de la Premonición Divina a resolver sus problemas. A cambio, Jing Yuan le enseñó técnicas de espada y el arte de la guerra. Después de años de entrenamiento, la sabiduría de Yanqing es tan ágil e ingeniosa como su impecable espada.

Según la Doctrina marcial de los Nimbocaballeros, bloquear seis espadas voladoras al mismo tiempo es algo que el jefe instructor de los Nimbocaballeros no pudo dominar ni después de entrenar durante un siglo. La frase que todas las personas de Xianzhou usan para describir el talento en combate de Yanqing es: "Un espadachín dotado que nació para luchar".',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Yanqing',
  biography_es_translated = false
where id = 'hsr-yanqing';
update public.characters set
  biography_en = 'Head of the Sky-Faring Commission on the Xianzhou Luofu. Yukong was a seasoned pilot and a deadshot. Since heading up the commission, she''s been buried under mountains of paperwork.

The Xianzhou Luofu''s Head of the Sky-Faring Commission is gentle, yet seasoned and authoritative. Having been a pilot since young, she had become the commission''s head with her outstanding combat achievements, yet she no longer flies due to a particularly brutal battle. Now, her shine had already dimmed as she shifted her focus to official duties, but she is always seen guiding the course of the Luofu.',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Yukong%2FLore',
  biography_es = '"¿Sabes una cosa? Solo hay tres tipos de personas que pueden optar a entrar en la Comisión del Transporte Celeste.
Los que tienen el don de la palabra, los que buscan emociones y los que ansían volver a las estrellas. No hay excepciones".

Nosotros somos distintos a los nativos de Xianzhou, con sus vidas interminables. Aunque a los raposianos también se nos considera una raza de larga vida, solo vivimos unos tres siglos. Por eso, a muchos de nosotros nos apasiona más disfrutar de la diversión de la vida y buscamos la máxima intensidad con todo nuestro corazón y nuestra alma.

¿Yo? Ahora mismo tengo 246 años. Estoy con un pie en la tumba y mi tiempo de diversión ha quedado ya muy atrás. Quizá estés al corriente de mis apasionantes costumbres cuando era más joven.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Yukong',
  biography_es_translated = false
where id = 'hsr-yukong';
update public.characters set
  biography_en = 'A sword hunter from the Xianzhou Zhuming and "the Flaming Heart" General Huaiyan''s darling granddaughter. Frank and straightforward. She has learned swordplay and forging from Huaiyan since young, and thus is the second-youngest prodigy swordmaster of the Flamewheel Octet. Fueled by an intense loathing for the cursed swords that emerged from the Zhuming, she vowed to "hunt down and wipe out all cursed swords."',
  biography_source_en = 'https://honkai-star-rail.fandom.com/wiki/Yunli%2FLore',
  biography_es = 'Ver a su padre refinar espadas en el taller siempre estimulaba su hambre, más de lo normal, probablemente por el intenso calor que emitía la fragua. Como resultado, solía desaparecer entre dos y cuatro horas, durante las que se escabullía al mercado para llenarse la barriga, aparentemente para estar en mejor estado de ánimo para observar y aprender de su padre.

"Esta tienda sirve salchichas de carne más rápido que sus competidores. El chef ensarta las salchichas con maestría, y las atraviesa por el centro con una simetría perfecta. Si aprendiera a blandir espadas, probablemente adoptaría un estilo de lucha enérgico". Eso fue lo que pensó mientras se ponía al final de la fila.

Las bolas de arroz con sésamo de esa tienda normalmente eran preparadas por la propietaria, pero su marido se había encargado hoy de hacerlas. Su antebrazo estaba mucho más tonificado que la parte superior del brazo, posiblemente debido al entrenamiento regular con cuchillas.',
  biography_source_es = 'https://honkai-star-rail.fandom.com/es/wiki/Yunli',
  biography_es_translated = false
where id = 'hsr-yunli';

-- ---------------------------------------------------------------------------
-- Zenless Zone Zero (27 personajes)
-- ---------------------------------------------------------------------------
update public.characters set
  biography_en = 'A mysterious young girl who never talks about her past, almost as if she didn''t have one. She is calm and collected, and unusually competent and efficient in combat, almost as if she''d had years of training. In an unexpected incident, Nicole brought her back to the Cunning Hares, and she''s has an emotional independence on her ever since. She loves watching movies, but due to certain lack of common sense she seems to almost think them real-life stories.

Anby Demara is a highly skilled member of the Cunning Hares and a former soldier of the New Eridu Defense Force. Though she lacks basic social skills, Anby makes up for it with her advanced combat prowess and Hollow knowledge gained from her genetic cloning and time as Soldier 0.

Anby has two notable special interests: movies and hamburgers, the former she uses as reference for real life events, and the latter her favorite food due to its taste, affordability, and complete nutritional value.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Anby%2FLore',
  biography_es = 'Una joven misteriosa que nunca habla de su pasado, casi como si no tuviera ninguno. Es serena y templada, y en combate resulta inusualmente competente y eficaz, como si llevara años entrenando. Tras un incidente inesperado, Nicole la llevó con las Liebres Astutas, y desde entonces depende emocionalmente de ella. Le encanta ver películas, pero por cierta falta de sentido común parece tomárselas casi como historias reales.

Anby Demara es una integrante muy capaz de las Liebres Astutas y antigua soldado de la Fuerza de Defensa de Nueva Eridu. Aunque carece de habilidades sociales básicas, lo compensa con su destreza en combate y su conocimiento de los Hollows, adquiridos durante su clonación genética y su etapa como Soldado 0.

Anby tiene dos aficiones muy marcadas: el cine y las hamburguesas. Las primeras le sirven de referencia para interpretar la vida real; las segundas son su comida favorita por su sabor, su precio y su valor nutricional.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Anby%2FLore',
  biography_es_translated = true
where id = 'zzz-anby';
update public.characters set
  biography_en = 'Leads Others in His Passion for Work A senior staff member of Belobog Industries, he''s an onsite project manager who''s always ready to go. Energetic and Reliable He''s full of vigor and always rises to the occasion. Kind-Hearted Despite Appearances With a sharp tongue but a soft heart, he can''t say "no" to those in need. Strong, Sincere & Straightforward Open and honest, nothing can seem to upset him.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Anton%2FLore',
  biography_es = 'Contagia a los demás su pasión por el trabajo: veterano de Industrias Belobog, es un jefe de obra siempre dispuesto a arrancar. Enérgico y de fiar, rebosa vigor y siempre está a la altura de las circunstancias. De apariencia dura pero buen corazón: tiene la lengua afilada y el alma blanda, y es incapaz de decir "no" a quien lo necesita. Fuerte, sincero y directo: es tan abierto y honesto que nada parece capaz de amargarle el día.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Anton%2FLore',
  biography_es_translated = true
where id = 'zzz-anton';
update public.characters set
  biography_en = 'Strong Body & Honest Soul Those paws could shatter bones, luckily they''re busy tapping away on a calculator. Has His Fish and Eats It Too Finds an easy ballance between fighting thugs with his pillar on the battlefield and returning to accounting at the times of peace... The only thing that could make it all better is a jar of caviar. Fuzzy Fur, No Fuzzy Math Naturally sensitive to all things numerical, he''s careful in his bookkeeping, and has memorized all 58 account ledgers in his office. Repays Recognition With Loyalty After 1 year and 321 days of employment, Koleda promoted him to Head of Finance, and he''s followed her faithfully ever since.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Ben%2FLore',
  biography_es = 'Cuerpo fuerte y alma honesta: esas zarpas podrían romper huesos, pero por suerte están ocupadas tecleando en una calculadora. Sabe compaginarlo todo: alterna sin problema entre repartir mamporros con su pilar en el campo de batalla y volver a la contabilidad en tiempos de paz... Lo único que podría mejorarlo es un tarro de caviar. Mucho pelo, pero ninguna cuenta peluda: es sensible por naturaleza a todo lo numérico, cuidadoso con sus libros y se ha memorizado los 58 libros de cuentas de su oficina. Devuelve el reconocimiento con lealtad: tras 1 año y 321 días de trabajo, Koleda lo ascendió a jefe de finanzas, y desde entonces la sigue con absoluta fidelidad.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Ben%2FLore',
  biography_es_translated = true
where id = 'zzz-ben';
update public.characters set
  biography_en = 'A handsome android with a casual and carefree personality. He''s an avid fan of the Starlight Knight show, not only referring to himself as one of the Starlight Knights, but repeating many classic lines from the show. Refers to his pair of special custom-made high-caliber revolvers as "the girls". They appear to have been a gift from an old friend. He may look unreliable, but once he gets serious Billy can take on any challenge.

"The White Chariot" of the Cunning Hares and Former "Red Scarf" of Calydon, Billy Kid is an Intelligent Construct made for combat. Despite having a childish personality and fascination for the TV show Starlight Knight and the idol Monica, Billy is a skilled and powerful fighter, having once been an Outer Ring Champion and being able to outmatch Lighter in a fistfight.

Armed with a pair of revolvers, Billy fights countless threats inside Hollows as part of his job, though he does have a tendency to forget his ammo count.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Billy%2FLore',
  biography_es = 'Un androide atractivo de carácter despreocupado y campechano. Es fan acérrimo de la serie El Caballero Estelar: no solo se considera uno de sus caballeros, sino que repite muchas de sus frases más célebres. A su pareja de revólveres de alto calibre hechos a medida los llama "las chicas", y parecen haber sido el regalo de un viejo amigo. Puede parecer poco de fiar, pero cuando se pone serio, Billy es capaz de afrontar cualquier reto.

"El Carro Blanco" de las Liebres Astutas y antiguo "Pañuelo Rojo" de Calydon, Billy Kid es un constructo inteligente creado para el combate. Pese a su personalidad infantil y su fascinación por El Caballero Estelar y la ídolo Monica, Billy es un luchador hábil y poderoso: llegó a ser campeón del Anillo Exterior y puede superar a Lighter en un combate cuerpo a cuerpo.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Billy%2FLore',
  biography_es_translated = true
where id = 'zzz-billy';
update public.characters set
  biography_en = 'Mixologist, fuel chemist, and pyromaniac, Burnice White can be considered the jack-of-all-trades of the Sons of Calydon. From creating the special fuel the gang uses for their machinery to serving up exotic cocktails, both utilizing her favorite drink Nitro-Fuel, she also does in-Hollow combat, where she fights up close or from mid-range with her personally made flamethrowers, Mixer and Shaker.

Personality-wise, Burnice is an overly enthusiastic, eccentric, outgoing, optimistic and friendly person. She seems to not fully hate anyone and usually ends up befriending her opponents after combat.

Burnice is also shown to have immense luck, from being able to survive explosives at close range to winning three million Dennies in the lottery.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Burnice%2FLore',
  biography_es = 'Coctelera, química de combustibles y pirómana, Burnice White puede considerarse la mujer orquesta de los Hijos de Calydon. Lo mismo fabrica el combustible especial que la banda usa en su maquinaria que sirve cócteles exóticos, en ambos casos con su bebida favorita, el Nitrocombustible. Además combate dentro de los Hollows, donde pelea de cerca o a media distancia con sus lanzallamas caseros, Mixer y Shaker.

En lo personal, Burnice es entusiasta hasta el exceso, excéntrica, extrovertida, optimista y cercana. No parece odiar a nadie del todo y suele acabar haciéndose amiga de sus rivales tras el combate.

También goza de una suerte inmensa: ha sobrevivido a explosiones a bocajarro y ha ganado tres millones de dennies en la lotería.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Burnice%2FLore',
  biography_es_translated = true
where id = 'zzz-burnice';
update public.characters set
  biography_en = 'Yes! It''s the formidable leader of the Sons of Calydon, Caesar! She must have faced many difficulties as the leader of the Sons of Calydon to bring the gang to where it is today, right? "Huh? Not at all! The Sons of Calydon of today is a testament to everyone''s hard work!"

"I''m Caesar herself, the leader of Sons of Calydon." Caesar King "Take a seat anywhere you like. Make yourself at home." "As you''ve come all the way to the Outer Ring, consider yourself a guest of the Sons of Calydon!" "Uhh... Big Daddy, what does she mean by ''the exchange of gifts''?"',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Caesar%2FLore',
  biography_es = '¡Sí! Es la formidable líder de los Hijos de Calydon, ¡Caesar! Habrá tenido que superar muchas dificultades al frente de la banda para llevarla hasta donde está hoy, ¿verdad? "¿Eh? ¡Para nada! ¡Los Hijos de Calydon de hoy son el resultado del esfuerzo de todos!".

"Soy Caesar en persona, la líder de los Hijos de Calydon". Caesar King. "Siéntate donde quieras. Estás en tu casa". "Ya que has venido hasta el Anillo Exterior, ¡considérate invitada de los Hijos de Calydon!". "Eh... Papá Grande, ¿a qué se refiere con lo del intercambio de regalos?".',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Caesar%2FLore',
  biography_es_translated = true
where id = 'zzz-caesar';
update public.characters set
  biography_en = 'Corin Wickes is a young maid working for Victoria Housekeeping Co. who has notable self esteem and confidence issues. Once a sickly girl who required major surgery, Corin is now an exceptional combatant who takes an intimidating and devastating ''chainsaw'' with her wherever she goes, be it for in-Hollow commissions, for maid-related tasks, and for everyday life. Though timid, lacking self-esteem and constantly apologizing for anything and everything, Corin is one of Victoria Housekeeping''s most reliable members, sporting a flawless performance and never failing to fulfill her tasks. On rare occasions, Corin shows notable initiative and confidence; at times like this, she rarely stutters or apologizes.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Corin%2FLore',
  biography_es = 'Corin Wickes es una joven doncella de Victoria Housekeeping con serios problemas de autoestima y confianza. Antes era una niña enfermiza que necesitó una operación importante; hoy es una combatiente excepcional que lleva consigo una intimidante y devastadora "motosierra" a todas partes, ya sea para encargos dentro de un Hollow, para sus tareas domésticas o para el día a día. Aunque es tímida, insegura y se disculpa constantemente por todo, Corin es una de las integrantes más fiables de Victoria Housekeeping: su desempeño es impecable y nunca deja una tarea sin cumplir. En contadas ocasiones muestra una iniciativa y una seguridad notables; en esos momentos, rara vez tartamudea o pide perdón.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Corin%2FLore',
  biography_es_translated = true
where id = 'zzz-corin';
update public.characters set
  biography_en = 'Ellen Joe is a laid-back Shark Thiren that attends school in New Eridu who hates activities that require energy. Despite her personality and aloofness, Ellen is a significantly popular student at the school, though she prefers spending time with fellow students Ruby, Monna, and Lynn at karaoke bars, Godfinger and more.

Ellen''s school life is balanced with her job as a maid for Victoria Housekeeping Co., where she specializes in security management and garden maintenance. Though she dislikes physical activities, the support of her teammates that she considers her friend as well, allow her to unleash formidable power, becoming a significant threat in combat.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Ellen%2FLore',
  biography_es = 'Ellen Joe es una tiren tiburón de carácter tranquilo que estudia en Nueva Eridu y detesta cualquier actividad que exija energía. Pese a su personalidad distante, es una alumna bastante popular en el instituto, aunque prefiere pasar el rato con sus compañeras Ruby, Monna y Lynn en karaokes, en el Godfinger y sitios por el estilo.

Compagina la vida escolar con su trabajo de doncella en Victoria Housekeeping, donde se especializa en seguridad y en el mantenimiento del jardín. Aunque le desagrada el esfuerzo físico, el apoyo de sus compañeras, a las que también considera amigas, le permite desatar un poder formidable y convertirse en una amenaza seria en combate.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Ellen%2FLore',
  biography_es_translated = true
where id = 'zzz-ellen';
update public.characters set
  biography_en = 'Grace Howard is the eccentric, machine-obsessed R&D specialist of Belobog Heavy Industries, and adoptive sister to Belobog''s current president, Koleda. She is responsible for the new-generation of in-Hollow Smart Machinery the company uses. Whilst having a notable interest in dismantling and examining machinery, Grace also sees creations of her own as her ''children,'' ready to protect them at any given moment. Outside of mechanics and engineering, Grace Howard is known for her acrobatic prowess in combat, capable of dodging various forms of gunfire and etheric attacks, whilst fighting back with a weaponized nail gun and electric grenades.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Grace%2FLore',
  biography_es = 'Grace Howard es la excéntrica especialista en I+D de Industrias Pesadas Belobog, obsesionada con las máquinas, y hermana adoptiva de Koleda, la actual presidenta. Es la responsable de la nueva generación de maquinaria inteligente que la empresa usa dentro de los Hollows. Además de su interés por desmontar y examinar aparatos, Grace considera a sus creaciones sus "hijas" y está dispuesta a protegerlas en cualquier momento. Fuera de la mecánica y la ingeniería, destaca por su agilidad acrobática en combate: es capaz de esquivar todo tipo de disparos y ataques etéricos mientras responde con una pistola de clavos modificada y granadas eléctricas.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Grace%2FLore',
  biography_es_translated = true
where id = 'zzz-grace';
update public.characters set
  biography_en = 'Asaba Harumasa is the carefree expert archer of Hollow Special Operations Section 6. A child prodigy with both bow and blade, Harumasa aids his teammates from afar, while also being able to switch to close combat if necessary. He has little interest in work, and tries his best to slack off, usually doing things to the acceptable minimum and napping for the rest of the job as he waits to clock out.

Harumasa''s life has been deeply impacted by Ether Aptitude Regression Syndrome, a health condition he was born with. The boon of an exceptional Ether aptitude is outweighed by the toll it takes on his body, which he uses as a reason to apply for sick leave. Due to the medicine he takes, Harumasa gained a liking for bitter flavors.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Harumasa%2FLore',
  biography_es = 'Asaba Harumasa es el despreocupado arquero experto de la Sección 6 de Operaciones Especiales de Hollows. Niño prodigio tanto con el arco como con la espada, apoya a sus compañeros desde la distancia y puede pasar al cuerpo a cuerpo si hace falta. El trabajo le interesa poco y hace lo posible por escaquearse: cumple el mínimo aceptable y dedica el resto de la jornada a echar una cabezada mientras espera a fichar la salida.

Su vida está muy marcada por el síndrome de regresión de aptitud etérica, una dolencia congénita. La ventaja de una aptitud etérica excepcional queda contrarrestada por el precio que le cobra al cuerpo, algo que él aprovecha para pedir la baja. Por la medicación que toma, Harumasa ha acabado tomándole gusto a los sabores amargos.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Harumasa%2FLore',
  biography_es_translated = true
where id = 'zzz-harumasa';
update public.characters set
  biography_en = 'This time we''re going to introduce Emma... Err, wait... I mean Kylie! No, that''s not quite right... Apparently, there''s another archive that is a little different. Is it perhaps... Jane? Last I heard it was Anne! Jane: "I didn''t expect you to know me so well. I''m delighted! Well, truth be told, it''s all true!"

"Well, last time was last time! This time, I''m telling the truth. Trust me~" Jane Doe What am I? A cat Thiren. You bet I''m the real deal. "*sigh*... Having such a rare lineage used to give me quite a headache." 
"Why would I lie to you? Meow~',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Jane%20Doe%2FLore',
  biography_es = 'Esta vez vamos a presentar a Emma... Eh, espera... ¡Quiero decir Kylie! No, tampoco es eso... Por lo visto hay otro archivo algo distinto. ¿Será quizá... Jane? ¡La última vez me dijeron que era Anne! Jane: "No esperaba que me conocieras tan bien. ¡Qué ilusión! Bueno, la verdad es que todo eso es cierto".

"¡Lo de la última vez fue la última vez! Esta vez digo la verdad, créeme~". Jane Doe. ¿Que qué soy? Una tiren gata. Puedes apostar a que soy auténtica. "*suspiro*... Tener un linaje tan raro solía darme más de un dolor de cabeza". "¿Por qué iba a mentirte? Miau~".',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Jane%20Doe%2FLore',
  biography_es_translated = true
where id = 'zzz-jane-doe';
update public.characters set
  biography_en = 'Small & Cute, With Some Fierce Combat Power She may be small, but can certainly wield that huge hammer. A Fierce Young Girl Who''s Also a President The young leader at the helm of Belobog Industries. A President Who Leads by Example She prefers to work out in the field, rather than being stuck at a desk. Leads by Example While Maintaining Her Cute Nature Her maturity sometimes gives way to occasional childishness. She''s a leader who sometimes needs to be taken care of by her followers.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Koleda%2FLore',
  biography_es = 'Pequeña y adorable, pero con una potencia de combate feroz: puede ser menuda, pero desde luego sabe manejar ese martillo enorme. Una joven fiera que además es presidenta: dirige Industrias Belobog desde la cúpula. Una presidenta que predica con el ejemplo: prefiere trabajar sobre el terreno antes que quedarse atrapada en un escritorio. Y una líder que conserva su lado tierno: su madurez deja paso de vez en cuando a la niña que lleva dentro, así que a veces son sus propios subordinados quienes tienen que cuidar de ella.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Koleda%2FLore',
  biography_es_translated = true
where id = 'zzz-koleda';
update public.characters set
  biography_en = 'The "Red Scarf" and Champion of the Sons of Calydon, Lighter is an incredibly skilled fighter having experience from his time as a mercenary and underground fighter. Armed with an engine powered gauntlet, his duty is to fight the Champions of other biker gangs, a task he excels in, given he calls himself "the undefeated Champion."

According to Lighter himself, he is , fainting from just the sight of blood. To counter this, he always wears a pair of sunglasses, which also help him manage an old eye injury from his fighting days.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Lighter%2FLore',
  biography_es = '"Pañuelo Rojo" y campeón de los Hijos de Calydon, Lighter es un luchador extraordinariamente hábil, curtido en su etapa de mercenario y de peleas clandestinas. Armado con un guantelete propulsado por un motor, su cometido es enfrentarse a los campeones de otras bandas de moteros, una tarea en la que destaca, no en vano se llama a sí mismo "el campeón invicto".

Según él mismo cuenta, se desmaya solo con ver sangre. Para evitarlo lleva siempre unas gafas de sol, que además le ayudan con una vieja lesión ocular de sus años de combate.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Lighter%2FLore',
  biography_es_translated = true
where id = 'zzz-lighter';
update public.characters set
  biography_en = 'Luciana de Montefio, whose full name is Luciana Auxesis Theodoro de Montefio, is the daughter of the current head of the prestigious New Eridu Montefio family. Her personality is usually akin to that of a , seemingly acting harsh when she actually is compassionate and kind underneath, which may have been caused by her severed family ties and Outer Ring life.

Referring to herself as solely Lucy, due to her real name being far too long and not wanting to be involved with her family, she now performs the role of "Boar Thiren Overseer" for the "Leaps and Bounds Express Services Co.," a name used by the Sons of Calydon for their official logistics business.

Due to Lucy being considered a missing person, with there being a sizable reward for her safe return to her family, she prefers to stay in the Outer Ring, seldomly returning to the city.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Lucy%2FLore',
  biography_es = 'Luciana de Montefio, de nombre completo Luciana Auxesis Theodoro de Montefio, es la hija del actual cabeza de la prestigiosa familia Montefio de Nueva Eridu. Suele mostrarse dura por fuera cuando en realidad es compasiva y bondadosa, algo que quizá tenga que ver con la ruptura con su familia y con su vida en el Anillo Exterior.

Se hace llamar simplemente Lucy, porque su nombre real es demasiado largo y no quiere saber nada de los suyos. Ahora ejerce de "supervisora de los tirenes jabalí" en la empresa de logística Leaps and Bounds Express, el nombre con el que los Hijos de Calydon gestionan su negocio oficial de transporte.

Como figura en la lista de personas desaparecidas y hay una jugosa recompensa por devolverla sana y salva a su familia, prefiere quedarse en el Anillo Exterior y rara vez vuelve a la ciudad.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Lucy%2FLore',
  biography_es_translated = true
where id = 'zzz-lucy';
update public.characters set
  biography_en = 'Can resolve any matter. The most trusted of attendants, and solid support for any team. Rational and wise, a true gentleman who can''t tolerate a single stain. Offers absolute loyalty to the one he decides to follow. Though outwardly sophisticated and rational, his innate feral character will reveal itself when faced with certain dangers.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Lycaon%2FLore',
  biography_es = 'Capaz de resolver cualquier asunto. El más fiable de los mayordomos y un apoyo sólido para cualquier equipo. Racional y sensato, todo un caballero incapaz de tolerar una sola mancha. Ofrece lealtad absoluta a aquel a quien decide servir. Aunque por fuera resulte sofisticado y racional, su carácter salvaje innato aflora cuando se enfrenta a ciertos peligros.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Lycaon%2FLore',
  biography_es_translated = true
where id = 'zzz-lycaon';
update public.characters set
  biography_en = 'The youngest Void Hunter to date and Chief of Hollow Special Operations Section 6, Hoshimi Miyabi is a woman who defies the status quo and uses Tailless, her family heirloom''s cursed blade, to protect the city of New Eridu and unveil the corruption within it. However, despite being the chief, Miyabi does little work related to it, with bureaucratic tasks being handled by Deputy Chief Tsukishiro Yanagi.

Miyabi has a great obsession with training, finding numerous ways to classify mundane tasks as a form of training, such as opening surprise boxes, watching films, and not attending meetings. The intensity of some of her training leads her to black out and enter a trance-like state, where''s she''s only capable of parroting the last word said by another.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Miyabi%2FLore',
  biography_es = 'La cazadora del Vacío más joven de la historia y jefa de la Sección 6 de Operaciones Especiales de Hollows, Hoshimi Miyabi es una mujer que desafía lo establecido y que usa Descolada, la hoja maldita heredada de su familia, para proteger Nueva Eridu y destapar la corrupción que la carcome. Sin embargo, pese a ser la jefa, apenas se ocupa de las tareas del cargo: de la burocracia se encarga la subjefa Tsukishiro Yanagi.

Miyabi está obsesionada con entrenar y encuentra mil maneras de clasificar actividades cotidianas como entrenamiento: abrir cajas sorpresa, ver películas o no asistir a reuniones. La intensidad de algunas de esas sesiones la lleva a desmayarse y entrar en una especie de trance en el que solo es capaz de repetir la última palabra que ha dicho otra persona.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Miyabi%2FLore',
  biography_es_translated = true
where id = 'zzz-miyabi';
update public.characters set
  biography_en = '"The best mackerel is always the one you haven''t eaten yet~" — Nekomiya Mana Spirited and mischievous, she likes to play tricks on others. Your wallet is her wallet. (Really... It''s hers now.) Athletic and daring, no Hollow is too dangerous for her. "Cats love fish" is actually an incorrect stereotype. But Nekomata does love fish... She''s seen a lot of cat-astrophy and "curiosity killed the cat" moments, and seen many a secret that can''t be told.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Nekomata%2FLore',
  biography_es = '"El mejor jurel siempre es el que aún no te has comido~" — Nekomiya Mana. Vivaracha y traviesa, le encanta gastar bromas a los demás. Tu cartera es su cartera (en serio... ya es suya). Atlética y atrevida, no hay Hollow demasiado peligroso para ella. Lo de que "a los gatos les encanta el pescado" es en realidad un tópico falso, pero a Nekomata sí que le encanta el pescado... Ha vivido un montón de situaciones de las que dejan pelos de punta y ha visto muchos secretos que no se pueden contar.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Nekomata%2FLore',
  biography_es_translated = true
where id = 'zzz-nekomata';
update public.characters set
  biography_en = 'The leader of the odd-job agency the Cunning Hares, who accept all kinds of Hollow-related commissions. She''s been on the streets for many years, and has a reputation among her peers as being exceedingly cunning. She''s been blacklisted by many clients due to her all-or nothing approach. She loves money, but is surprisingly bad at managing it, leaving the Cunning Hares constantly on the edge of bankruptcy and owing many debts.

Nicole Demara is the founder and current leader of the Cunning Hares odd-job agency. Despite taking on any and all Hollow-related commissions and typically charging a high commission fee, she struggles with finances, leading the Cunning Hares to frequently be in debt, sometimes bordering on bankruptcy.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Nicole%2FLore',
  biography_es = 'La líder de la agencia de encargos Liebres Astutas, que acepta todo tipo de trabajos relacionados con los Hollows. Lleva muchos años en la calle y entre sus colegas tiene fama de ser extremadamente astuta. Muchos clientes la han puesto en su lista negra por su forma de jugárselo todo a una carta. Adora el dinero, pero se le da sorprendentemente mal administrarlo, lo que mantiene a las Liebres Astutas al borde de la quiebra y llenas de deudas.

Nicole Demara es la fundadora y actual líder de la agencia de encargos Liebres Astutas. Pese a aceptar cualquier trabajo relacionado con los Hollows y cobrar comisiones altas, tiene problemas con las cuentas, así que el grupo vive endeudado y a veces rozando la bancarrota.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Nicole%2FLore',
  biography_es_translated = true
where id = 'zzz-nicole';
update public.characters set
  biography_en = 'We''re behind schedule! Today''s the day that we need to share the new archive with the Proxies! A petrolhead and a driver who often leaves her passengers feeling scared, that can only be Pi— Piper: "Buckled up? Then let''s go!"

"Ya need a lift? Then buckle up, buddy." Piper Wheel "If you get carsick, look out the window at the view, and you''ll feel better." "Next, it''s time for lil ol'' me to clock in and get to work." "Buckle~ Up~!"',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Piper%2FLore',
  biography_es = '¡Vamos con retraso! ¡Hoy es el día en que hay que compartir el nuevo archivo con los Proxies! Amante de los motores y conductora capaz de dejar a sus pasajeros muertos de miedo, solo puede ser Pi... Piper: "¿Cinturón puesto? ¡Pues allá vamos!".

"¿Necesitas que te lleve? Pues abróchate el cinturón, colega". Piper Wheel. "Si te mareas, mira el paisaje por la ventanilla y se te pasará". "Y ahora le toca a una servidora fichar y ponerse a trabajar". "¡Cinturón~ puesto~!".',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Piper%2FLore',
  biography_es_translated = true
where id = 'zzz-piper';
update public.characters set
  biography_en = 'Qingyi, or 01 Neo-Genesis VI, is an experienced Public Security officer and novice investigator. With a personally modified riot baton, she fights crime in New Eridu. The most notable thing about Qingyi is her mature personality, having built it off of Old Civilization media and her own very long life. She spends her free time with the elderly citizens of New Eridu, playing chess and drinking hot water. Compared to other Public Security officers, Qingyi is incredibly laid-back, from playing pranks on her other members to working with Proxies.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Qingyi%2FLore',
  biography_es = 'Qingyi, o 01 Neogénesis VI, es una veterana oficial de Seguridad Pública y una investigadora novata. Con una porra antidisturbios modificada por ella misma, combate el crimen en Nueva Eridu. Lo más llamativo de Qingyi es su personalidad madura, forjada a partir de los medios de la Vieja Civilización y de su propia y larguísima vida. Dedica su tiempo libre a los ancianos de Nueva Eridu, jugando al ajedrez y bebiendo agua caliente. Comparada con el resto de agentes de Seguridad Pública, Qingyi es tremendamente relajada: lo mismo gasta bromas a sus compañeros que colabora con los Proxies.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Qingyi%2FLore',
  biography_es_translated = true
where id = 'zzz-qingyi';
update public.characters set
  biography_en = 'Are you the new master? Rina from Victoria Housekeeping, at your service." "Oh my, would you look at the time? I just prepared some snacks~" "Allow me to bring them over for everyone~" "Ah! No, no thanks!!!" "W—We still have another interview next... We''ll be going now!"',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Rina%2FLore',
  biography_es = '"¿Es usted el nuevo señor? Rina, de Victoria Housekeeping, a su servicio". "Vaya, ¿ya es esa hora? Acabo de preparar algo de picar~". "Permítanme traerlo para todos~". "¡Ah! ¡No, no, gracias!". "Aún... aún tenemos otra entrevista después... ¡Nos vamos ya!".',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Rina%2FLore',
  biography_es_translated = true
where id = 'zzz-rina';
update public.characters set
  biography_en = 'Seth is a member of the Criminal Investigation Special Response Team. According to the archive, Seth is currently learning the ropes in Zhu Yuan''s team. He is full of passion, is hardworking, and looks forward to the day that he''ll be able to hold his own in his job~

""Captain, I''ll apprehend the perp!" Seth Lowell "First, gotta pretend to be completely harmless..." "Ah... saw right through me, huh?" "Well, whatever, guess it''s time we talk with our fists instead!"',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Seth%2FLore',
  biography_es = 'Seth es miembro del Equipo Especial de Respuesta de Investigación Criminal. Según el archivo, ahora mismo está aprendiendo el oficio en el equipo de Zhu Yuan. Le sobra entusiasmo, es muy trabajador y espera con ganas el día en que pueda valerse por sí mismo en el trabajo~

"¡Capitana, yo detendré al sospechoso!". Seth Lowell. "Primero hay que hacerse el inofensivo...". "Ah... me has calado, ¿eh?". "Bueno, da igual, ¡supongo que toca hablar a puñetazos!".',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Seth%2FLore',
  biography_es_translated = true
where id = 'zzz-seth';
update public.characters set
  biography_en = 'A model soldier who follows orders and stays loyal to the mission... At least that''s what Soldier 11 demands of herself. Weapons don''t need emotions, and need only follow orders... At least that''s what Soldier 11 tells herself. No matter how strong the enemy, just get fired up and face it head on... At least that''s what Soldier 11 does. She''s shed her weakness along with her name, leaving only resolve... At least that''s what Soldier 11 thinks.

A soldier with no name and an affinity for fire. Soldier 11 is a model soldier of the New Eridu Defense Force, serving as the primary responder and first striker for Obol Squad.

Though an exceptional by-the-books soldier, Soldier 11 has notable quirks, namely her love for spicy food (specifically super-spicy noodles from Sixth Street''s Waterfall Soup)
and a habit of calling Phaethon by a different codename on every occasion.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Soldier%2011%2FLore',
  biography_es = 'Una soldado modélica que cumple órdenes y se mantiene fiel a la misión... o al menos eso es lo que Soldado 11 se exige a sí misma. Las armas no necesitan emociones, solo obedecer... o al menos eso es lo que Soldado 11 se repite. Por fuerte que sea el enemigo, basta con encenderse y plantarle cara... o al menos eso es lo que Soldado 11 hace. Se ha desprendido de su debilidad junto con su nombre y solo le queda la determinación... o al menos eso es lo que Soldado 11 cree.

Una soldado sin nombre y con afinidad por el fuego. Soldado 11 es una militar ejemplar de la Fuerza de Defensa de Nueva Eridu y actúa como primera respondiente y punta de lanza del Escuadrón Óbolo.

Pese a ser una soldado excepcional y de manual, tiene manías llamativas: le apasiona la comida picante (en concreto los fideos superpicantes del Waterfall Soup de la Sexta Calle) y llama a Phaethon por un nombre en clave distinto cada vez.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Soldier%2011%2FLore',
  biography_es_translated = true
where id = 'zzz-soldado-11';
update public.characters set
  biography_en = 'Soukaku is the gluttonous, childlike Oni of Hollow Special Operations Section 6. She''s a powerful combatant who uses a custom made weapon known as an "Oni Blade Banner" in battle. Outside of battle, Soukaku has a notable interest in food, caring little about what she eats and hating when food is wasted. 

Even though Soukaku is stated to be older than her legal guardian, Tsukishiro Yanagi, Soukaku is still considered young for her species, requiring homeschooling and dependency on others.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Soukaku%2FLore',
  biography_es = 'Soukaku es la oni glotona e infantil de la Sección 6 de Operaciones Especiales de Hollows. Es una combatiente poderosa que usa en batalla un arma hecha a medida conocida como "estandarte de hoja oni". Fuera del combate, su gran interés es la comida: le da bastante igual lo que come y detesta que se desperdicie.

Aunque se dice que Soukaku es mayor que su tutora legal, Tsukishiro Yanagi, sigue considerándose joven para su especie, por lo que estudia en casa y depende de los demás.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Soukaku%2FLore',
  biography_es_translated = true
where id = 'zzz-soukaku';
update public.characters set
  biography_en = 'The Deputy Chief of Hollow Special Operations Section 6, Tsukishiro Yanagi is an ex-soldier and former administrative officer from the New Eridu Defense Force who has been infused with Oni blood. Her main jobs include general management, on-site support and being the guardian of her fellow member Soukaku; alongside all these duties, she usually finds herself having to complete the rest of the team''s tasks as well. Due to the unique personalities of the other Section 6 members, Yanagi''s seriousness and diligence classify her as the only "normal" member of the team. It is with her guidance, experience, and leadership that the primary on-field group''s powers combine into true combat power.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Yanagi%2FLore',
  biography_es = 'Subjefa de la Sección 6 de Operaciones Especiales de Hollows, Tsukishiro Yanagi es una exsoldado y antigua oficial administrativa de la Fuerza de Defensa de Nueva Eridu a la que se le ha infundido sangre oni. Sus funciones principales son la gestión general, el apoyo sobre el terreno y la tutela de su compañera Soukaku; además de todo eso, suele acabar completando también las tareas del resto del equipo. Dadas las peculiares personalidades de los demás miembros de la Sección 6, su seriedad y su diligencia la convierten en la única integrante "normal" del grupo. Es su guía, su experiencia y su liderazgo lo que hace que las capacidades del equipo de campo se combinen en auténtica potencia de combate.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Yanagi%2FLore',
  biography_es_translated = true
where id = 'zzz-yanagi';
update public.characters set
  biography_en = 'Officer 148; Zhu Yuan, is an exceptional PubSec officer and current captain of the Criminal Investigation Special Response Team. A skilled martial artist and sharpshooter, Zhu Yuan uses the custom-made and versatile ''Suppressor K22'' firearm in conjunction with swift punches and kicks to take down criminals. As a reputable officer, Zhu Yuan has a strict moral compass, looking down on criminals, but is shown to be okay with taking the assistance of Proxies if the situation calls for it.

Zhu Yuan is a notable perfectionist, having set herself high standards to the point she has a complex, though such perfectionism has granted her exceptional experience and a record of no unresolved cases. She also exhibits an obsession with neatness, namely when it comes to her uniform. She''s shown to be cautious around cats and other small furry animals due to the fur they shed.

Zhu Yuan is shown to have a good relationship with her parents.',
  biography_source_en = 'https://zenless-zone-zero.fandom.com/wiki/Zhu%20Yuan%2FLore',
  biography_es = 'La agente 148, Zhu Yuan, es una oficial excepcional de Seguridad Pública y actual capitana del Equipo Especial de Respuesta de Investigación Criminal. Experta en artes marciales y tiradora de élite, combina el arma personalizada y versátil "Supresor K22" con puñetazos y patadas rápidas para detener a los criminales. Como agente respetada, tiene una brújula moral estricta y mira por encima del hombro a los delincuentes, aunque acepta la ayuda de los Proxies cuando la situación lo requiere.

Zhu Yuan es una perfeccionista de manual: se ha impuesto un listón tan alto que le ha creado un complejo, si bien esa misma exigencia le ha dado una experiencia excepcional y un historial sin un solo caso sin resolver. También es obsesiva con la pulcritud, sobre todo con su uniforme, y desconfía de los gatos y demás animales peludos por el pelo que sueltan.',
  biography_source_es = 'https://zenless-zone-zero.fandom.com/wiki/Zhu%20Yuan%2FLore',
  biography_es_translated = true
where id = 'zzz-zhu-yuan';

-- ---------------------------------------------------------------------------
-- High School DxD (22 personajes)
-- ---------------------------------------------------------------------------
update public.characters set
  biography_en = 'Akeno is a beautiful young woman with a voluptuous figure, very long black hair and violet eyes. Her hair is usually tied in a very long ponytail, reaching all the way down to the floor with two strands sticking out from the top and sloping backward, with an orange ribbon keeping it in place.

Like most of the girls at Kuoh Academy, she wears the customary Kuoh Academy girls'' school uniform, along with black calf-length socks.

As revealed in the visual book with her data , her body measurements are [B102-W60-H89 cm] [B40-W24-H35 in]. Her body weight is [54 kg] [119 lbs] while her height is 168 cm (5 feet 6 inches).

In the anime, during battles, she often transforms her clothes into a traditional attire, consisting of a white with red accents, a red , and a pair of with white .

After Akeno has revealed her Fallen Angel side in front of Issei, she has one Devil wing and one Fallen Angel wing.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Akeno%20Himejima',
  biography_es = 'Akeno es una voluptuosa joven de la misma edad que Rias con un largo cabello negro y ojos violetas. Su cabello esta usualmente atado en una larga cola de caballo que le llega hasta las piernas con dos antenas que sobresalen de la parte superior que se inclinan hacia atrás, con un listón naranja que mantiene todo en su lugar. Como la mayoría de las chicas en la Academia Kuoh, ella lleva el uniforme escolar femenino de la academia Kuoh, junto con calcetines negros hasta la rodilla.

Cuando se reveló como un Ángel Caído delante de Issei en el Volumen 4, le creció un ala de Demonio y una de Ángel Caído.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Akeno%20Himejima',
  biography_es_translated = false
where id = 'dxd-akeno';
update public.characters set
  biography_en = 'Asia is a beautiful young girl with long blonde hair and green eyes. Her body measurements are [B83→85-W55-H81→83 cm]; her height is [155 cm] [5 feet 1 inch] and her body weight is [44→45 kg] [97→98 lbs]. Her hair flows all the way down to her back, with split bangs over her forehead and a single strand sticking out from the top and sloping backward.

Her former main attire consisted of a dark teal nun outfit with light blue accents, a white veil over her head with light blue accents, a brown satchel slung on her right hip (where she holds her Bible), and brown boots with black straps in an X-shaped pattern.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Asia%20Argento',
  biography_es = 'Asia es una chica de alrededor de 15-16 años de edad con un largo cabello rubio y ojos verdes. Su cabello largo llega hasta la espalda, con un flequillo dividido sobre la frente y un solo filamento que sobresale de la parte superior estilo ahoge, inclinándose hacia atrás. De todas las chicas del Club de Investigación de lo Oculto en términos de tamaño de los senos, los suyos parecen ser uno de los más "modestos". Sus medidas son Busto 83cm - Cintura 55cm - Cadera 81cm

Su traje principal consiste en un traje de monja azul oscuro con detalles en azul claro, un velo blanco sobre su cabeza con detalles en azul claro, un sachel marrón colgado a la derecha de la cadera (donde ella tiene su Biblia), y botas marrones con correas negras en un patrón de X.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Asia%20Argento',
  biography_es_translated = false
where id = 'dxd-asia';
update public.characters set
  biography_en = 'Azazel is a tall man appearing to be in his twenties with an average build, black hair, golden bangs, and black goatee. He also possesses twelve jet-black feathered wings that grow out from his back. It is described by Vali to be a never ending black.

During the Summit, Azazel wore a V-neck maroon long-coat with a wide, open high-collar that opens up at the hem. The long-coat also featured two black belts around the waist and four black bands on each arm, two of the bands at the wrist and the other two near the elbow. He wore grey slacks and brown shoes.

After the events in Volume 4, he loses his left arm, but replaces it with a prosthetic arm made from his Sacred Gear research.

When he served as a Chemistry teacher at Kuoh Academy, Azazel wore a knee-length dark blue blazer with a lighter blue dress shirt, a black waist coat, and a red tie. He wore faded-purple slacks and black dress shoes.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Azazel',
  biography_es = 'Azazel es un hombre de una estatura alta de ojos color violeta su cabello es de color negro salvo en la parte de adelante que lleva el color amarillo. También lleva un traje Kimono de color cafe claro y su cuidada barba.

En el volumen 4 el pierde el brazo debido al el enfrentamiento con katarea leviatan, es reemplazado por un brazo mecanico.

Azazel como Ex-jefe de los ángeles caídos posee 6 pares de alas.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Azazel',
  biography_es_translated = false
where id = 'dxd-azazel';
update public.characters set
  biography_en = 'Gasper is an effeminate-looking male with platinum blond hair and pinkish-violet eyes. His hair is styled in short bob cut with several small fringes over his forehead, and he has pointed ears. Kiba describes him as looking like a beautiful girl.

Unlike the rest of the boys of Kuoh Academy who wear the boys'' uniform, Gasper wears the Kuoh Academy girls'' school uniform with thigh-high socks, creating a Zettai Ryōiki (絶対領域, Absolute Territory).

Originally a coward and a shut-in with a very shy personality, Gasper likes to wear female clothing, claiming that girls'' clothes are cute. He also has a penchant for boxes, carrying one with him all the time. When Issei tried to give Gasper confidence, the former gave Gasper a paper bag to put over the latter''s face. However, Issei comments that whenever Gasper puts the paper bag on, the latter looks like a molester.

As the series progresses, with Issei and the Gremory group''s encouragement, Gasper begins to gain confidence and bravery.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Gasper%20Vladi',
  biography_es = 'Gasper es un chico de aspecto andrógino que tiene alrededor de la misma edad de Koneko con el cabello rubio platino y ojos de color rojo. A diferencia del resto de los chicos de la Academia Kuoh que usan el uniforme varonil, Gasper usa el uniforme de las chicas de la Academia Kuoh con largas calcetas negras que le llegan al muslo.

Originalmente es un cobarde y un introvertido, a Gasper le gusta usar ropa femenina, alegando que la ropa de las chicas es muy linda (para gran enfado de Issei). También tiene una inclinación por las cajas, llevando una con él todo el tiempo. A medida que avanza serie, Gasper comienza a ser más confiado y se vuelve más valiente.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Gasper%20Vladi',
  biography_es_translated = false
where id = 'dxd-gasper';
update public.characters set
  biography_en = 'Grayfia is a beautiful young woman with a voluptuous body, appearing to be in her early twenties with back-length silver hair that features a long braid on each side with small blue bows at the ends, while the rest is let down which ends in twin braids and red eyes (silver in the anime).

While on her days off as a maid, Grayfia''s normal outfit has few noticeable differences is that she looks younger, her eyes are red and she has a faded-pink scrunchy on her, as opposed to the blue maid outfit. Her outfit is a black shirt with golden-caramel accents at the edges of the shirt and spread horizontally near the bottom, with two light golden trims going down the shirt; and the shirt splits slightly above her stomach, exposing her midriff. Around her neck and shoulders is a long, cyan scarf made from light material that reaches her hips.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Grayfia%20Lucifuge',
  biography_es = 'Ella es una mujer hermosa tiene el cabello color plata y ojos celestes, y segun todas las chicas del Club de Investigaciones de lo Oculto es la Gran Onee-Sama, Issei afirma que supera a Rias en su figura y atributos.

Es una mujer tranquila y reservada, ademas de muy estricta. Siempre toma encerio su trabajo mientras trabaja como sirvienta de la casa Gremory.

Cuando esta en sus días Libres se convierte en La Esposa de Sirzech Lucifer, madre de Millicas Gremory y la Onne-sama de Rias Gremory, ella tambien toma su papel como esposa de Sirzechs Lucifer muy enserio y aparece como una Dama de Clase alta, Es muy amable pero estricta.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Grayfia%20Lucifuge',
  biography_es_translated = false
where id = 'dxd-grayfia';
update public.characters set
  biography_en = 'Irina is a beautiful young woman with violet eyes. She has long chestnut hair that is usually tied into twintails, each held with a blue scrunchy, but on some occasions, she lets her hair down. Her body measurements are B87-W59-H89 cm [B34-W23-H35 in]; height is 164 cm (5 feet 4 inches) and body weight is 56 kg.

She wears the standard Church battle attire, same as Xenovia''s with some slight differences. After transferring to Kuoh Academy and moving into the Hyoudou Residence, she starts wearing the Kuoh Academy girls'' school uniform, with black short shorts under her skirt and the addition of white sneakers with blue accents.

Following her Angelization by Michael, she wears a red "A" printed on her right hand, symbolizing her position as Michael''s Ace. Irina also gained white Angel wings and a halo, as of Volume 17, she has a total of 4 wings.

Irina is a cheerful, goofy, upbeat, and enthusiastic person.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Irina%20Shidou',
  biography_es = 'Irina es una joven de alrededor de la edad de Issei con un largo cabello castaño claro y ojos de color violeta. Su cabello esta usualmente agarrado en dos coletas, cada una con una liga azul, pero en algunas ocasiones de deja el cabello suelto.

Ella usaba el traje de batalla estándar de la iglesia durante su volumen introductorio. Después al ser transferida a la Academia Kuoh y mudarse a la residencia Hyōdō, comienza a utilizar el uniforme femenino escolar de la academia Kuoh, con la adición de zapatillas blancas con detalles en azul y un leotardo negro debajo de la falda. Después de su Angelización por Michael, usa una A roja impresa en la mano derecha, que simboliza su posición como As de Michael.

Irina es una persona alegre, despreocupada, optimista, amigable, algo infantil y entusiasta.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Irina%20Shidou',
  biography_es_translated = false
where id = 'dxd-irina';
update public.characters set
  biography_en = 'Issei is an average high school student with short, spiky brown hair, two short locks of hair behind his head, and light brown eyes. He gained a more muscular and toned build following his training with Tannin.

While he has worn various outfits throughout the series, his most commonly worn outfit is the Kuoh Academy boys'' school uniform, which consists of a blazer (more commonly black, although in other media is shown with a tinge of purple or grey, with white accents) over a white, long-sleeved dress shirt with black highlights with a black ribbon on the collar, matching black pants, and brown dress shoes. 

However, Issei''s uniform differs in the fact that he wears a red T-shirt underneath his open dress shirt and blazer and wears blue (recently red) and white sneakers in place of dress shoes.

Before fighting Riser in a rematch, Issei''s left arm was transformed into a Dragon''s arm, which needed a ritual performed regularly by Rias and Akeno to appear human.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Issei%20Hyoudou',
  biography_es = 'Issei es un hombre joven en sus años de adolescencia con un cuerpo promedio, de pelo corto castaño con varios flequillos que cubren parcialmente sus cejas y dos extensiones de cabello que cuelgan paralelamente a su nuca y ojos marrones. Después de su entrenamiento con Tannin, él obtuvo una complexión más musculosa y tonificada.

Mientras que él ha usado varios trajes en toda la serie, su traje más comúnmente usado es el uniforme de la Academia Kouh, que consiste en una Chaqueta (más comúnmente negro, aunque en otros medios se muestra con un tinte de color púrpura o gris, con detalles en blanco) sobre una camisa de manga larga blanca reflejos negros con un lazo negro en el cuello, pantalones negros a juego y zapatos de vestir cafés. Sin embargo, Issei usa diferente el uniforme en el hecho de que lleva una playera roja debajo de su camisa y chaqueta, y lleva zapatillas de deporte blancas y azules en lugar de zapatos de vestir.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Issei',
  biography_es_translated = false
where id = 'dxd-issei';
update public.characters set
  biography_en = 'Yuuto is a handsome young man with short blond hair, blue eyes (bluish-gray eyes in the anime), and a mole underneath his left eye.

He wears the Kuoh Academy boys'' school uniform, which consists of a black blazer with white accents over a white, long-sleeved dress shirt with a black ribbon on the collar, matching black pants, and brown dress shoes.

Yuuto is, overall, an upbeat person and cares deeply for his comrades. He''s also a very polite and friendly individual, even considering Issei''s initial dislike towards him. As a Knight, he has pride, chivalry, dignity, and honor befitting one, and is shown to enjoy fighting fellow swordsmen like Karlamine.

Initially, he had a deep hatred towards the Holy Swords or their wielders.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Yuuto%20Kiba',
  biography_es = 'Yūto es un joven con el cabello corto rubio y ojos grises. Al igual que Issei y el resto de los chicos de la Academia Kuoh, lleva el uniforme escolar masculino, que consiste en una chaqueta de color negro con detalles en blanco sobre una camisa manga larga blanca de vestir con un lazo negro en el cuello, pantalones negros y zapatos de vestir cafés.

Yūto es generalmente una persona optimista, respetuoso y se preocupa profundamente por sus compañeros. Él también es una persona muy amable cuando se trata de su forma de ser y su personalidad, incluso teniendo en cuenta la aversión inicial de Issei hacia él.

ÉL le tenía un profundo odio hacia las espadas sagradas hasta el Volumen 3, cuando los miembros del Club de Investigación Oculta y las almas de sus amigos, que eran víctimas del Proyecto espada sagrada, le ayudaron a superarlo.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Yuuto%20Kiba',
  biography_es_translated = false
where id = 'dxd-kiba';
update public.characters set
  biography_en = 'Koneko is a petite girl with white hair and gold eyes. Her body measurements are [B67-W57-H73 cm] [B26-W22-H29 in]. Her weight is [31 kg] [68 lbs]. The front of her hair has two long bangs going past her shoulders and several loose bangs hanging over her forehead, while the back has a short bob cut. She also wears a black cat-shaped hair clip on both sides of her hair, one of which contained the data on artificially making new Super Devils. 

She usually wears the Kuoh Academy girls'' school uniform, without the shoulder cape. Koneko''s height is 138 cm (4 feet 6 inches), making her one of the shortest female characters of the series.

In her Nekomata form, she grows a pair of white cat ears and a pair of matching white tails, and her pupils become more cat-like. In Volume 24, she gained three tails.

In her "Shirone Mode" that she used for the first time in Volume 16, Koneko can make herself grow older, and her attire consists of a short white kimono and a light blue skirt.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Koneko%20Toujou',
  biography_es = 'Koneko es una pequeña chica de unos 15 años de edad con el cabello blanco y los ojos de color avellana. En el frente, su cabello tiene dos flequillos largos que van más allá de sus hombros y varios flequillos sueltos colgando sobre la frente, mientras que la parte trasera tiene el cabello corto. También lleva un broche de cabello en forma de gato negro a ambos lados de la cabeza. Ella viste el uniforme femenino de la academia Kuoh, aunque sin la capa de los hombros. En su forma Nekomata, le crecen un par de blancas orejas de gato y una cola a juego, y sus pupilas se vuelven más felinas.

Al comienzo de la serie, Koneko tenía una personalidad muy fria, rara vez mostrando algún sentimiento o emoción, incluso cuando hablaba. También era la única en el grupo que no se llevaba bien con Issei, a menudo lo insultaba y le reprochaba su debilidad y su naturaleza pervertida, aunque también lo respetaba por nunca darse por vencido.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Koneko%20Toujou',
  biography_es_translated = false
where id = 'dxd-koneko';
update public.characters set
  biography_en = 'Kuroka is a beautiful young woman with a voluptuous figure, long black hair with split bangs, and hazel-gold eyes with cat-like pupils. Her body measurements are [B98-W57-H86 cm] [B39-W23-H35 in]; height is 161 cm (5 feet 3 inches) and body weight is [49 kg].

Her attire consists of a black kimono, a yellow obi, a set of golden beads, and an ornately detailed headband. The kimono features a red interior and it is open at her shoulders, giving view to her large breasts which rival those of Rias and Akeno in terms of size.

In her Nekomata form, which she is in all the time, she grows a pair of black cat ears and two black tails.

At first, Kuroka was shown to be rather malicious, with her aura described as being more "outright evil" when compared to the "vice" of Azazel''s. In the past, she was said to have murdered her previous master, as she was unable to gain control over her Senjutsu, and was driven mad as a result.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Kuroka',
  biography_es = 'Kuroka es una joven con una figura voluptuosa, tiene el pelo largo negro y ojos color avellana con pupilas felinas. Su vestimenta consiste en un kimono negro, faja amarilla, un juego de cuentas de oro, y una venda adornada detalladamente. El interior del kimono es rojo y está abierto en sus hombros, dejando a la vista sus grandes pechos que rivaliza con los de Rias y Akeno en términos de tamaño. En su forma de Nekomata, le aparecen un par de orejas de gato negro y dos colas negras.

Kuroka parece muy juguetona, despreocupada, y disfruta tomar el pelo a la gente. Ella es también vulgar, usando su belleza y sensualidad como un arma en su arsenal de burlas. Kuroka ama mucho a su pequeña hermana Koneko, aunque ella parece tener problemas para demostrarlo aveces, prefiriendo burlarse de ella. Ella ha expresado un interés en tener niños fuertes, y le ha hecho proposiciones tanto a Vali como a Issei, ya que ambos tienen Dragones Celestiales dentro de ellos.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Kuroka',
  biography_es_translated = false
where id = 'dxd-kuroka';
update public.characters set
  biography_en = 'Ophis'' current appearance is that of a cute young girl with long black hair down to her hips and black eyes (gray in the anime). Her ears differ from a normal human''s as they have pointed tips, although her long black hair makes this feature difficult to notice. Her dark grey eyes have reptilian slitted pupils. Azazel stated that Ophis had the appearance of an old man in the past before changing it. Her body measurements are [B66-W53-H70]; height is [137 cm] and body weight is [31 kg].

Her attire consists of a black Gothic Lolita fashion.

However, Ophis is a true shapeshifter, able to freely manipulate her body shape and size to assume any form that she chooses, regardless of her age, race, or gender. There''s been no hint thus far of her true Dragon form, only her current human disguise and it''s predecessor.

Ophis is an extremely "low-key" individual, with a distinctly subdued demeanor and muted emotions.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Ophis',
  biography_es = 'El aspecto actual de Ophis es el de una joven menuda y adorable, con el pelo negro y largo hasta las caderas y los ojos negros (grises en el anime). Sus orejas se diferencian de las de un humano normal por su punta afilada, aunque su larga melena hace difícil apreciarlo. Sus ojos, de un gris oscuro, tienen pupilas rasgadas de reptil. Azazel afirmó que Ophis tenía en el pasado la apariencia de un anciano antes de cambiarla. Su indumentaria consiste en un atuendo negro de estilo lolita gótico.

Sin embargo, Ophis es una auténtica cambiaformas, capaz de manipular libremente la forma y el tamaño de su cuerpo para adoptar el aspecto que desee, sin importar edad, raza o género. Hasta ahora no se ha visto ni un indicio de su verdadera forma de dragón: solo su disfraz humano actual y el anterior.

Ophis es un ser extremadamente discreto, de actitud contenida y emociones apagadas.',
  biography_source_es = 'https://highschooldxd.fandom.com/wiki/Ophis',
  biography_es_translated = true
where id = 'dxd-ophis';
update public.characters set
  biography_en = 'Ravel is a beautiful young girl with dark blue eyes. She has long blonde hair tied into twintails with large, drill-like curls and blue ribbons keeping them in place. The front of her hair has several bangs hanging over her forehead, with a V-shaped fringe hanging over the bridge of her nose. Ravel''s body measurements are [B85-W59-H84 cm] (B33-W23-H33 in); height is 153 cm (5 feet 0 inches) and body weight is [47 kg].

Her initial outfit consisted of a light purple dress with dark purple accents and a blue bow at the front. At the back, three feather-like extensions mimicking a bird''s tail protrude from the dress, which, when combined with her wings of fire, give her a bird-like appearance.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Ravel%20Phenex',
  biography_es = 'Ravel es una chica joven con el pelo largo y rubio y ojos azules oscuros. Su pelo está atado en dos coletas doble de grandes rizos, con cintas azules para mantenerlos en su lugar. Su equipo inicial consistió en un vestido de color morado claro con acentos de color púrpura oscuro y un arco azul en la parte delantera. En la parte trasera, tres extensiones de pluma que imitan la cola de un ave Fenix sobresalen del vestido, que, cuando se combina con sus alas de fuego, le dan una apariencia al Ave Fenix. Al transferirse a la Academia Kuoh, ella viste el uniforme de la academia Kuoh, con la adición de un suéter negro sobre su camisa de vestir. En el anime, Ravel lleva un vestido largo, de color rosa con adornos blancos y un arco magenta en la parte delantera.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Ravel%20Phoenix',
  biography_es_translated = false
where id = 'dxd-ravel';
update public.characters set
  biography_en = 'Rias is a beautiful young woman with a voluptuous body, white skin, blue eyes (blue-green in the anime, season 1-3) inherited from her father, Zeoticus, and a buxom figure. Her body measurements are [B99-W58-H90 cm] [B39-W23-H35 in]. Her body weight is [58 kg] [128 lbs]. 

Her most distinctive feature is her long, beautiful crimson hair, which she also inherited from her father, that reaches down to her thighs with a single hair strand (known in Japan as ahoge) sticking out from the top. Her hair also has loose bangs covering her forehead and side bangs framing her face. Rias'' height is 172 cm.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Rias%20Gremory',
  biography_es = 'Rias es una hermosa mujer con una figura muy hermosa, de piel clara con ojos azul celeste casi verdosos y un característico cabello color carmesí que le llega hasta los muslos, con una sola hebra de caballo (que en Japón se conoce como Ahoge (アホ毛), o el pelo idiota) que sobresale de la parte superior de su cabeza. También tiene largo el flequillo que a parte de tapar parte de su frente enmarca su cara al estar más largo por los laterales de esta. Aunque esta ha llevado varios tipos de ropa la que más usa es el uniforme para chicas de la academia, estando este compuesto de una camisa blanca de manga larga abotonada (aunque de manga corta para primavera/verano) con una cinta negra en el cuello de la camisa, también lleva una chaqueta sobre la camisa que le tapa los hombros y llega hasta tan solo algo más arriba de la cintura dejando así la camisa blanca sobre el pecho al descubierto. Por último tiene falda magenta con acentos blancos y zapatos de vestir marrones con calcetines altos.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Rias%20Gremory',
  biography_es_translated = false
where id = 'dxd-rias';
update public.characters set
  biography_en = 'Rossweisse is a beautiful young woman with long, straight silver hair and aqua-colored eyes who appears to be in her late teens. Her body measurements are [B96-W61-H89 cm] [B38-W24-H35 in]; height is 173 cm (5 feet 8 inches) and body weight is [59 kg].

Her battle attire is normally of a set of Valkyrie armor, which consists of a white breastplate with gold and pale blue accents and matching, fingerless gauntlets, boots, hip guards, and wing-shaped hair clips. She also wears a black leotard underneath her breastplate, black thigh-high stockings, and a pale blue cloth wrapped underneath her hip guards, all of which are clad with pink lacing along with her hair clips.

For her teaching position at Kuoh Academy, she wears a simple business suit and skirt.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Rossweisse',
  biography_es = 'Rossweisse es una joven con un largo cabello blanco plateado y ojos azules. Su traje normalmente es el set de armadura de Valquiria, que consiste en un pectoral blanco con detalles en dorado y azul claro y manoplas sin dedos a juego, botas, protectores de cadera y clips para el cabello en forma de alas. Ella también lleva un maillot negro debajo de su pectoral, medias negras hasta el muslo y una envoltura de tela azul pálido debajo de los protectores de la cadera, todo lo cual está revestido con cordones rosas.

Para su puesto de profesora en la Academia Kuoh, ella lleva un traje formal con falda.

Rossweisse es una persona muy seria. Ella tiene una tendencia a comprar cosas en las ventas cuando son baratas, lo que hace que Issei la llame "Valquiria de Tienda de 100-Yen". Ella es extremadamente amargada a causa de no tener un novio y se enoja cuando se burlan de eso.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Rossweisse',
  biography_es_translated = false
where id = 'dxd-rossweisse';
update public.characters set
  biography_en = 'Sairaorg is a handsome young man with black hair and violet eyes. He is very tall and has a muscular build due to the extreme training he has done. Issei notes that his face resembles that of his cousins Rias and Sirzechs. His height is [194 cm] and body weight is [135 kg].

Sairaorg has a noble and calm personality and greatly respects his opponents. He also likes to fight strong people, to the point that Rias Gremory, his own cousin, called him a battle maniac. He is shown to be a kind-hearted and compassionate person and has a very straightforward personality. He even shows unconditional kindness to his estranged half brother. Due to suffering discrimination from his traditionalist family, Sairaorg has become extremely open minded. Unlike his father and most of the Bael clan, he does not look down on other Devils based on blood purity and status, as reflected in his chosen peerage.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Sairaorg%20Bael',
  biography_es = 'Sairaorg es un hermoso joven de pelo negro y ojos violetas. Él es muy alto y tiene un cuerpo muscular debido al entrenamiento extremo que ha realizado trae un keikogi color negro y unos zapatos clásicos y un cinturón gris que usa para cerrar su chaqueta ya que usa la ropa debido a que es maestro en artes marciales

Sairaorg tiene una personalidad noble y respeta a sus oponentes. Le gusta pelear con personas fuertes, sobre todo con Issei. Ha demostrado ser una persona buena y muy honesta.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Sairaorg%20Bael',
  biography_es_translated = false
where id = 'dxd-sairaorg';
update public.characters set
  biography_en = 'Serafall is a beautiful girl, looking in her late teens with black hair tied into twin tails and blue eyes (Pink in seasons 2-3). She also has a child-like body (albeit with large breasts). Her body measurements are B85-W56-H80 cm; her height is 160 cm, and her body weight is 48 kg.

Due to her hobby and interest in magical girls, she occasionally dresses in magical girl''s clothing (from Magical Girl Milky Spiral Seven, the same outfit Mil-tan wears), magic wand and all, prompting Issei to call her the nickname "Satan Girl" ( , Maō Shōjo).',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Serafall%20Leviathan',
  biography_es = 'Serafall es una mujer hermosa con el pelo largo y negro atado en dos colas a cada lado usando dos listones de color fucsia y sus ojos son de tono purpura. Ella tiene un cuerpo como el de una niña (aunque con grandes pechos), generalmente se viste con ropa de chica mágica (de Magical Girl Láctea Espiral Siete, el mismo traje que Mil-tan viste), llevando de accesorio una varita mágica con forma de estrella, lo que provoca que Issei le de el apodo "Niña Satanás".

A diferencia de su hermana menor Sona, Serafall tiene una personalidad un tanto infantil, que se evidencia cuando llama a su hermana "Sona-chan" o "So-tan" y Sirzechs "Sirzechs-chan". Agregando a su personalidad infantil es el hecho que la mayor parte de su frases terminan con una estrella.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Serafall%20Leviat%C3%A1n',
  biography_es_translated = false
where id = 'dxd-serafall';
update public.characters set
  biography_en = 'Sirzechs is a handsome man who seems to be in his early 20''s. He has shoulder length crimson hair and blue eyes (blue-green in the anime season 1-3) inherited from his father, Zeoticus, similar to Rias. In fact, Issei has described him as the male version of Rias.

In his true form, Sirzechs takes the form of the Destruction in the shape of a human with crimson aura.

As a Gremory, Sirzechs is shown to be very kind and caring towards others, preferring to have things sorted out through talking instead of fighting. He also has a very laid-back personality, preferring to do things at his own pace and causing his wife to punish him for it. Humorously, when he''s up to his usual antics, the mere mention of his wife''s name is enough to make him apologize immediately. However, Sirzechs does have a serious side, which he has only revealed twice: during his fight against Creuserey Asmodeus and his confrontation with Hades.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Sirzechs%20Lucifer',
  biography_es = 'Es de aspecto bien parecido, tiene el cabello largo color Rojo carmesí, lleva puesta una túnica violeta y gris con bordes y decoraciones dorados, y por debajo un traje blanco y gris con bordes y cinturón violetas.

Es una persona muy tranquila, educada e Inteligente aunque también le gusta tomar acciones divertidas. Aunque es muy celoso ya que cuando Millicas prefirió a Oppai Dragon en vez del Satan Rojo y vio que se llevaba bien con Issei, retó a una batalla a Issei para ver quien era mejor, por suerte no se enteró lo de Issei y Grayfia en el Onsen, de lo contrario, habría matado a Issei. También es un siscon dejando siempre a Rías en situaciones vergonzosas. Tiende a apresurar mucho varías cosas, como el dar por echo demasiado deprisa que Issei estaba por Rías y hacer que se comprometan antes de tiempo.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Sirzechs%20Lucifer',
  biography_es_translated = false
where id = 'dxd-sirzechs';
update public.characters set
  biography_en = 'Sona is a bespectacled young woman with a slim figure, black hair styled in a short bob cut, and violet eyes. Her body measurements are [B77-W57-H83 cm] [B30-W22-H33 in]; her height is 166 cm (5 feet 5 inches) and her body weight is [51 kg].

She is usually seen dressed in the Kuoh Academy girls'' school uniform.

Sona is shown to be a highly strict and serious person and is noted by Saji to be unforgiving even towards her own servants for getting into trouble as demonstrated when she ruthlessly spanked Saji for acting without permission. Whether it is a matter of the Student Council or the Sitri Clan, she does not take anything lightly.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Sona%20Sitri',
  biography_es = 'Sona es una joven, aparentemente de la misma edad de Rias, de cabello negro y corto, y de ojos Violetas. Ella lleva un par de gafas de color rojo y el uniforma escolar distintivo de las chicas de la Academia Kuoh.

Es de carácter Tranquila y Fuerte a la igual de ser Estricta y muy Inteligente. Le gusta el orden como le ha caracterizado con sus sirvientes.

Sin embargo, le gusta estar en un ambiente tranquilo y le gusta el compañerismo (cuando se asocia con Rias Gremory para enfrentarse a los peligros que acechan a la academia). También es muy competitiva con Rias. 

Su sueño es poder crear una escuela donde se enseñe a todos los demonios sin importar su Clase o procedencia sobre los Rating Games. Por este motivo acude a clases en el mundo humano para analizar su estructura y tomarla como ejemplo.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Sona%20Sitri',
  biography_es_translated = false
where id = 'dxd-sona';
update public.characters set
  biography_en = 'Tsubaki is a young bespectacled woman with long straight black hair that extends all the way down to her knees, with split bangs and heterochromic eyes, with a violet left eye and a light brown right eye (both light brown in the anime).

In addition to wearing the Kuoh Academy girls'' school uniform, she also wears blue, semi-rimmed glasses with square lenses.

Like Sona, Tsubaki has a serious personality and is rarely seen smiling. She also cares deeply for her teammates and is very loyal to Sona. However, ever since her fight with Yuuto Kiba, she began falling in love with him, which causes her to be very shy and flustered when around him to the point where she loses her usual calm demeanor. She is noted to like younger boys who would make her serious, making Yuuto a match in a sense. She is shown to be quite sensitive with regards to her feelings for Kiba and his friendship with Issei, as seen when she begged Ravel to stop reading out the manga based on Issei and Kiba.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Tsubaki%20Shinra',
  biography_es = 'Tsubaki es una mujer de 1,70 cm. de altura con el pelo negro hasta más de la mitad de la espalda. Tiene un flequillo abierto heterocrómico y ojos castaño claro. Utiliza el uniforme de la Academia Kuoh, aun que también lleva gafas azules (semi-montura con cristales cuadrados).

Al igual que su maestro, Tsubaki tiene una personalidad seria y rara vez se la ve sonriendo. También se preocupa profundamente por sus compañeros de equipo.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Tsubaki%20Shinra',
  biography_es_translated = false
where id = 'dxd-tsubaki';
update public.characters set
  biography_en = 'Vali is a handsome young man with light silver hair (dark silver in seasons 2-3) and hazel eyes (light blue in seasons 2-3). He is often seen wearing a dark green V-neck shirt with a high-collared black leather jacket over it. 

He also wears burgundy jeans with a silver chain drooping down over them and black leather chaps with three bands encircling his right calf, and black shoes with black buckles. 

As with other Devils, Vali has black bat-like wings on his back. 

However, unlike other Devils, he possesses a total of eight. Vali also bears a great resemblance to his grandfather, Rizevim Livan Lucifer. 

Vali''s height is 168 cm (5 feet 6 inches) and body weight is [60 kg].

While initially appearing to be a cold, arrogant, overconfident, and ruthless person, Vali has a calm, noble, and caring side to him, as he cares deeply for his comrades.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Vali%20Lucifer',
  biography_es = 'Vali es un joven apuesto de cabello plateado claro (plateado oscuro en las temporadas 2-3) y ojos color avellana (azul claro en las temporadas 2-3). A menudo se lo ve usando una camisa verde oscuro con cuello en V con una chaqueta de cuero negra de cuello alto sobre ella. El tambien usa jeans de color burdeos con una cadena plateada que cae sobre ellos y chaparreras de cuero negro con tres bandas que rodean su pantorrilla derecha, y zapatos casuales de color negro con hebillas negras. Al igual que otros demonios, Vali tiene alas negras de murciélago en su espalda. Sin embargo, a diferencia de otros demonios, el posee un total de ocho alas. Vali tiene un gran parecido con su abuelo Rizevim Livan Lucifer. La altura de Vali es de 168 cm (5 pies y 6 pulgadas) y su peso corporal es de 60 kg.

A pesar de que presenta una apariencia fría, arrogante, confiada y despiadada, Vali tiene un lado tranquilo y noble, preocupándose tanto de el mismo como de sus camaradas.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Vali%20Lucifer',
  biography_es_translated = false
where id = 'dxd-vali';
update public.characters set
  biography_en = 'Xenovia is a beautiful young woman with chin-length, blue hair with a dyed green fringe on the right side and brown eyes (dark yellow in the anime, season 2-3). She is also well-endowed with big breasts. Her body measurements are [B87-W58-H88 cm] [B34-W23-H35 in], and her body weight is [56 kg] [123 lbs]. Xenovia''s height 166 cm (5 feet 5 inches).

Her battle attire is her Church battle suit, which consists of a black, skin-tight, short sleeve leotard with pauldrons, matching fingerless gloves that extend to her biceps, and thigh-high boots, all of which are adorned with straps. This attire is worn under a white hooded cloak with gold and blue accents.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Xenovia',
  biography_es = 'Xenovia es una joven de alrededor de la edad de Issei con el cabello corto de color azul claro con un mechón verde a altura de la frente y ojos color café. Su traje principal es el traje de batalla de la Iglesia, que consiste en un leotardo ceñido de manga corta con hombreras, largos guantes sin dedos que se extienden hasta sus bíceps y botas hasta los muslos, todo adornado con cintas. Este equipo se usa debajo de un manto blanco con capucha con detalles en oro y azul. Ella también llevaba un crucifijo alrededor del cuello, que fue retirado más tarde, cuando se convirtió en un demonio. Al ser transferida a la Academia Kuoh e ingresar al Club de Investigación de lo Oculto, ella empieza a usar el uniforme escolar femenino de la Academia Kuoh.

Cuando se introdujo por primera vez a Xenovia, fue retratada con una actitud seria y tranquila, poniendo primero a su misión y habla sólo cuando es necesario, y prefiere no meterse en problemas que no le conciernen.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Xenovia%20Quarta',
  biography_es_translated = false
where id = 'dxd-xenovia';
update public.characters set
  biography_en = 'Yubelluna is a voluptuous woman with long, wavy purple hair that falls all the way down her back and matching eyes. At the front, the right side of her hair falls over her breast and covers her right eye, while the left side falls near the top of her skirt.

Her attire is a dress consisting of a navy blue tunic top with gold accents and a pale blue skirt with open sides, red high-heeled shoes, and overmatched thigh-high stockings with garter belts. The top reveals much of her cleavage and is held with a gold choker with blue and red jewels. Over this, she wears a white overcoat with black and gold accents and matching pauldrons. For accessories, she wears a black headband with a red-orange jewel over her forehead to keep her long hair in place and wields a staff-like scepter in battle.',
  biography_source_en = 'https://highschooldxd.fandom.com/wiki/Yubelluna',
  biography_es = 'Yubelluna es una mujer con grandes y notables pechos, con el pelo largo púrpura, ondulado que cae todo el camino por la espalda y los ojos a juego. En la parte delantera, el lado derecho de su cabello cae sobre el pecho y cubre su ojo derecho, mientras que el lado izquierdo cae cerca de la parte superior de la falda. Su traje es un vestido consiste en una tapa azul, una túnica azul marino con detalles en oro y una falda de color azul claro con lados abiertos; incluyendo además zapatos negros. La parte superior muestra gran parte de su escote, y presenta un collar de oro con piedras preciosas de color azul y rojo. Sobre esto, ella lleva un abrigo blanco con detalles en negro y oro y hombreras a juego. Para los accesorios, lleva una diadema negra con una joya de color rojo anaranjado sobre la frente para mantener el pelo largo en el lugar, y ejerce un bastón como cetro en las batallas.',
  biography_source_es = 'https://highschooldxd.fandom.com/es/wiki/Yubelluna',
  biography_es_translated = false
where id = 'dxd-yubelluna';

-- Resumen:
--   Genshin Impact: 119 en ingles, 113 de wiki espanola, 6 traducidos
--   Honkai: Star Rail: 81 en ingles, 72 de wiki espanola, 9 traducidos
--   Zenless Zone Zero: 27 en ingles, 0 de wiki espanola, 27 traducidos
--   High School DxD: 22 en ingles, 21 de wiki espanola, 1 traducidos
--   43 biografias espanolas son traduccion del texto oficial ingles.
--
-- Comprobacion: ambas cuentas deben devolver 249.
select count(*) from public.characters where biography_en is not null;
select count(*) from public.characters where biography_es is not null;
