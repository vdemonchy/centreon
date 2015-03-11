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
        'states'
        (
            $log
            $http
            $scope
            config
            states
        ) ->
            $scope.status = undefined
            $scope.states = states
            $scope.outputs = []
            $scope.services = []
            $scope.filters = {
                host: []
            }
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
            # @name toggleService
            # @methodOf app-dashboard-controllers.dashboardCtrl
            # @function
            # @param {Object} $event the event
            # @description TODO
            ###
            $scope.toggleService = ($event, id) ->
                i = $scope.services.indexOf id
                if i > -1
                    $scope.services.splice i,1
                else
                    $scope.services.push id

            ###*
            # @ngdoc function
            # @name toggleOutput
            # @methodOf app-dashboard-controllers.dashboardCtrl
            # @function
            # @param {Object} $event the event
            # @description TODO
            ###
            $scope.toggleOutput = ($event, id) ->
                i = $scope.outputs.indexOf id
                if i > -1
                    $scope.outputs.splice i,1
                else
                    $scope.outputs.push id
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
