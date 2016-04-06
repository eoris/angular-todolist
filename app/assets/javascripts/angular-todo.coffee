@angularTodo = angular.module('angularTodo', ['ui.router', 'ui.sortable', 'templates'])

@angularTodo.config([
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state 'projects',
      url: '/'
      templateUrl: 'angular/templates/index.html'
      controller: 'projectsCtrl'

    $urlRouterProvider.otherwise '/'
])
