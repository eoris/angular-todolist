@angularTodo.controller 'projectsCtrl', [
  '$scope'
  'projectsFactory'
  'toaster'
  'Restangular'
  ($scope, projectsFactory, toaster, Restangular) ->

    window.history.pushState("", "", "/#/")

    $scope.projectTitleUpdate = {}

    Restangular.all('projects').getList().then (projects) ->
      $scope.projects = projects

    # index = ->
    #   projectsFactory.index().success (projects) ->
    #     $scope.projects = projects

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

    # index()
]
