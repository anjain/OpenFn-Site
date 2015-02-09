'use strict'

OpenFn.Mappings.controller 'MappingViewCtrl', [
  'mappingId',
  'MappingViewModel'
  '$q',
  '$scope',
  (mappingId,Mapping,$q,$scope) ->

    self = this

    self.state = {
      new: true,
      loading: true
    }

    self.mapping = {
      name: "",
      id: "",
      active: true,
      enabled: true
    }

    self.onMappingChange = (mapping) ->
      mapping.save()
        .then (resp) ->
          console.log resp
        .catch (resp) ->
          console.log resp

    fetchMapping = (id) ->
      $q (resolve,reject) ->
        console.log 2
        setTimeout ->
          self.mapping = new Mapping(id)
          self.mapping.onChange = self.onMappingChange
          $scope.$apply()
          resolve(true)
        , 3000

    showLoading = () ->
      self.loading = true

    cancelLoading = () ->
      self.loading = false
      
    # Bootstrap the mapping
    # Set up a new MappingViewModel
    #   fetch it if you have an ID
    #   blank one with defaults if you don't

    return this

]
