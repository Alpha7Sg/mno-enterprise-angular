#============================================
#
#============================================
angular.module 'mnoEnterpriseAngular'
.controller('DashboardSupportCtrl', [
  '$scope', 'Miscellaneous','Utilities',
            'A7Support', '$uibModal', '$timeout', '$log', 'FileUploader'
  ($scope, Miscellaneous, Utilities,
             A7Support, $uibModal, $timeout, $log, FileUploader) ->

    'ngInject'

    vm = this

    $scope.newTicket = {}
    
    $scope.loadingTicketList = true
    
    $scope.sendingComment = false
    
    #$scope.assetPath = AssetPath
    
    $scope.uploader = new FileUploader()

    $scope.open = () ->
      modalInstance = $uibModal.open(
        templateUrl: 'a7-new-ticket.html'
        controller: 'SupportModalCtrl'
        resolve:
          newTicket: ->
            $scope.newTicket
          tickets: ->
            $scope.tickets
      )
      modalInstance.result.then ((newTicket) ->
        $scope.newTicket = newTicket
        A7Support.listTicket().then (data) ->
          $scope.tickets = data.data
        return
      ), ->
        return
      return

    $scope.reset = () ->
      A7Support.listTicket().then (data) ->
        $timeout(() ->
          $scope.tickets = data.data
          $scope.loadingTicketList = false
        , 1)
      
    $scope.reset()

    $scope.newComments = {}

    $scope.submitComment = (ticket) ->

      $scope.sendingComment = true

      queueFiles = $scope.uploader.queue
      files = []
      for file in queueFiles
        do (file) ->
          files.push(file._file)

      A7Support.newComment(ticket.id, $scope.newComments[ticket.id]["comment"], files).
        then(
          (response)->
            $scope.newComments[ticket.id] = null
            files = null
            ticket.comments.push(response.data.note)
            $scope.sendingComment = false
            $scope.uploader.clearQueue()
          (response) ->
            $log.error(response)
        )

])
