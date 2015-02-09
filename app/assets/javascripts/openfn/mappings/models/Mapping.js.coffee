'use strict'

OpenFn.Mappings.factory 'MappingViewModel', [
  '$resource','$http', ($resource,$http) ->

    class Mapping

      constructor: (id) ->
        self = this

        @callbacks = []

        Object.defineProperty @, 'onChange',
          set: (callback) ->
            @callbacks['onChange'] = callback

        @attrs = {
          id: null
          name: ""
          enabled: false
        }

        @state = {
          new: true
          loading: true
        }

          

        properties = [
          'id'
          'name'
          'active'
          'enabled'
        ]

        for property in properties
          do (property) =>
            Object.defineProperty @, property, {
              get: -> @attrs[property]
              set: (newValue) ->
                @attrs[property] = newValue
                @emit('onChange')
                @attrs[property]
              enumerable: true
              configurable: false
            }

        @id = id

        @fetchFromServer() if @id


      emit: (evt) ->
        console.log "Called #{evt}"
        @callbacks[evt](this)

      save: () ->
        new Mapping.resource(@resourceAttrs()).$save()

      updateFromServer: (resp) ->
        console.log resp

      fetchFromServer: () ->
        $http.get("/mappings/#{@id}.json").success (data) ->
          self.updateFromServer(data)
        .error () ->
          console.error arguments
      
      resourceAttrs: () ->
        {
          id: @attrs.id,
          mapping: {
            name: @attrs.name
            enabled: @attrs.enabled
            active: @attrs.active
          }
        }
]
