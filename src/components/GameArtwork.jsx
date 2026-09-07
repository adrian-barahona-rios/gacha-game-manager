// `fill` recorta el margen blanco del logo para que ocupe toda la caja. Solo
// es seguro en cajas anchas (las tarjetas): en una caja cuadrada cortaria los
// laterales de los logos apaisados, como el de Genshin.
function GameArtwork({ game, className, fill }) {
  if (game.image && game.imageFit === 'cover') {
    return (
      <img
        src={game.image}
        alt={game.name}
        loading="lazy"
        className={`h-full w-full object-cover ${game.imagePosition ?? ''} ${className ?? ''}`}
      />
    )
  }

  if (game.image) {
    return (
      <span
        className={`flex h-full w-full items-center justify-center overflow-hidden bg-gradient-to-br from-white to-zinc-200 ${
          fill ? '' : 'p-[8%]'
        } ${className ?? ''}`}
      >
        <img
          src={game.image}
          alt={game.name}
          loading="lazy"
          className={
            fill
              ? `h-full w-full object-cover ${game.imagePosition ?? ''}`
              : 'max-h-full max-w-full object-contain'
          }
        />
      </span>
    )
  }

  return (
    <span
      className={`flex h-full w-full items-center justify-center bg-gradient-to-br ${game.banner} ${className ?? ''}`}
    >
      <span className={`text-3xl font-bold tracking-tight ${game.glow}`}>
        {game.short}
      </span>
    </span>
  )
}

export default GameArtwork
