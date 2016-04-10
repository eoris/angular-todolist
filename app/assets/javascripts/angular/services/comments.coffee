@angularTodo.factory 'commentsFactory', [
  '$http'
  ($http) ->

    create: (comment) ->
      $http.post('/tasks/' + comment.task_id + '/comments', comment)

    delete: (comment) ->
      $http.delete('/comments/' + comment.id)

]
