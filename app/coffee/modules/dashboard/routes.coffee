###
app-dashboard - Criteo
(c) 2015
###
define ['angular'], (angular) ->
    "use strict"

    ["$routeProvider",  ($routeProvider) ->

        # dashboard
        $routeProvider.when "/dashboard",
            templateUrl: "tpl/dashboard.tpl.html"
            controller: "dashboardCtrl"
            resolve:
                lang: ["i18nFactory", (i18nFactory) ->
                    i18nFactory.getBundles()
                ]
    ]
