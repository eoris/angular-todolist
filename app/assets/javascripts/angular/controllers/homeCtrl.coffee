@angularTodo.controller 'homeCtrl', [
  '$scope'
  'projects'
  ($scope, projects) ->

    $scope.projects = projects.projects

    # show/hide new project input
    $scope.isVisible = false
    $scope.showHide = ->
      $scope.isVisible = if $scope.isVisible then false else true

    # create project
    $scope.createProject = ->
      if !$scope.title or $scope.title == ''
        return
      projects.create
        title: $scope.title
      $scope.title = ''

    # delete project
    $scope.deleteProject = (project) ->
      projects.delete(project)

]
