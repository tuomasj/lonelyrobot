#= require 'commands/move_command.js'
#= require 'entities/collector.js'

class App.Hero extends App.Sprite
  constructor: (map, sprites, npcs) ->
    super(map, sprites)
    @max_speed = 6
    @setPosition(2*16,0)
    @setSize(16, 16)
    @menu_listener = null
    @npcs = npcs
    @frames = {
      left: [ [0, 0.5], [1, 0.5], [2, 0.5], [3, 0.5]],
      right: [ [16, 0.5], [17, 0.5], [18, 0.5], [19, 0.5]],
      build_left: [ [8, 0.8], [9, 0.8], [10, 0.8], [11, 0.8],[12, 0.8], [13, 1.4], [14, 1.4], [13, 1.5], [14, 1.5], [13, 1.4], [14, 1.4], [13, 1.5], [14, 1.5], [13, 1.4], [14, 1.4], [13, 1.5], [14, 1.5], [13, 1.4], [14, 1.4], [13, 1.5], [14, 1.5], [-1, 5] ]
      build_right: [ [24, 0.8], [25, 0.8], [26, 0.8], [27, 0.8],[28, 0.8], [29, 1.4], [30, 1.4], [29, 1.5], [30, 1.5], [29, 1.4], [30, 1.4], [29, 1.5], [30, 1.5], [29, 1.4], [30, 1.4], [29, 1.5], [30, 1.5], [29, 1.4], [30, 1.4], [29, 1.5], [30, 1.5], [-1, 5] ]
      stand_up_left: [ [14, 0.8], [13, 0.8],[12, 0.8],[11, 0.8],[10, 0.8],[9, 0.8],[8, 0.8]]
      stand_up_right: [ [30, 0.8], [29, 0.8],[28, 0.8],[27, 0.8],[26, 0.8],[25, 0.8],[40, 0.8]]
    }
    @direction = "right"

  set_npcs_collection: (npcs) ->
    @npcs = npcs

  set_menu_listener: (menu) ->
    @menu_listener = menu

  render: (context) ->
    super(context)
    
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

    @x += @velocity_x * deltaTime
    @y += @velocity_y * deltaTime

  handle_click: (mouse_x, mouse_y) ->
    debug "Hero.handle_click()"
    dist_x = Math.floor(mouse_x - @x)
    dist_y = Math.floor(mouse_y - @y)
    return not @menu_listener.active

  handle_dblclick: (mouse_x, mouse_y) ->
    dist_x = Math.floor(mouse_x - @x)
    dist_y = Math.floor(mouse_y - @y)
    debug "handle_dblclick( #{dist_x}, #{dist_y})"
    if dist_x >= 0 and dist_x < @width and dist_y >= 0 and dist_y < @height           
      if not @menu_listener.active
        @notify_player_menu()
        return true
    else
      @setCommand(new App.Commands.MoveCommand(this, { x: mouse_x - @width / 2, y: mouse_y}))
      return true
    return false
    

  notify_player_menu: ->
    if @menu_listener
      @menu_listener.notify(this)

  drop_collector: (x,y,particles) ->
    if @npcs
      collector = new App.NPC.Collector(@map, @sprites, x, y, particles)
      @npcs.add(collector)

  collides_with_npcs: ->
    if @npcs
      for npc in @npcs.entities
        res = @entity.check_collision(npc)
        if res != null
          return true
    return false

  clamp: (value, min, max) ->
    # soo soo, ei saa! duplikaatti-metodi
    if value > max
      return max
    if value < min
      return min
    return value

  where_can_build: ->
    debug "Hero.where_can_build()"
    # check where the hero can build
    # if there is no space, return null
    # otherwise, return { x: x_pos, y: y_pos }
    x = @x
    y = @y
    collision_with_npc = null
    if @npcs
      debug "@npcs.length = #{@npcs.length()}"
      for npc in @npcs.entities
        if @check_collision(npc) != null
          collision_with_npc = npc
    else
      debug "- No @npcs in Hero", ERROR
    if collision_with_npc
      # which side (left / right) is closer to hero center point?

      # hero center x
      hero_x = Math.floor(@x + Math.floor(@width / 2))

      # distance to left side of a npc with collides with hero
      left_dist = Math.abs(collision_with_npc.x - hero_x)
      # distance to right size of a npc with collides with hero
      right_dist = Math.abs((collision_with_npc.x + collision_with_npc.width) - hero_x)

      debug "left_dist: #{left_dist}  right_dist: #{right_dist}"
      if left_dist < right_dist
        debug "- left_size is closer to the center of hero"
        
        x = collision_with_npc.x - collision_with_npc.width 
      else
        if left_dist > right_dist
          debug "- right_size is closer to the center of hero"
          x = collision_with_npc.x + collision_with_npc.width
      shape = { x: x, y: y, width: npc.width, height: npc.height}
      if not @npcs.collides_with(shape)
        return { x: x, y: y }
      return false
    else
      return { x: x, y: y }
