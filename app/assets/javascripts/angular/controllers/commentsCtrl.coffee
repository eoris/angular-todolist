@angularTodo.controller 'commentsCtrl', [
  '$scope'
  'commentsFactory'
  'attachmentsFactory'
  'toaster'
  ($scope, commentsFactory, attachmentsFactory, toaster) ->

    $scope.files = {}

    $scope.createComment = (task) ->
      if $scope.commentText == undefined || angular.equals({}, $scope.commentText)
        return
      commentsFactory.create(
        text: $scope.commentText.text
        task_id: task.id
        ).success (data) ->
          if data.errors
            toaster.pop 'error', data.errors[0]
            return
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

    $scope.deleteUploadAttachment = (index) ->
      $scope.files.splice(index, 1)

    $scope.deleteAttachment = (comment, attachment) ->
      attachmentsFactory.delete(attachment).success (data) ->
        index = comment.attachments.indexOf(attachment)
        comment.attachments.splice(index, 1)

    ]

