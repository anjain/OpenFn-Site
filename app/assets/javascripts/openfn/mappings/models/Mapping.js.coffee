'use strict'

OpenFn.Mappings.factory 'Mapping', ['$resource', ($resource) ->

  class Mapping
    constructor: ->
      @attrs = {
        name: "Hello from the factory"
        enabled: true
      }

      @service = $resource "/mappings/:id", {id: "@id"},
        update:
          method: "PUT"

      Object.defineProperty @, 'name', {
        get: -> @attrs.name
        set: (newname) -> @attrs.name = newname
        enumerable: true
        configurable: false
      }

      Object.defineProperty @, 'enabled', {
        get: -> @attrs.enabled
        set: (enabled) -> @attrs.enabled = enabled
        enumerable: true
        configurable: false
      }

    save: ->

]
