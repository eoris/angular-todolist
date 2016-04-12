@angularTodo.factory 'attachmentsFactory', [
  '$http'
  'Upload'
  ($http, Upload) ->

      create: (file, comment) ->
        Upload.upload
          method: 'POST'
          url: '/comments/' + comment.id + '/attachments'
          file: file

      delete: (attachment) ->
        $http.delete('/attachments/' + attachment.id)

]
