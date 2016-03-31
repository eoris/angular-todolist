@angularTodo = angular.module('angularTodo', ['ui.router', 'templates'])

@angularTodo.config([
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state 'home',
      url: '/home'
      templateUrl: 'angular/templates/home.html'
      controller: 'homeCtrl'
      resolve: projectPromise: [
        'projects'
        (projects) ->
          projects.index()
      ]

    $urlRouterProvider.otherwise 'home'
])
