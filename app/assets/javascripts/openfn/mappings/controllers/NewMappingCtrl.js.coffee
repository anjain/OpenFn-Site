'use strict'

OpenFn.Mappings.controller 'NewMappingCtrl', [
  'mappingId',
  'Mapping'
  '$q',
  (mappingId,Mapping,$q) ->

    self = this
    fetchMapping = (id) ->
      $q (resolve,reject) ->
        console.log 2
        self.mapping = new Mapping
        reject(false)

    showLoading = (resolve) ->
      console.log 1
      self.loading = true
      resolve(true)
      
    $q showLoading
    .then -> fetchMapping(mappingId)
    .then (resolve) ->
      self.loading = false
    , (reason) =>
      console.log 3



]
