###
centreon
(c) 2015
###
define [], ->
    "use strict"
    ###*
    # @ngdoc service
    # @name app-factories.errorInterceptorFactory
    # @description
    #
    # Angular app factory.
    #
    # <h2>Settings</h2>
    # <pre>
    # <style type="text/css">
    # </style>
    # </pre>
    ###
    [
        "$rootScope"
        "$log"
        (
            $rootScope
            $log
        ) ->

            ###*
            # @ngdoc function
            # @name request
            # @methodOf app-factories.errorInterceptorFactory
            # @function
            # @description returns the config/
            ###
            request: (config) ->
                config

            ###*
            # @ngdoc function
            # @name response
            # @methodOf app-factories.errorInterceptorFactory
            # @function
            # @description if a request error is intercepted, API_ERROR event
            # is broadcasted
            ###
            response: (response) ->
                if response.status >= 400
                    rejection =
                        status : response.status
                        data: response.data.error
                    $rootScope.$broadcast 'API_ERROR', rejection
                else
                    response
    ]
