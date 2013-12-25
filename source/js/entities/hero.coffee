#= require 'commands/move_command.js'

class App.Hero extends App.Sprite
  constructor: (map, sprites) ->
    super(map, sprites)
    @max_speed = 6
    @setPosition(60,42)
    @setSize(16, 16)
    @menu_listener = null

  set_menu_listener: (menu) ->
    @menu_listener = menu

  render: (context) ->
    super(context)
    #context.fillStyle = "green"
    #context.fillRect( Math.floor(@x), Math.floor(@y), window.SPRITE_SIZE_IN_PIXELS,window.SPRITE_SIZE_IN_PIXELS)
    
  update: (deltaTime) ->
    super(deltaTime)
    if @velocity_x > @max_speed
      @velocity_x = @max_speed
    if @velocity_x < -@max_speed
      @velocity_x = -@max_speed

    dir = @map.check_collision(this)
    if dir.left.status == true or dir.right.status == true
      @velocity_x = 0
    if dir.bottom.status == true
      @y = dir.bottom.entity.y - @height
      @velocity_y = 0
      @on_ground = true
    else
      @on_ground = false

    if not @on_ground
      @apply_gravity(deltaTime)
    else
      @velocity_y = 0
      @y = dir.bottom.entity.y - @height
      #debug "- on ground  y: #{@y}  velocity_y: #{@velocity_y}"

    @x += @velocity_x * deltaTime
    @y += @velocity_y * deltaTime

  move: (target_x, target_y) ->
    debug "  - Move to (#{target_x},#{target_y})"
    command = new App.Commands.MoveCommand(this, {x: target_x, y:target_x})
    @setCommand(command)

  handle_click: (mouse_x, mouse_y) ->
    dist_x = Math.floor(mouse_x - @x)
    dist_y = Math.floor(mouse_y - @y)
    if not @menu_listener.active
      if dist_x > 0 and dist_x < @width and dist_y > 0 and dist_y < @height
        @notify_player_menu()
      else   
        debug "- Move"
        command = new App.Commands.MoveCommand(this, { x: mouse_x - @width / 2, y: mouse_y})
        @setCommand( command )

  notify_player_menu: ->
    if @menu_listener
      @menu_listener.notify(this)
