@angularTodo.controller 'commentsCtrl', [
  '$scope'
  'commentsFactory'
  ($scope, commentsFactory) ->

    $scope.createComment = (task) ->
      if $scope.commentText == undefined
        return
        console.log('asdasd')
      commentsFactory.create(
        text: $scope.commentText.text
        task_id: task.id
        ).success (data) ->
          task.comments.push(data.comment)
      $scope.commentText = {}

    $scope.commentIndex = (comment) ->
      $scope.task.comments.indexOf(comment)

    $scope.deleteComment = (comment) ->
      commentsFactory.delete(comment).success (data) ->
        index = $scope.commentIndex(comment)
        $scope.task.comments.splice(index, 1)

    ]

