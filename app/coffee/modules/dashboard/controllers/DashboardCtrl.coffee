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
        'dashboardFactory'
        'authService'
        'config'
        'states'
        (
            $log
            $http
            $scope
            dashboardFactory
            authService
            config
            states
        ) ->
            $scope.status = undefined
            $scope.states = states
            $scope.outputs = []
            $scope.filters = []
            $scope.hostfilter = undefined
            $scope.servicefilter = undefined
            $scope.url = ''
            $scope.itemsPerPage = 25
            $scope.pageNumber = 1
            $scope.loading = false

            dashboardFactory
                .fetchStatus()
                .then (data) ->
                    $scope.all = data[1]
                    $scope.status =  angular.copy $scope.all

            ###*
            # @ngdoc function
            # @name filterByKeyword
            # @methodOf app-dashboard-controllers.dashboardCtrl
            # @function
            # @param {Object} $event the event
            # @description TODO
            ###
            $scope.filterByKeyword = ($event) ->
                $scope.url = ''
                if $scope.hostfilter
                    $scope.url = '&host_name=%' + $scope.hostfilter + '%'
                if $scope.servicefilter
                    $scope.url += '&service_name=%' + $scope.servicefilter + '%'
                if !$scope.loading
                    $scope.loading = true
                    dashboardFactory
                        .fetchStatus $scope.url
                        .then (data) ->
                            $scope.loading = false
                            $scope.all = data[1] or []
                            $scope.status =  angular.copy $scope.all


            ###*
            # @ngdoc function
            # @name toggleService
            # @methodOf app-dashboard-controllers.dashboardCtrl
            # @function
            # @param {Object} $event the event
            # @description TODO
            ###
            $scope.toggleFilter = ($event, type, id) ->
                $scope.filters[type] = {} if !$scope.filters[type]
                $scope.filters[type][id] = ! $scope.filters[type][id]

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
