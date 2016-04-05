@angularTodo.factory 'projectsFactory', [
  '$http'
  ($http) ->

    index: ->
      $http.get('/projects')

    create: (project) ->
      $http.post('/projects', project)

    update: (project) ->
      $http.patch('/projects/' + project.id, project)

    delete: (project) ->
      $http.delete('/projects/' + project.id)

]
