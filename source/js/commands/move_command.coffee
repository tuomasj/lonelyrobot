#= require 'commands/command'


class App.Commands.MoveCommand extends App.Command
  constructor: (entity, params) ->
    super(entity)
    debug "MoveCommand.constructor(#{params.x}, #{params.y})"
    @entity = entity
    @target_x = params.x
    @target_y = params.y
    @dir = @entity.x - @target_x

  start: ->
    if @dir < 0
      @entity.start_animation("left")
    else
      if @dir > 0
        @entity.start_animation("right")

  distance: ->
    if @dir > 0
      return @entity.x - @target_x
    if @dir < 0
      return @target_x - @entity.x
    return 0

  process: (deltaTime) ->
    # are we there yet?
    if @distance() > 0
      if @dir > 0
        shape = { x: @entity.x - @entity.width, y: @entity.y + @entity.height, width: @entity.width, height: @entity.height }
        dir = @entity.map.check_collision(shape)
        if dir.collision == false
          @target_reached()
          return true
        else
          @entity.velocity_x -= @entity.acceleration
  
      else if @dir < 0
        shape = { x: @entity.x + @entity.width, y: @entity.y + @entity.height, width: @entity.width, height: @entity.height } 
        dir = @entity.map.check_collision(shape)
        if dir.collision == false
          @target_reached()
          return true
        else
          @entity.velocity_x += @entity.acceleration
      return false
    else
      @entity.x = @target_x 
      @target_reached()
      return true

  target_reached: ->
    @entity.resetVelocity()
    @entity.stop_animation()
    if @dir > 0
      @entity.idle_frame = 16
    else
      if @dir < 0
        @entity.idle_frame = 0
    
