@angularTodo.controller 'sessionsCtrl', [
  '$scope'
  '$state'
  '$auth'
  ($scope, $state, $auth) ->

    $scope.loginForm = {}

    $scope.handleLoginBtnClick = ->
      $auth.submitLogin($scope.loginForm).then (resp) ->
        $state.go 'projects'
        #toster todo
        .catch (resp) ->
          #toster todo

    $scope.handleSignOutBtnClick = ->
      $auth.signOut().then((resp) ->
        $state.go('sign_in')
        #toster todo
      ).catch (resp) ->
        #toster todo

    $scope.handleFacebookBtnClick = ->
      $auth.authenticate('facebook').then((resp) ->
        $state.go 'projects'
      ).catch (resp) ->

  ]

