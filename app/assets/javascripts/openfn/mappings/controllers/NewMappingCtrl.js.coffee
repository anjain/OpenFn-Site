'use strict'

OpenFn.Mappings.controller 'NewMappingCtrl', [
  'mappingInstance',(mapping) ->

    this.mapping = mapping
    this.message = "Hello"

]
