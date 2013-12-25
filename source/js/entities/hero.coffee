#= require 'commands/move_command.js'

class App.Hero extends App.Sprite
  constructor: (map, sprites) ->
    super(map, sprites)
    @max_speed = 6
    @setPosition(2*16,0)
    @setSize(16, 16)
    @menu_listener = null
    @frames = {
      left: [ [0, 0.5], [1, 0.5], [2, 0.5], [3, 0.5]],
      right: [ [16, 0.5], [17, 0.5], [18, 0.5], [19, 0.5]],
      build_left: [ [8, 0.8], [9, 0.8], [10, 0.8], [11, 0.8],[12, 0.8], [13, 1.4], [14, 1.4], [13, 1.5], [14, 1.5], [13, 1.4], [14, 1.4], [13, 1.5], [14, 1.5], [13, 1.4], [14, 1.4], [13, 1.5], [14, 1.5], [13, 1.4], [14, 1.4], [13, 1.5], [14, 1.5], [-1, 5] ]
      build_right: [ [24, 0.8], [25, 0.8], [26, 0.8], [27, 0.8],[28, 0.8], [29, 1.4], [30, 1.4], [29, 1.5], [30, 1.5], [29, 1.4], [30, 1.4], [29, 1.5], [30, 1.5], [29, 1.4], [30, 1.4], [29, 1.5], [30, 1.5], [29, 1.4], [30, 1.4], [29, 1.5], [30, 1.5], [-1, 5] ]
      stand_up_left: [ [14, 0.8], [13, 0.8],[12, 0.8],[11, 0.8],[10, 0.8],[9, 0.8],[8, 0.8]]
      stand_up_right: [ [30, 0.8], [29, 0.8],[28, 0.8],[27, 0.8],[26, 0.8],[25, 0.8],[40, 0.8]]
    }

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
    command = new App.Commands.MoveCommand(this, {x: target_x, y:target_x})
    @setCommand(command)

  handle_click: (mouse_x, mouse_y) ->
    dist_x = Math.floor(mouse_x - @x)
    dist_y = Math.floor(mouse_y - @y)
    if not @menu_listener.active
      if dist_x > 0 and dist_x < @width and dist_y > 0 and dist_y < @height
        @notify_player_menu()

  handle_dblclick: (mouse_x, mouse_y) ->
    dist_x = Math.floor(mouse_x - @x)
    dist_y = Math.floor(mouse_y - @y)
    #if dist_x < 0 and dist_x > @width
    #  if dist_y < 0 and dist_y > @height
    @setCommand(new App.Commands.MoveCommand(this, { x: mouse_x - @width / 2, y: mouse_y}))
        

  notify_player_menu: ->
    if @menu_listener
      @menu_listener.notify(this)
