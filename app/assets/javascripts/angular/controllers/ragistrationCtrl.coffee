@angularTodo.controller 'registrationCtrl', [
  '$scope'
  '$state'
  '$auth'
  ($scope, $state, $auth) ->

    registrationForm = {}

    $scope.handleRegBtnClick = ->
      $auth.submitRegistration($scope.registrationForm).then((resp) ->
        $auth.submitLogin
          email: $scope.registrationForm.email
          password: $scope.registrationForm.password
        $state.go 'projects'
        #toastr todo
      ).catch (resp) ->
        #toastr todo

  ]

