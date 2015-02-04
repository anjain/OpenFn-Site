'use strict'

OpenFn.Mappings.factory 'Mapping', ->

  class Mapping
    constructor: ->
      @attrs = {
        name: "Hello from the factory"
      }

      Object.defineProperty @, 'name', {
        get: -> @attrs.name,
        set: (newname) -> @attrs.name = newname,
        enumerable: true,
        configurable: false
      }
