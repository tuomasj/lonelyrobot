window.debug = (msg, msg_type) ->
  debug = document.getElementById("debug")
  if debug
    node = document.createElement('li')
    if msg_type == ERROR
      node.className = "error"
    if msg_type == SUCCESS
      node.className = "success"
    node.appendChild( document.createTextNode(msg) )
    debug.appendChild(node)
    c_height = debug.clientHeight
    debug.scrollTop = debug.scrollHeight - debug.clientHeight

window.debug_clear = ->
  debug = document.getElementById("debug")
  if debug
    debug.innerHTML = ""
