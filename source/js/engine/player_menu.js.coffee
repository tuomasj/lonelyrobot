class App.PlayerMenu extends App.Entity
	constructor: ->
		@menu_items = ['build', 'collect']
		@active = false
		@setPosition(0,0)
		@entity = null

	render: (context) ->
		if @active
			@x = Math.floor(@entity.x) - 50 + 12
			@y = Math.floor(@entity.y) - 50 + 12
			line = 0
			context.beginPath()
			context.fillStyle = "rgba(128,128,128,0.5)"
			context.rect(@x, @y, 100, 100)
			context.strokeStyle = "black"
			context.lineWidth = "1px"
			context.fill()
			context.stroke()
			context.fillStyle = "white"
			context.font = "16px monospace"
			for item in @menu_items
				context.fillText(item, @x + 5, @y + 32 + line * 32)
				line += 1

	update: (deltaTime) ->

	notify: (entity) ->
		@entity = entity
		@active = true

	deactivate: () ->
		@active = false