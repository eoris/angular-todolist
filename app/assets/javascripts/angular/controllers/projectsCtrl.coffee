@angularTodo.controller 'projectsCtrl', [
  '$scope'
  'projects'
  'project'
  ($scope, projects, project) ->

    $scope.project = project

]
