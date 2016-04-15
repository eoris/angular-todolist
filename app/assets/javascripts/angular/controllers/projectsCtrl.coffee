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

    $scope.createProject = ->
      if $scope.projectTitle == undefined || angular.equals({}, $scope.projectTitle)
        toaster.pop 'error', "Title can't be blank"
        return
      projectsFactory.create(
        title: $scope.projectTitle.title
        ).success (data) ->
          if data.errors
            toaster.pop 'error', data.errors[0]
            return
          $scope.projects.push(data.project)
      $scope.projectTitle = {}

    $scope.deleteProject = (project) ->
      projectsFactory.delete(project).success (data) ->
        $scope.projects.splice($scope.projects.indexOf(project), 1)

    $scope.updateProject = (project) ->
      project.title = $scope.projectTitleUpdate.title
      projectsFactory.update(project).success (data) ->
        if data.errors
          toaster.pop 'error', data.errors[0]

    $scope.switchEditProject = (project) ->
      $scope.projectTitleUpdate.title = project.title
      project.editProject = !project.editProject

    index()
]
