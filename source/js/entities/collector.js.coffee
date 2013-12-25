class App.NPC.Collector extends App.Sprite
	constructor: (map, res, x, y) ->
		super(map,res);
		@setPosition(x,y)
		@setSize(16,16)
		@frames = {
								idle: [ [42, 5], [40, 1], [41, 1], [42, 3], [40, 1], [42, 2], [41, 2], [42, 1]]
							}
		@start_animation("idle")

	render: (context) ->
		super(context)
		#context.fillStyle = "white"
		#context.fillRect( @x, @y, @width, @height)