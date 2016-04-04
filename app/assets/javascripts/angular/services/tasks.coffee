@angularTodo.factory 'tasks', [
  '$http'
  ($http) ->
    tasks = tasks: []

    tasks.create = (task) ->
      $http.post('/projects/' + task.project_id + '/tasks.json', task).success (data) ->
        tasks.tasks.push(data)

    tasks.update = (task) ->
      $http.patch('/tasks/' + task.id + '.json', task).success (data) ->

    tasks.delete = (task) ->
      $http.delete('/tasks/' + task.id + '.json').success (data) ->
        tasks.tasks.splice(tasks.tasks.indexOf(task), 1)

    tasks
]
