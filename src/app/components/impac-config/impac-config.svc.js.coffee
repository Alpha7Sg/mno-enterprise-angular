angular.module 'mnoEnterpriseAngular'
  .service('ImpacConfigSvc' , ($log, $q, CurrentUserSvc, DhbOrganizationSvc) ->

    @getUserData = ->
      deferred = $q.defer()
      id = CurrentUserSvc.getUserData()
      if id
        deferred.resolve(id)
      else
        $log.error(err = {msg: "Unable to retrieve user data"})
        deferred.reject(err)

      return deferred.promise

    @getOrganizations = ->
      deferred = $q.defer()

      DhbOrganizationSvc.load().then (success) ->
        currentOrgId = DhbOrganizationSvc.getId()

        CurrentUserSvc.getOrganizations().then (orgs) ->
          userOrgs = orgs
          currentOrgId ||= orgs[0].id if orgs.length > 0

          if userOrgs && currentOrgId
            deferred.resolve({organizations: userOrgs, currentOrgId: currentOrgId})
          else
            $log.error(err = {msg: "Unable to retrieve user organizations"})
            deferred.reject(err)

      return deferred.promise

    return @
  )
