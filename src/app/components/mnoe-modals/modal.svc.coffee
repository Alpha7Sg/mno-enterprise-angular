angular.module 'mnoEnterpriseAngular'
  .factory('ModalSvc', ($modal) ->

    # --------------------------------------------------------------------
    # The goal of this service is to create a generic modal creator
    # This is a wip
    # --------------------------------------------------------------------
    service = {}

    # --------------------------------------------------------------------
    # Generic Modal class
    # --------------------------------------------------------------------
    class Modal
      # Mandatory options:
      # ------------------
      # templateUrl: url of the template
      #
      # Optional options:
      # -----------------
      # backdrop
      # modalSize
      # modalClass (e.g. inverse)
      # callback: function called after proceed() if successful
      constructor: (@opts) ->
        # TODO: exceptions if opts is not complete

      config: () ->
        self = this
        {
          instance: {
            templateUrl: self.opts.templateUrl
            controller:  self.opts.controller
            backdrop:    self.opts.backdrop       || 'static'
            size:        self.opts.modalSize      || 'lg'
            windowClass: self.opts.modalClass     || 'inverse'
            resolve: {
              $modalInstanceCB: (-> return self.opts.callback)
            }
          }
        }

      # Open the modal
      open: () ->
        self = this
        $modal.open(self.config().instance)

    # --------------------------------------------------------------------
    # Service instanciations
    # --------------------------------------------------------------------
    service.new = (opts = {}) ->
      return new Modal(opts)

    service.newOrgModal = (opts = {}) ->
      opts.templateUrl = 'app/components/mnoe-modals/new-org-modal/new-organization.html'
      opts.controller = 'NewOrgModalCtrl'
      return new Modal(opts)

    service.newOrgResellerReqModal = (opts = {}) ->
      opts.templateUrl = 'app/components/mnoe-modals/new-org-reseller-req/new-organization-reseller-req.html'
      opts.controller = 'NewOrgResellerReqModalCtrl'
      return new Modal(opts)

    return service
  )
