###
app
(c) 2015
###
define ['angular'], (angular) ->
    "use strict"

    ["$routeProvider",  ($routeProvider) ->
        $routeProvider.otherwise redirectTo: "/dashboard"
    ]
