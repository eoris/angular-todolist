@angularTodo.controller 'tasksCtrl', [
  '$scope'
  'tasksFactory'
  ($scope, tasksFactory) ->

    $scope.task_title = ''

    $scope.createTask = (project) ->
      if $scope.task_title == ''
        return
      tasksFactory.create(
        title: $scope.task_title
        deadline: $scope.deadline
        project_id: project.id
        ).success (data) ->
          project.tasks.push(data.task)
      $scope.task_title = ''

    $scope.deleteTask = (task) ->
      tasksFactory.delete(task).success (data) ->
        index = $scope.project.tasks.indexOf(task)
        $scope.project.tasks.splice(index, 1)

    $scope.updateTask = (task) ->
      tasksFactory.update(task).success ->

    $scope.taskVisible = true
    $scope.editTaskHide = false

    $scope.showHideEdit = (task) ->
      # $scope.taskVisible = $scope.taskVisible == false ? true : false
      # $scope.editTaskHide = $scope.editTaskHide == false ? false : true
      $scope.taskVisible = !$scope.taskVisible
      $scope.editTaskHide = !$scope.editTaskHide
]
