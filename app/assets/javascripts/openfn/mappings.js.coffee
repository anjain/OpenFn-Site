'use strict'

OpenFn.Mappings = angular.module 'OpenFn.Mappings', ['ui.bootstrap']

OpenFn.Mappings.config [
  '$routeProvider',
  '$locationProvider',
  ($routeProvider, $locationProvider) ->
    console.log "hello from nested router"
    $locationProvider.html5Mode true

    $routeProvider
    .when '/mappings2/new',
      templateUrl: '/templates/mappings.html'
      controller: 'MappingViewCtrl as mappingCtrl'
      resolve:
        mappingId: ($q) ->
          $q (resolve) -> resolve(null)

    .when '/mappings2/:id',
      templateUrl: '/templates/mappings.html'
      controller: 'MappingViewCtrl as mappingCtrl'
      resolve:
        mappingId: ($q, $route) ->
          $q (resolve) -> resolve($route.current.params.id)
]

