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
#= require 'particles/blue_smoke.js'

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
    0,0,0,0,0,0,0,48,0,0,0,0,0,0,0,
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
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,   
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48, 
    48,49,49,49,49,49,49,49, 0, 0, 0,49,49,49,48,
    48,48,48,48,48,48,48,48, 0, 0, 0,48,48,48,48, 
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,48,48,
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,48,48, 
    48, 0, 0, 0, 0, 0, 0,49,49,49,49,49,48,48,48,
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48, 
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,
    48,49,49,49,49,49, 0, 0,49,49,49,49,49,49,48,
    48,48,48,48,48,48, 0, 0,48,48,48,48,48,48,48, 
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48, 
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48, 
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,
    48,48,48,48,48,48,48,48,48,48,48,48,48,48,32
  ]
}







window.init_game = ->
  debug "Start", SUCCESS
  canvas = new App.Canvas()
  engine = new App.Engine( canvas )
  if engine.init()
    debug("engile.init()", SUCCESS)
    tilemap = new App.TileMap( App.Resources.sprites )
    tilemap.load(window.LEVEL1);

    sprites = new App.EntityContainer()
    @hero = new App.Hero(tilemap, App.Resources.sprites )
    sprites.add( @hero )
    particles = new App.ParticleContainer(tilemap)
    red_volcano = new App.ParticleEmitters.RedVolcano( particles, 100, 90)
    blue_smoke = new App.ParticleEmitters.BlueSmoke( particles, 190, 90)

    player_menu = new App.PlayerMenu()

    # engine render/update pump
    engine.addCallback( tilemap )
    engine.addCallback( particles )
    engine.addCallback( sprites )
    engine.addCallback( player_menu )
    
    engine.addCallback( red_volcano )
    engine.addCallback( blue_smoke )
    canvas.init_controller()
    canvas.add_controller_listener( @hero )
    canvas.add_controller_listener( player_menu)

    @hero.set_menu_listener( player_menu )
    #player_menu.notify(@hero)
    # start your engines
    engine.start()
  else
    debug("unable to engine.init()", ERROR)

# ==== START

window.addEventListener "load", ->
  App.Resources.sprites = new Image()
  App.Resources.sprites.onload = ->
    debug "Image loaded"
    window.init_game()
  App.Resources.sprites.src = "/img/sprites.png"

