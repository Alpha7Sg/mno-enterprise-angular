module = angular.module('mnoEnterpriseAngular')
# -------------------------------------------------------------------------
# This module is meant to contain the small controllers for simple modals
# For more complex modals, put the controller in its own file
# -------------------------------------------------------------------------

#============================================
# NewOrgModalCtrl
#============================================
module.controller('SupportModalCtrl',[
  '$scope','FileUploader', '$uibModalInstance', 'A7Support'
  ($scope, FileUploader, $uibModalInstance, A7Support) ->

    $scope.uploader = new FileUploader()

    $scope.ok = (newTicket) ->
      #angular.element(document.getElementById('myMenuList'));
      document.getElementById('ticket-submit').innerHTML = "<span class='fa fa-spinner fa-spin'></span> Saving..."
      document.getElementById('ticket-cancel').disabled = true

      queueFiles = $scope.uploader.queue
      files = []
      for file in queueFiles
        do (file) ->
          files.push(file._file)

      A7Support.newTicket(newTicket.subject,newTicket.description,files).then ->
        $uibModalInstance.close()


    $scope.cancel = ->
      $uibModalInstance.dismiss('cancel')

])