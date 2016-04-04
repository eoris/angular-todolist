@angularTodo.controller 'tasksCtrl', [
  '$scope'
  'projects'
  'tasks'
  ($scope, tasks, projects) ->

    $scope.tasks = projects.tasks

    # create task
    $scope.createTask = (project) ->
      if  $scope.title == ''
        return
      tasks.create
        title: $scope.title
        project_id: project.id
      $scope.title = ''

    # delete task
    $scope.deleteTask = (task) ->
      tasks.delete(task)

    # update task
    $scope.updateTask = (task) ->
      tasks.update(task)

]
