@angularTodo.controller 'registrationCtrl', [
  '$scope'
  '$state'
  '$auth'
  'toaster'
  ($scope, $state, $auth, toaster) ->

    $scope.registrationForm = {}

    $scope.handleRegBtnClick = ->
      if $scope.registrationForm == undefined || angular.equals({}, $scope.registrationForm)
        toaster.pop 'error', 'Invalid credentials'
        return
      $auth.submitRegistration($scope.registrationForm).then((resp) ->
        $state.go 'projects'
        toaster.pop 'success', 'Welcome!'
      ).catch (resp) ->
        angular.forEach resp.data.errors.full_messages, (error, index) ->
          toaster.pop 'error', error
  ]
