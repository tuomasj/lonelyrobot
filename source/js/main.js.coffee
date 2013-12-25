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
#= require 'entities/red_volcano.js'

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
    48,49,49,49,49,49,49,49, 0, 0, 0,49,49,49,48, 
    48,48,48,48,48,48,48,48, 0, 0, 0,48,48,48,48,
    48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,48,48,48,
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

    player_sprites = new App.EntityContainer()
    npcs = new App.EntityContainer()
    static_objects = new App.EntityContainer()
    @hero = new App.Hero(tilemap, App.Resources.sprites )
    player_sprites.add( @hero )
    particles = new App.ParticleContainer(tilemap)
    
    static_objects.add(new App.NPC.RedVolcano( tilemap, App.Resources.sprites, particles, 6*16, 4*16))
    static_objects.add(new App.NPC.RedVolcano( tilemap, App.Resources.sprites, particles, 10*16, 9*16))
    
    npcs.add(new App.NPC.Collector( tilemap, App.Resources.sprites, 9*16, 9*16, particles))

    player_menu = new App.PlayerMenu( particles )

    # engine render/update pump
    engine.addCallback( tilemap )
    engine.addCallback( static_objects )
    engine.addCallback( particles )
    engine.addCallback( npcs )
    engine.addCallback( player_sprites )
    engine.addCallback( player_menu )

    #engine.addCallback( blue_smoke )
    canvas.init_controller()
    canvas.add_controller_listener( @hero )
    canvas.add_controller_listener( player_menu)

    @hero.set_menu_listener( player_menu )
    @hero.set_npcs_collection( npcs )
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

