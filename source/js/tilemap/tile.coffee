#= require 'entities/entity'

class App.Tile extends App.Entity
  constructor: (x,y) ->
    @x = x
    @y = y
    @width = window.TILE_SIZE_IN_PIXELS
    @height = window.TILE_SIZE_IN_PIXELS
    @debug_state_msg = null

  update: (deltaTime) ->

  render: (context) ->
    context.beginPath()
    context.rect( @x, @y, @width, @height)
    context.fillStyle = 'lightgray'
    context.fill()
    context.lineWidth = 1
    context.strokeStyle = 'gray'
    context.stroke()
    context.strokeStyle = 'black'
    context.fillStyle = 'black'
    if @debug_state_msg
      context.fillText("#{@debug_state_msg}", @x+16, @y+16)

  debug_state: (state) ->
    @debug_state_msg = state
