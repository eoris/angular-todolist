@angularTodo.controller 'commentsCtrl', [
  '$scope'
  'commentsFactory'
  'attachmentsFactory'
  ($scope, commentsFactory, attachmentsFactory) ->

    $scope.files = {}

    $scope.createComment = (task) ->
      if $scope.commentText == undefined || angular.equals({}, $scope.commentText)
        return
      commentsFactory.create(
        text: $scope.commentText.text
        task_id: task.id
        ).success (data) ->
          comment = data.comment
          if $scope.files
            angular.forEach $scope.files, (file, index) ->
              attachmentsFactory.create(file, comment).success (data) ->
                comment.attachments.push(data.attachment)
          $scope.files = {}
          task.comments.push(comment)
      $scope.commentText = {}

    $scope.commentIndex = (comment) ->
      $scope.task.comments.indexOf(comment)

    $scope.deleteComment = (comment) ->
      commentsFactory.delete(comment).success (data) ->
        index = $scope.commentIndex(comment)
        $scope.task.comments.splice(index, 1)

    ]

