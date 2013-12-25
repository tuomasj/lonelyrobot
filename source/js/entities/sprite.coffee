class App.Sprite extends App.Entity
  constructor: (map, sprites) ->
    @command = null
    @touchingGround = false
    @map = map
    @acceleration = 0.5
    @setPosition(0,0)
    @resetVelocity()
    @on_ground = false
    @sprites = sprites
    @frames = { }
    @current_animation_frames = null

  apply_gravity: (deltaTime) ->
    @velocity_y += deltaTime * 0.5  

  update: (deltaTime) ->
    super(deltaTime)
    if @command
      done = @command.process(deltaTime)
      if done
        @command = null
    # animate
    if @animate
      @animation_count -= deltaTime
      if @animation_count < 0
        # next frame with the time left from previous frame
        @next_frame( Math.abs(@animation_count) )

  resetVelocity: ->
    @velocity_x = 0.0
    @velocity_y = 0.0

  setCommand: (command) ->
    debug "  - Set command"
    @command = command

  render: (context) ->
    super(context)
    frame = 0
    if @animate
      frame = @current_animation_frames[@animation_index][0]
    else
      if @idle_frame
        frame = @idle_frame
    sx = Math.floor((frame % 16) * 16)
    sy = Math.floor(frame / 16) * 16
    context.drawImage( @sprites, sx, sy, @width, @height, Math.floor(@x), Math.floor(@y), @width, @height)

  next_frame: (offsetTime) ->
    if @animation_index < @current_animation_frames.length-1
      @animation_index += 1  
    else
      @animation_index = 0
    @animation_count = @current_animation_frames[@animation_index][1] - offsetTime

  start_animation: (key) ->
    if key of @frames
      @animate = true
      @animation_index = 0
      @current_animation_frames = @frames[key]
      @animation_count = @get_frame_duration( @animation_index )

  get_frame_duration: (index) ->
    if @current_animation_frames and index < @current_animation_frames.length-1
      return @current_animation_frames[index][1]

  stop_animation: ->
    @animate = false
