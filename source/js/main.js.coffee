#= require 'engine/app.js'
#= require 'engine/debug.js'
#= require 'entities/entity.js'
#= require 'entities/sprite.js'
#= require 'tilemap/tilemap.js'
#= require 'engine/engine.js'
#= require 'engine/canvas.js'
#= require 'entities/entity_container.js'
#= require 'entities/hero.js'
#= require 'particles/particle_container.js'
#= require 'particles/particle.js'
#= require 'particles/red_volcano.js'
#= require 'engine/player_menu.js'
window.LEVEL2 = {
  width: 15,
  height: 20,
  data: [
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  ]
}

window.LEVEL1 = {
  width: 15,
  height: 20,
  data: [
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,   
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1, 
    1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,
    1,1,1,1,1,1,1,1,0,0,0,1,1,1,1, 
    1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,
    1,0,0,0,0,0,0,0,0,0,0,0,1,1,1, 
    1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1, 
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
    1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,
    1,1,1,1,1,1,0,0,1,1,1,1,1,1,1, 
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1, 
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1, 
    1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
    1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
  ]
}




# ==== START




window.addEventListener "load", ->
  debug "Start", SUCCESS
  canvas = new App.Canvas()
  engine = new App.Engine( canvas )
  if engine.init()
    debug("engile.init()", SUCCESS)
    tilemap = new App.TileMap()
    tilemap.load(window.LEVEL1);

    sprites = new App.EntityContainer()
    @hero = new App.Hero(tilemap)
    sprites.add( @hero )
    particles = new App.ParticleContainer(tilemap)
    red_volcano = new App.ParticleEmitters.RedVolcano( particles, 200, 180)

    player_menu = new App.PlayerMenu()

    # engine render/update pump
    engine.addCallback( tilemap )
    engine.addCallback( particles )
    engine.addCallback( sprites )
    engine.addCallback( player_menu )
    
    engine.addCallback( red_volcano )
    canvas.init_controller()
    canvas.add_controller_listener( @hero )

    @hero.set_menu_listener( player_menu )

    # start your engines
    engine.start()
  else
    debug("unable to engine.init()", ERROR)

