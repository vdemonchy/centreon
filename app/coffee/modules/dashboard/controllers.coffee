###
app-dashboard - Criteo
(c) 2014
###
define [
    'angular'
    'modules/dashboard/controllers/DashboardCtrl'
],(
    angular
    DashboardCtrl
) ->
    "use strict"
    angular
        .module 'app-dashboard-controllers', []
        .controller 'dashboardCtrl', DashboardCtrl
