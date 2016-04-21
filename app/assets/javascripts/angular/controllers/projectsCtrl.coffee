@angularTodo.controller 'projectsCtrl', [
  '$scope'
  'toaster'
  'Restangular'
  ($scope, toaster, Restangular) ->

    window.history.pushState("", "", "/#/")

    $scope.projectTitleUpdate = {}

    indexProjects = Restangular.all('projects')
    indexProjects.getList().then (projects) ->
      $scope.projects = projects

    $scope.createProject = ->
      if $scope.projectTitle == undefined || angular.equals({}, $scope.projectTitle)
        toaster.pop 'error', "Title can't be blank"
        return
      indexProjects.post({title: $scope.projectTitle.title}).then (data) ->
        if data.errors
          toaster.pop 'error', data.errors[0]
          return
        $scope.projects.push(data.project)
      $scope.projectTitle = {}

    $scope.deleteProject = (project) ->
      Restangular.one('projects', project.id).remove().then ->
        $scope.projects = _.without($scope.projects, project)

    $scope.updateProject = (project) ->
      project.title = $scope.projectTitleUpdate.title
      Restangular.one('projects', project.id).patch({title: project.title}).then (data) ->
        if data.errors
          toaster.pop 'error', data.errors[0]

    $scope.switchEditProject = (project) ->
      $scope.projectTitleUpdate.title = project.title
      project.editProject = !project.editProject
      $scope.showEditProject = !$scope.showEditProject

]
