describe('Service: MnoeOrganizations', ->

  beforeEach(module('mnoEnterpriseAngular'))

  $httpBackend = null
  MnoeOrganizations = null

  beforeEach(inject((_MnoeOrganizations_, _$httpBackend_) ->
    MnoeOrganizations = _MnoeOrganizations_
    $httpBackend = _$httpBackend_

    # Backend interceptors
    $httpBackend.when('GET', '/mnoe/jpi/v1/organizations').respond(200,
      {
        "organizations": [
          { "id": 9, "uid": "usr-fbbw", "name": "Marvel" },
          { "id": 10, "uid": "usr-fbb7", "name": "DC Comics" }
        ]
      })

    # Backend interceptors
    $httpBackend.when('GET', '/mnoe/jpi/v1/organizations/in_arrears').respond(200,
      {
        "organization": [
          { "id": 9, "uid": "usr-fbbw", "name": "Marvel" }
        ]
      })

    # Backend interceptors
    $httpBackend.when('GET', '/mnoe/jpi/v1/organizations/9').respond(200,
      {
        "organization": [
          { "id": 9, "uid": "usr-fbbw", "name": "Marvel" }
        ]
      })
  ))

  afterEach( ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()
  )

  describe('@list', ->
    it('GETs /mnoe/jpi/v1/organizations', ->
      $httpBackend.expectGET('/mnoe/jpi/v1/organizations')
      MnoeOrganizations.list()
      $httpBackend.flush()
    )
  )

  describe('@inArrears', ->
    it('GETs /mnoe/jpi/v1/in_arrears', ->
      $httpBackend.expectGET('/mnoe/jpi/v1/organizations/in_arrears')
      MnoeOrganizations.inArrears()
      $httpBackend.flush()
    )
  )

  describe('@get', ->
    it('GETs /mnoe/jpi/v1/organizations/9', ->
      $httpBackend.expectGET('/mnoe/jpi/v1/organizations/9')
      MnoeOrganizations.get(9)
      $httpBackend.flush()
    )
  )
)
