###
RackMonkey - Criteo
(c) 2014
###
define [
    "angular"
    "modules/dashboard/factories/DashboardFactory"
    "angular-resource"
], (
    angular,
    DashboardFactory
) ->
    "use strict"
    angular
        .module 'app-dashboard-factories', []
        .factory 'dashboardFactory', DashboardFactory
