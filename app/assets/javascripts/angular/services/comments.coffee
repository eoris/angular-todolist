@angularTodo.factory 'tasksFactory', [
  '$http'
  ($http) ->

    create: (comment) ->
      $http.post('/tasks/' + comment.task_id + '/comments', comment)

    update: (comment) ->
      $http.patch('/comments/' + comment.id , comment)

    delete: (comment) ->
      $http.delete('/comments/' + comment.id)

]
