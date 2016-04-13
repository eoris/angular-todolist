@angularTodo.controller 'registrationCtrl', [
  '$scope'
  '$state'
  '$auth'
  'toaster'
  ($scope, $state, $auth, toaster) ->

    registrationForm = {}

    $scope.handleRegBtnClick = ->
      if $scope.registrationForm == undefined || angular.equals({}, $scope.registrationForm)
        toaster.pop 'error', 'Invalid credentials'
        return
      $auth.submitRegistration($scope.registrationForm).then((resp) ->
        $state.go 'projects'
        toaster.pop 'success', 'Welcome!'
      ).catch (resp) ->
        toaster.pop 'error', 'Invalid credentials'
  ]
