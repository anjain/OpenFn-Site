'use strict'

OpenFn.Mappings = angular.module 'OpenFn.Mappings', []

OpenFn.Mappings.config [
  '$routeProvider',
  '$locationProvider',
  ($routeProvider, $locationProvider) ->
    console.log "hello from nested router"
    $locationProvider.html5Mode true
    $routeProvider
    .when '/mappings2/new',
      templateUrl: '/templates/mappings/new.html'
      controller: 'NewMappingCtrl as mappingCtrl'
      resolve:
        mappingInstance: ($q,Mapping) ->
          $q (resolve) ->
            resolve(new Mapping)
]

