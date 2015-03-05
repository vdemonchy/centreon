###
app - Criteo
(c) 2014
###
define [], ->
    "use strict"

    # jshint maxlen: false

    ###*
    # @ngdoc directive
    # @name app-directives.navDirective
    # @description
    #
    # Angular app nav directive.
    #
    # <h2>Settings</h2>
    # <pre>
    # <style type="text/css">
    # </style>
    # </pre>
    ###
    [
        "$location"
        "$window"
        "$log"
        "authService"
        "config"
        (
            $location
            $window
            $log
            authService
            config
        ) ->
            restrict: 'EA'
            templateUrl : 'tpl/directives/navDirective.tpl.html'
            scope: true
            replace: false

            link: ($scope, $element, $attrs)->

                $scope.$location = $location
                $scope.config = config
                ###*
                # @ngdoc function
                # @name isLoggedIn
                # @methodOf app-directives.navDirective
                # @function
                # @description toggle the connected boolean
                ###
                $scope.isLoggedIn = () ->
                    if authService.getToken() isnt undefined
                        return true
                    else
                        return false

    ]
