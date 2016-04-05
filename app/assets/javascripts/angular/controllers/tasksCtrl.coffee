@angularTodo.controller 'tasksCtrl', [
  '$scope'
  'tasks'
  'projects'
  ($scope, tasks, projects) ->

    $scope.tasks = projects.tasks

    # create task
    $scope.createTask = (project) ->
      if  $scope.task_title == ''
        return
      tasks.create
        title: $scope.task_title
        project_id: project.id
      $scope.task_title = ''

    # delete task
    $scope.deleteTask = (task) ->
      tasks.delete(task)

    # update task
    $scope.updateTask = (task) ->
      tasks.update(task)

]
