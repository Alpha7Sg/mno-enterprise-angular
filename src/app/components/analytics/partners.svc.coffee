angular.module 'mnoEnterpriseAngular'
.service 'PartnersSvc', (MnoeCurrentUser, $localStorage, $cookies, $window) ->

  # Save partner data if necessary
  @init = (userData) ->
    if($cookies.get('source_partner')!=undefined)
      $localStorage.sourcePartner = $cookies.get('source_partner')

  return @
