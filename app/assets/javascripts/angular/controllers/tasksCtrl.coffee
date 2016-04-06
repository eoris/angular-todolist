@angularTodo.controller 'tasksCtrl', [
  '$scope'
  'tasksFactory'
  ($scope, tasksFactory) ->

    # $scope.tasks = {}

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
      tasksFactory.delete(task)

    $scope.updateTask = (task) ->
      tasksFactory.update(task)

]
