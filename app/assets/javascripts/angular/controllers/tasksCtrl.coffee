@angularTodo.controller 'tasksCtrl', [
  '$scope'
  'tasksFactory'
  ($scope, tasksFactory) ->

    $scope.taskTitleUpdate = {}

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

    $scope.deleteTask = (task) ->
      tasksFactory.delete(task).success (data) ->
        index = $scope.project.tasks.indexOf(task)
        $scope.project.tasks.splice(index, 1)

    $scope.updateTask = (task) ->
      task.title = $scope.taskTitleUpdate.title
      console.log($scope.taskTitleUpdate)
      console.log($scope.taskTitleUpdate.title)
      tasksFactory.update(task).success ->

    $scope.switchEditTask = (task) ->
      $scope.taskTitleUpdate.title = task.title
      task.editTask = !task.editTask

    fixHelper = (e, ui) ->
      ui.children().each ->
        $(this).width $(this).width()
      ui
    $scope.sortableOptions = helper: fixHelper
]
