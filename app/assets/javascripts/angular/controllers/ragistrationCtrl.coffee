@angularTodo.controller 'registrationCtrl', [
  '$scope'
  '$state'
  '$auth'
  ($scope, $state, $auth) ->

    registrationForm = {}

    $scope.handleRegBtnClick = ->
      $auth.submitRegistration($scope.registrationForm).then((resp) ->
        console.log(resp)
        console.log('success')
        $state.go 'projects'
        #toastr todo
      ).catch (resp) ->
        console.log(resp)
        console.log('error')
        #toastr todo

  ]

