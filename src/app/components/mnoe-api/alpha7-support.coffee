
#angular.module('maestrano.services.dashboard.alpha7-support', []).factory('A7Support', ['$http','$q','$window', ($http,$q,$window) ->

angular.module 'mnoEnterpriseAngular'
  .service 'A7Support', ($log, $http, $q, $window) ->
    _self = @
# Configuration
  
    @listTicket = () ->
      return $http.get('/a7/support/ticket')

    @newTicket = (subject,description,files) ->
      fd = new FormData()
      fd.append('subject', subject)
      fd.append('description', description)

      if(files.length > 0)
        for file in files
          do (file) ->
            fd.append("files[]",file)

      return $http.post('/a7/support/ticket', fd, {
        transformRequest: angular.identity,
        headers: {'Content-Type' : undefined}
      })

    @newComment = (ticketId, comment, files) ->
      fd = new FormData()
      fd.append('ticket_id', ticketId)
      fd.append('comment', comment)

      if(files.length > 0)
        for file in files
          do (file) ->
            fd.append("files[]",file)

      return $http.post('/a7/support/comment', fd, {
        transformRequest: angular.identity,
        headers: {'Content-Type' : undefined}
      })

    return @

