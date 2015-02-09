'use strict'

OpenFn.Mappings.factory 'MappingViewModel', [
  '$resource','$http','$q', ($resource,$http,$q) ->

    class Mapping

      constructor: (id, callbacks={}) ->

        @callbacks = callbacks

        @attrs = {
          id: id || null
          name: ""
          enabled: false
        }

        @state = {
          new: id? ? false : true
          loading: true
        }

        @initializeProps [
          'id'
          'name'
          'active'
          'enabled'
        ]


      initializeProps: (properties) ->

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

      emit: (evt) ->
        console.log "Called #{evt}"
        @callbacks[evt](this)

      updateFromServer: (resp) ->
        # TODO use api v1
        angular.extend(@.attrs, resp)
        console.log resp

      fetchFromServer: () ->
        @state.loading = true
        $http.get("/mappings/#{@id}.json").success (data) =>
          @updateFromServer(data.mapping)
          @state.loading = false
        .error () ->
          console.error arguments
          @state.loading = false
      
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
