# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# TODO: Refactor this monolithic game class into Player, NonPlayerCharacter and Item classes
jQuery ->
  Game = 
    display: null
    map: {}
    engine: null
    player: null
    init: ->
      ROT.DEFAULT_HEIGHT = 40
      ROT.DEFAULT_WIDTH = 80
      @display = new (ROT.Display)
      $("#game_canvas").replaceWith @display.getContainer()
      @_generateMap()
      scheduler = new (ROT.Scheduler.Simple)
      scheduler.add @player, true
      @engine = new (ROT.Engine)(scheduler)
      @engine.start()
      return
      
    _generateMap: ->
      uniform = new (ROT.Map.Uniform)
      freeCells = []
  
      uniformCallback = (x, y, value) ->
        # We're not storing the walls
        if value
          return
        key = x + ',' + y
        @map[key] = '.'
        freeCells.push key
        return
  
      uniform.create uniformCallback.bind(this)
      @_createChests freeCells
      @_drawWholeMap()
      @_createPlayer freeCells
      return
      
    _createPlayer: (freeCells) ->
      index = Math.floor(ROT.RNG.getUniform() * freeCells.length)
      key = freeCells.splice(index, 1)[0]
      parts = key.split(',')
      x = parseInt(parts[0])
      y = parseInt(parts[1])
      @player = new Player(x, y)
      return
      
    # Place some chests on the map for the player to investigate
    # TODO: Add player interaction so the chests serve a purpose. Task: Player must find the needed item to advance to the next level
    _createChests: (freeCells) ->
      for i in [0..2]
        index = Math.floor(ROT.RNG.getUniform() * freeCells.length)
        key = freeCells.splice(index, 1)[0]
        @map[key] = '[]'
      return
      
    _drawWholeMap: ->
      for key of @map
        parts = key.split(',')
        x = parseInt(parts[0])
        y = parseInt(parts[1])
        @display.draw x, y, @map[key]
      return
  
  Player = (x, y) ->
    @_x = x
    @_y = y
    @_draw()
    return
  
  Player::act = ->
    Game.engine.lock()
    window.addEventListener 'keydown', this
    return
  
  Player::handleEvent = (e) ->
    keyMap = {}
    keyMap[38] = 0
    keyMap[33] = 1
    keyMap[39] = 2
    keyMap[34] = 3
    keyMap[40] = 4
    keyMap[35] = 5
    keyMap[37] = 6
    keyMap[36] = 7
    code = e.keyCode
  
  # Check if one of the keys is on the keypad
    if !(code of keyMap)
      return
  # update character coordinates
    dir = ROT.DIRS[8][keyMap[code]]
    newX = @_x + dir[0]
    newY = @_y + dir[1]
    newKey = newX + ',' + newY
    if !(newKey of Game.map)
      return
    Game.display.draw @_x, @_y, Game.map[@_x + ',' + @_y]
    @_x = newX
    @_y = newY
    @_draw()
    window.removeEventListener 'keydown', this
    Game.engine.unlock()
    return
  
  Player::_draw = ->
    # draw/redraw the player '@' give him a default green color
    # TODO: Refactor the player color based on remaining health points
    Game.display.draw @_x, @_y, '@', '#3f3'
    return
  
  Game.init()