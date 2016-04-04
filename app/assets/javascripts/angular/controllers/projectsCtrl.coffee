@angularTodo.controller 'projectsCtrl', [
  '$scope'
  'projects'
  ($scope, projects) ->

    # index projects
    $scope.projects = projects.projects

    # create project
    $scope.createProject = ->
      if  $scope.title == ''
        return
      projects.create
        title: $scope.title
      $scope.title = ''

    # delete project
    $scope.deleteProject = (project) ->
      projects.delete(project)

    # update project
    $scope.updateProject = (project) ->
      projects.update(project)

]
