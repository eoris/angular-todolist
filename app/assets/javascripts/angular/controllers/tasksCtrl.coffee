@angularTodo.controller 'tasksCtrl', [
  '$scope'
  'tasksFactory'
  ($scope, tasksFactory) ->

    $scope.createTask = (project) ->
      if $scope.taskTitle == undefined
        return
      tasksFactory.create(
        title: $scope.taskTitle.title
        deadline: $scope.deadline
        project_id: project.id
        ).success (data) ->
          project.tasks.push(data.task)
      $scope.taskTitle = {}

    $scope.taskIndex = (task) ->
      $scope.project.tasks.indexOf(task)

    $scope.deleteTask = (task) ->
      tasksFactory.delete(task).success (data) ->
        index = $scope.taskIndex(task)
        $scope.project.tasks.splice(index, 1)

    $scope.taskTitleUpdate = {}

    $scope.updateTask = (task) ->
      task.title = $scope.taskTitleUpdate.title
      tasksFactory.update(task)

    $scope.switchTaskDone = (task) ->
      task.done = !task.done
      tasksFactory.update(task)

    $scope.switchEditTask = (task) ->
      $scope.taskTitleUpdate.title = task.title
      task.editTask = !task.editTask

    # fix row width when sortable
    fixHelper = (e, ui) ->
      ui.children().each ->
        $(this).width $(this).width()
      ui

    $scope.sortableOptions =
      helper: fixHelper
      stop: ->
        tasks = $scope.project.tasks
        tasks.map (task) ->
          task.position = $scope.taskIndex(task)
          tasksFactory.update(task)
]

