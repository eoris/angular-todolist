@angularTodo.controller 'projectsCtrl', [
  '$scope'
  'projectsFactory'
  'toaster'
  ($scope, projectsFactory, toaster) ->

    window.history.pushState("", "", "/#/")

    $scope.projectTitleUpdate = {}

    index = ->
      projectsFactory.index().success (data) ->
        $scope.projects = data.projects
        toaster.pop 'success', 'Hello'

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
