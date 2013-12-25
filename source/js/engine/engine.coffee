
class App.Engine
  constructor: (canvas) ->
    @callbacks = []
    @time = new Date().getTime()
    @canvas = canvas

  init: ->
    @raf = window.requestAnimationFrame
    if not @raf
      debug("Unable to continue, window.requestAnimationFrame not found")
      return false
    return true

  addCallback: (proc) ->
    if proc? and proc.update? and proc.render?
      @callbacks.push(proc)
    else
      debug "Cannot add callback, render and update methods missing", ERROR

  update: =>
    
    now = new Date().getTime()
    deltaTime = now - (@time || now);

    @canvas.context.fillStyle = "rgb(64,64,64)"
    @canvas.context.fillRect(0,0,15*window.TILE_SIZE_IN_PIXELS,20*window.TILE_SIZE_IN_PIXELS)
    for i in @callbacks
      i.update( deltaTime / 100.0)
      i.render( @canvas.context )

    @time = now;
    requestAnimationFrame(@update)

  start: =>
    debug "Engine.start()"
    requestAnimationFrame(@update)