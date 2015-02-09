'use strict'

OpenFn.Mappings.factory 'Mapping', ['$resource', ($resource) ->

  class Mapping
    constructor: ->

      @callbacks = []

      @attrs = {
        name: "Hello from the factory"
        enabled: true
      }

      @service = $resource "/mappings/:id", {id: "@id"},
        update:
          method: "PUT"
          

      Object.defineProperty @, 'onChange',
        set: (callback) -> @callbacks['onChange'] = callback
        

      Object.defineProperty @, 'name', {
        get: -> @attrs.name
        set: (newname) -> @attrs.name = newname
        enumerable: true
        configurable: false
      }

      Object.defineProperty @, 'enabled', {
        get: -> @attrs.enabled
        set: (enabled) ->
          console.log "mapping changed!"

          @attrs.enabled = enabled
          @emit('onChange')
        enumerable: true
        configurable: false
      }

    emit: (evt) ->
      @callbacks[evt](this)
    
]
