@angularTodo.controller 'sessionsCtrl', [
  '$scope'
  '$state'
  '$auth'
  'toaster'
  ($scope, $state, $auth, toaster) ->

    $scope.loginForm = {}

    $scope.handleLoginBtnClick = ->
      if $scope.loginForm == undefined || angular.equals({}, $scope.loginForm)
        toaster.pop 'error', 'Invalid credentials'
        return
      $auth.submitLogin($scope.loginForm).then (resp) ->
        console.log(resp)
        $state.go 'projects'
        toaster.pop 'success', 'Welcome!'
      .catch (resp) ->
        toaster.pop 'error', resp.errors[0]

    $scope.handleSignOutBtnClick = ->
      $auth.signOut().then (resp) ->
        $state.go 'sign_in'
        window.location.href = '/#/sign_in'
        toaster.pop 'success', 'Bye!'
      .catch (resp) ->
        toaster.pop 'warning', 'Oops..'

    $scope.handleFacebookBtnClick = ->
      $auth.authenticate('facebook').then (resp) ->
        $state.go 'projects'
        toaster.pop 'success', 'Welcome!'
      .catch (resp) ->
        toaster.pop 'warning', 'Something went wrong'
  ]
