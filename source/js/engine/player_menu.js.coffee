class App.PlayerMenu extends App.Entity
	constructor: ->
		@menu_items = ['build', 'collect', 'test']
		@active = false
		@setPosition(0,0)
		@entity = null
		@FONT_SIZE = 16
		@box_height = (@menu_items.length+1) * 24
		@box_width = 100
		@rects = []
		@active_menu_item = -1
		@animation_counter = 0

		for line in [0..@menu_items.length-1]
			@rects.push( { x: 0, y: line * (@FONT_SIZE*2), width: @box_width, height: 24})

	render: (context) ->
		if @active
			@x = Math.floor(@entity.x) - (@box_width / 2)
			@y = Math.floor(@entity.y) - (@box_height / 2)
			if @x < 10
				@x = 10
			if @y < 10
				@y = 10
			line = 0
			context.font = "#{@FONT_SIZE}px monospace"
			metrics = context.measureText("test")
			
			context.beginPath()
			context.fillStyle = "rgba(64,64,64,0.5)"
			context.rect(@x, @y + 12, @box_width, @box_height)
			context.strokeStyle = "black"
			context.lineWidth = "1px"
			context.fill()
			context.stroke()
			
			for item in @menu_items
				metrics = context.measureText(item)
				text_x = (@box_width - metrics.width) / 2
				context.fillStyle = "white"
				context.fillText(item, text_x + @x, @y + 32 + line * 32)
				if @animation_counter > 0 and @active_menu_item == line
					odd = Math.floor(@animation_counter) % 2
					if odd == 1
						context.fillStyle = "rgba(255,255,255,0.5)"
						context.fillRect(@x + 4, @y + 16 + line*(@FONT_SIZE*2), @box_width - 8, 24)
				line += 1


	update: (deltaTime) ->
		if @active_menu_item != -1
			@animation_counter -= deltaTime
			if @animation_counter < 0
				@animation_counter = 0
				@active_menu_item = -1
				@deactivate()

	notify: (entity) ->
		@entity = entity
		@active = true

	deactivate: ->
		@active = false

	start_click_animation: (num) ->
		@animation_counter = 2
		@active_menu_item = num

	hit_menu_item: (mouse_x,mouse_y) ->
		item = 0
		for rect in @rects
			if mouse_x > rect.x+@x and mouse_y > rect.y+@y+16 and mouse_x < (rect.x+rect.width+@x) and mouse_y < (rect.y+rect.height+@y+16)
				return item
			item += 1
		return -1

	handle_click: (x,y) ->
		if @active
			box_x1 = Math.floor(@entity.x - (@box_width / 2))
			box_y1 = Math.floor(@entity.y - (@box_height / 2))
			box_x2 = Math.floor(@entity.x + (@box_width / 2))
			box_y2 = Math.floor(@entity.y + (@box_height / 2))
			if x < box_x1 or y < box_y1 or x > box_x2 or y > box_y2
				@deactivate()
			else
				num = @hit_menu_item(x, y)
				if num >= 0
					@start_click_animation(num)
			return true
		return false