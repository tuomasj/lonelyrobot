#= require 'tilemap/tile.js'

class App.TileMap
  constructor: (tile_resource) ->
    console.log "TileMap.constructor"
    @tiles = []
    @TILE_WIDTH = window.TILE_SIZE_IN_PIXELS
    @TILE_HEIGHT = window.TILE_SIZE_IN_PIXELS
    @context = null
    @tile_resource = tile_resource

  load: (map) ->
    debug "TileMap.load()  w:#{map.width}  h:#{map.height}"

    @map = map.data
    @map_width = map.width
    @map_height = map.height
    for y in [0..@map_height-1]
      for x in [0..@map_width-1]
        index = @map[y * @map_width + x]
        if index != 0
          @tiles.push( new App.Tile(x * @TILE_WIDTH, y * @TILE_HEIGHT, index, @tile_resource))

  render: (context) ->
    @context = context
    for tile in @tiles
      tile.render(context)

  update: (deltaTime) ->

  check_collision: (shape) ->
    response = { 
                top: { status: false, entity: null }, 
                bottom: { status: false, entity: null }, 
                left: { status: false, entity: null }, 
                right: { status: false, entity: null }
                collision: false
              }
    for tile in @tiles
      d = tile.check_collision(shape)
      if d != null
        response.collision = true
        response[d].status = true
        response[d].entity = tile
    return response

