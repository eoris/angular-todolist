@angularTodo.controller 'tasksCtrl', [
  '$scope'
  'tasksFactory'
  ($scope, tasksFactory) ->

    $scope.tasks = {}

    $scope.createTask = (project) ->
      if $scope.task_title == ''
        return
      tasksFactory.create(
        title: $scope.task_title
        project_id: project.id
        ).success (data) ->
          console.log(project)
          # console.log($scope.projects)
          # console.log(project.tasks)
          project.tasks.push(data)
          # $scope.projects.push(data)
      $scope.task_title = ''

    $scope.deleteTask = (task) ->
      tasksFactory.delete(task)

    $scope.updateTask = (task) ->
      tasksFactory.update(task)

]
