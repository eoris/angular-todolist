@angularTodo.controller 'projectsCtrl', [
  '$scope'
  'projectsFactory'
  ($scope, projectsFactory) ->

    window.location.href = '/#/'
    # window.history.pushState("root", "projects", "/#/")

    $scope.projectTitleUpdate = {}

    index = ->
      projectsFactory.index().success (data) ->
        $scope.projects = data.projects

    $scope.createProject = ->
      if $scope.projectTitle == undefined
        return
      projectsFactory.create(
        title: $scope.projectTitle.title
        ).success (data) ->
          $scope.projects.push(data.project)
      $scope.projectTitle = {}

    $scope.deleteProject = (project) ->
      projectsFactory.delete(project).success (data) ->
        $scope.projects.splice($scope.projects.indexOf(project), 1)

    $scope.updateProject = (project) ->
      project.title = $scope.projectTitleUpdate.title
      projectsFactory.update(project)

    $scope.switchEditProject = (project) ->
      $scope.projectTitleUpdate.title = project.title
      project.editProject = !project.editProject

    index()
]
