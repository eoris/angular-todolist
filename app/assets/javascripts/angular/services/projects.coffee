@angularTodo.factory 'projects', [
  '$http'
  ($http) ->
    o = projects: []

    o.index = ->
      $http.get('/projects.json').success (data) ->
        angular.copy(data, o.projects)

    o.create = (project) ->
      $http.post('/projects.json', project).success (data) ->
        o.projects.push(data)

    o.delete = (project) ->
      $http.delete('/projects/' + project.id + '.json').success (data) ->
        o.projects.splice(o.projects.indexOf(project), 1)

    o.update = (project) ->
      $http.patch('/projects/' + project.id + '.json', project).success (data) ->
        #todo
    o
]
