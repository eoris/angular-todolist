@angularTodo = angular.module('angularTodo', [
  'ui.router'
  'ui.sortable'
  'ui.bootstrap.datetimepicker'
  'templates'
  'ng-token-auth'
  'nprogress-rails'
  'toaster'
  'ngAnimate'
  'ngFileUpload'
  'restangular'
  ])

@angularTodo.config([
  '$stateProvider'
  '$urlRouterProvider'
  '$authProvider'
  ($stateProvider, $urlRouterProvider, $authProvider) ->
    $stateProvider.state('projects',
      url: '/'
      templateUrl: 'angular/templates/index.html'
      controller: 'projectsCtrl'
      resolve: auth: [
        '$auth'
        '$state'
        ($auth, $state) ->
          $auth.validateUser().catch (response) ->
            $state.go('sign_in')
      ])
    .state('sign_in',
      url: '/sign_in'
      templateUrl: 'angular/templates/_sign_in.html'
      controller: 'sessionsCtrl')
    .state('sign_up',
      url: '/sign_up'
      templateUrl: 'angular/templates/_sign_up.html'
      controller: 'registrationCtrl')

    $urlRouterProvider.otherwise '/'
    $authProvider.configure
      apiUrl: ''
      authProviderPaths: facebook: '/auth/facebook'
])

@angularTodo.run ($rootScope, $state, $auth) ->
  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState) ->
    $auth.validateUser().then (response) ->
      if toState.name == 'sign_in' || toState.name == 'sign_up'
        if !angular.equals({}, response)
          $state.go('projects')
          event.preventDefault()

