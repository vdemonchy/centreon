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
            $scope.status = undefined
            $scope.itemsPerPage = 25
            $scope.pageNumber = 1

            $http
                .get config.API_STATUS_URL
                .then (response) ->
                    unless response.status is not 200
                        angular.noop()
                        $scope.all = response.data[1]
                        $scope.status =  angular.copy $scope.all

            ###*
            # @ngdoc function
            # @name pager
            # @methodOf app-dashboard-controllers.dashboardCtrl
            # @function
            # @param {Object} $event the event
            # @description TODO
            ###
            $scope.pager = ($event) ->
                all = angular.copy $scope.all
                newpage = $scope.pageNumber - 1
                from = newpage * $scope.itemsPerPage
                sliced = all.slice from, $scope.all.length
                $scope.status = sliced
    ]
