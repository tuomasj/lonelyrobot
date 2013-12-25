class App.PlayerMenu extends App.Entity
	constructor: ->
		@menu_items = ['build', 'collect', 'test']
		@active = false
		@setPosition(0,0)
		@entity = null

	render: (context) ->
		if @active
			@x = Math.floor(@entity.x) - 50 + 12
			@y = Math.floor(@entity.y) - 50 + 12
			line = 0
			context.font = "16px monospace"
			metrics = context.measureText("test")
			box_height = (@menu_items.length+1) * 24
			context.beginPath()
			context.fillStyle = "rgba(64,64,64,0.5)"
			context.rect(@x, @y + 12, 100, box_height)
			context.strokeStyle = "black"
			context.lineWidth = "1px"
			context.fill()
			context.stroke()
			
			
			for item in @menu_items
				metrics = context.measureText(item)
				text_x = (100 - metrics.width) / 2
				context.fillStyle = "white"
				context.fillText(item, text_x + @x, @y + 32 + line * 32)
				context.fillStyle = "rgba(32,128,32,0.5)"
				context.fillRect(@x + 4, @y + 16 + line*32, 100 - 8, 24)
				line += 1

	update: (deltaTime) ->

	notify: (entity) ->
		@entity = entity
		@active = true

	deactivate: () ->
		@active = false

	handle_click: (x,y) ->
		return true