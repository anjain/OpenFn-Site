'use strict'

OpenFn.Mappings.controller 'NewMappingCtrl', [
  'mappingId',
  'Mapping'
  '$q',
  '$scope',
  (mappingId,Mapping,$q,$scope) ->

    self = this

    self.onMappingChange = (mapping) ->
      console.log mapping

    fetchMapping = (id) ->
      $q (resolve,reject) ->
        console.log 2
        setTimeout ->
          self.mapping = new Mapping(id)
          self.mapping.onChange = self.mappingChanged
          $scope.$apply()
          resolve(true)
        , 3000

    showLoading = () ->
      self.loading = true

    cancelLoading = () ->
      self.loading = false
      
    $q (resolve,reject) ->
      showLoading()
      fetchMapping(mappingId)
    .then cancelLoading
    , (reason) =>
      console.log 3


    return this


]
