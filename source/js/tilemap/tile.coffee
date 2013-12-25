#= require 'entities/entity'

class App.Tile extends App.Entity
  constructor: (x,y, tile_index, resource) ->
    @x = x
    @y = y
    @width = 16 #window.TILE_SIZE_IN_PIXELS
    @height = 16 #window.TILE_SIZE_IN_PIXELS
    @debug_state_msg = null
    @tile_index = tile_index
    @tile_resource = resource

  update: (deltaTime) ->

  render: (context) ->
    sx = Math.floor((@tile_index % 16) * 16)
    sy = Math.floor(@tile_index / 16) * 16
    context.drawImage( @tile_resource, sx, sy, @width, @height, Math.floor(@x), Math.floor(@y), @width, @height)
    #context.fillStyle = "white"
    #context.fillText("#{@tile_index}", @x, @y)

  debug_state: (state) ->
    @debug_state_msg = state
