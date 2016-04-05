@angularTodo.controller 'projectsCtrl', [
  '$scope'
  'projectsFactory'
  ($scope, projectsFactory) ->

    index = ->
      projectsFactory.index().success (data) ->
        $scope.projects = data

    $scope.createProject = ->
      if  $scope.project_title == ''
        return
      projectsFactory.create(
        title: $scope.project_title
        ).success (data) ->
          $scope.projects.push(data)
      $scope.project_title = ''

    $scope.deleteProject = (project) ->
      projectsFactory.delete(project).success (data) ->
        $scope.projects.splice($scope.projects.indexOf(project), 1)

    $scope.updateProject = (project) ->
      projectsFactory.update(project)

    index()
]
