###
app - Criteo
(c) 2014
###
define [], ->
    "use strict"
    ###*
    # @ngdoc service
    # @name app-dashboard-factories.dashboardFactory
    # @description
    #
    # Angular dashboard factory.
    #
    # <h2>Settings</h2>
    # <pre>
    # <style type="text/css">
    # </style>
    # </pre>
    ###
    [
        "$log"
        "$http"
        "$q"
        "config"
        (
            $log
            $http
            $q
            config
        ) ->

            fetchStatus : (params) ->
                $http
                    .get config.API_STATUS_URL + params
                    .then (response) ->
                        unless response.status is not 200
                            response.data
    ]
