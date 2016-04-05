@angularTodo.factory 'tasksFactory', [
  '$http'
  ($http) ->

    create: (task) ->
      $http.post('/projects/' + task.project_id + '/tasks', task)

    update: (task) ->
      $http.patch('/tasks/' + task.id , task)

    delete: (task) ->
      $http.delete('/tasks/' + task.id)

]
