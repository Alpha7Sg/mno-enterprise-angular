angular.module 'mnoEnterpriseAngular'
  .service 'AnalyticsSvc', (MnoeCurrentUser, INTERCOM_ID, $window, $localStorage) ->

    # Will push user data to intercom and boot it
    @init = (userData) ->
      if $window.Intercom

        MnoeCurrentUser.get().then(
          (response)->
            userData = {
              user_id: response.id,
              app_id: INTERCOM_ID,
              name: response.name,
              surname: response.surname,
              company: response.company,
              email: response.email,
              phone: response.phone,
              created_at: response.created_at
            }

            # Add Intercom secure hash
            userData.user_hash = response.user_hash if response.user_hash

            #adding source partner if necessary @todo remove this hack and put source_partner in DB
            created_date = new Date(userData.created_at)
            created_date.setHours(0,0,0,0)
            today = new Date()
            today.setHours(0,0,0,0)

            userData.source_partner = $localStorage.sourcePartner if ($localStorage.sourcePartner and (today.getTime()== created_date.getTime()))

            #booting intercom !
            $window.Intercom('boot', userData)
        )

    # Will update in every page change so intercom knows we're still active and load new messages
    @update = () ->
      $window.Intercom('update') if $window.Intercom

    # When user logs out, call to end the Intercom session and clear the cookie.
    @logOut = ->
      $window.Intercom('shutdown') if $window.Intercom

    return @
