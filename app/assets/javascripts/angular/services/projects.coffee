@angularTodo.factory 'projects', [
  '$http'
  ($http) ->
    projects = projects: []

    projects.index = ->
      $http.get('/projects.json').success (data) ->
        angular.copy(data, projects.projects)

    projects.create = (project) ->
      $http.post('/projects.json', project).success (data) ->
        projects.projects.push(data)

    projects.update = (project) ->
      $http.patch('/projects/' + project.id + '.json', project).success (data) ->

    projects.delete = (project) ->
      $http.delete('/projects/' + project.id + '.json').success (data) ->
        projects.projects.splice(projects.projects.indexOf(project), 1)

    projects
]
