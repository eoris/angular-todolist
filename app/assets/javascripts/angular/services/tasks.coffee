@angularTodo.factory 'tasks', [
  '$http'
  ($http) ->
    # tasks = tasks: []
    tasks = {}

    tasks.create = (task) ->
      $http.post('/projects/' + task.project_id + '/tasks.json', task)

    tasks.update = (task) ->
      $http.patch('/tasks/' + task.id + '.json', task)

    tasks.delete = (task) ->
      $http.delete('/tasks/' + task.id + '.json')

    tasks
]
