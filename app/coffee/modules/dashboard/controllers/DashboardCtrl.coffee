###
app-dashboard - Criteo
(c) 2015
###
define [], ->
    "use strict"
    ###*
    # @ngdoc controller
    # @name app-dashboard-controllers.dashboardCtrl
    # @description
    #
    # Angular app controller.
    #
    # <h2>Settings</h2>
    # <pre>
    # <style type="text/css">
    # </style>
    # </pre>
    ###
    [
        '$log'
        '$http'
        '$scope'
        'config'
        (
            $log
            $http
            $scope
            config
        ) ->
            $scope.status = []
            $http
                .get config.API_STATUS_URL
                .then (response) ->
                    unless response.status is not 200
                        $scope.status =  response.data[1]
    ]
