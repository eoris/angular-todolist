@angularTodo.controller 'tasksCtrl', [
  '$scope'
  'toaster'
  'Restangular'
  ($scope, toaster, Restangular) ->

    $scope.createTask = (project) ->
      if $scope.taskTitle == undefined || angular.equals({}, $scope.taskTitle)
        toaster.pop 'error', "Title can't be blank"
        return
      Restangular.one('projects', project.id).all('tasks').post({
        title: $scope.taskTitle.title
        deadline: $scope.deadline
        project_id: project.id
        }).then (data) ->
          if data.errors
            toaster.pop 'error', data.errors[0]
            return
          project.tasks.push(data.task)
      $scope.taskTitle = {}

    $scope.taskIndex = (task) ->
      $scope.project.tasks.indexOf(task)

    $scope.deleteTask = (task) ->
      Restangular.one('tasks', task.id).remove().then ->
        index = $scope.taskIndex(task)
        $scope.project.tasks.splice(index, 1)

    $scope.taskTitleUpdate = {}

    $scope.updateTask = (task) ->
      task.title = $scope.taskTitleUpdate.title
      Restangular.one('tasks', task.id).patch({title: task.title}).then (data) ->
        if data.errors
          toaster.pop 'error', data.errors[0]

    $scope.setDeadline = (task) ->
      Restangular.one('tasks', task.id).patch({deadline: task.deadline})

    $scope.switchTaskDone = (task) ->
      task.done = !task.done
      Restangular.one('tasks', task.id).patch({done: task.done})

    $scope.switchEditTask = (task) ->
      $scope.taskTitleUpdate.title = task.title
      task.editTask = !task.editTask
      $scope.showPanel = !$scope.showPanel

    $scope.switchComments = (task) ->
      task.showComments = !task.showComments
      $scope.showPanel = !$scope.showPanel

    # fix row width when sortable
    fixHelper = (e, ui) ->
      ui.children().each ->
        $(this).width $(this).width()
      ui

    $scope.sortableOptions =
      helper: fixHelper
      disabled: false
      stop: ->
        tasks = $scope.project.tasks
        tasks.map (task) ->
          task.position = $scope.taskIndex(task)
          Restangular.one('tasks', task.id).patch({position: task.position})

    ]

