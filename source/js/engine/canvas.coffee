class App.Canvas
	constructor: ->
		@canvas = document.getElementById("canvas")
		@clientRect = @canvas.getBoundingClientRect()
		@context = @canvas.getContext("2d")
		window.debug_ctx = @context
		@listeners = []

	init_controller: ->
		@canvas.addEventListener "mouseup", (e) =>
			x = e.clientX - @clientRect.left
			y = e.clientY - @clientRect.top
			debug "Mouse event on (#{x},#{y})"
			for listener in @listeners
				if listener.handle_click(Math.floor(x / 2),Math.floor(y / 2))
					return

	add_controller_listener: (func) ->
		@listeners.push(func)