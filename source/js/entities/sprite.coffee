class App.Sprite extends App.Entity
  constructor: (map) ->
    @command = null
    @touchingGround = false
    @map = map
    @acceleration = 0.5
    @setPosition(0,0)
    @resetVelocity()
    @on_ground = false

  apply_gravity: (deltaTime) ->
    #dir = @map.check_collision(this)
    #if dir.bottom.status == true
    #  @velocity_y = 0
    #else
    @velocity_y += deltaTime * 0.5  

  update: (deltaTime) ->
    super(deltaTime)
    if @command
      done = @command.process(deltaTime)
      if done
        debug "  - Setting command to null"
        @command = null

  resetVelocity: ->
    @velocity_x = 0.0
    @velocity_y = 0.0

  setCommand: (command) ->
    debug "  - Set command"
    @command = command

  render: (context) ->
    super(context)
