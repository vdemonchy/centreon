###
@app - Criteo
(c) 2014
###
define [], ->
    "use strict"

    # jshint maxlen: false

    ###*
    # @ngdoc directive
    # @name app-directives.dropDownFilterDirective
    # @description
    #
    # Angular app dropdown filter directive
    #
    # <h2>Settings</h2>
    # <pre>
    # <style type="text/css">
    # </style>
    # </pre>
    ###
    [
        "$log"
        "i18nService"
        (
            $log
            i18nService
        ) ->
            restrict: 'A'
            scope: true
            replace: false
            templateUrl : 'tpl/directives/dropDownFilterDirective.tpl.html'

            link: ($scope, $element, $attrs) ->
                $scope.items = []
                $scope.ddTitle = i18nService.getLabel $attrs.dropDownFilterTitle
                $scope.ddType = $attrs.dropDownFilterType
                $scope.ddEvent = $attrs.dropDownFilterEvent
                $scope.ddField = $attrs.dropDownFilterField or 'name'
                $scope.ddFilter = $scope.$eval $attrs.dropDownFilterBy
                $scope.ddSort = $attrs.dropDownFilterSort

                ###*
                # @ngdoc function
                # @name isFilterBy
                # @methodOf app-directives.dropDownFilterDirective
                # @function
                # @param {Object} $event the event
                # @description select or unselect all items from dropdown
                ###
                $scope.isFilterBy = (item) ->
                    if $scope.ddFilter isnt undefined
                        for filter,index in $scope.ddFilter
                            #console.log 'filterBy', [filter, $scope.filters[filter]]
                            arr = $scope.filters[filter]
                            if arr
                                if item.building
                                    buildingid = item.building.id
                                else if item.room?.building
                                    buildingid = item.room.building.id
                                switch filter
                                    when 'building'
                                        if arr.indexOf(buildingid) is -1
                                            return false
                                    when 'room'
                                        if arr.indexOf(item.room.id) is -1
                                            return false
                    return true

                ###*
                # @ngdoc function
                # @name toggleAllItems
                # @methodOf app-directives.dropDownFilterDirective
                # @function
                # @param {Object} $event the event
                # @description select or unselect all items from dropdown
                ###
                $scope.toggleAllItems = ($event) ->
                    l = $scope.items.length
                    if l is $scope.selectSet[$scope.ddType].length
                        $scope.items = []
                    else
                        for item in $scope.selectSet[$scope.ddType]
                            if $scope.items.indexOf(item.id) is -1
                                $scope.items.push item.id
                    if $scope.items.length > 0
                        $scope.$emit $scope.ddEvent, $scope.items

                ###*
                # @ngdoc function
                # @name dropdownFilterSelect
                # @methodOf app-directives.dropDownFilterDirective
                # @function
                # @description fetch initial items
                ###
                $scope.init = () ->
                    $scope.items = []

                ###*
                # @ngdoc function
                # @name itemClick
                # @methodOf app-directives.dropDownFilterDirective
                # @function
                # @param {Object} $event the event
                # @param {Object} itemid  the id of item
                # @description select or unselect the clicked item
                ###
                $scope.itemClick = ($event, itemid) ->
                    index = $scope.items.indexOf itemid
                    if index > -1
                        $scope.items.splice index,1
                    else
                        $scope.items.push itemid
                    if $scope.items.length > 0
                        $scope.$emit $scope.ddEvent, $scope.items
                    return true

                ###*
                # @ngdoc function
                # @name resetdropdownFilter
                # @methodOf app-directives.dropDownFilterDirective
                # @function
                # @param {Object} $event the event
                # @description empty the items list
                ###
                $scope.resetdropdownFilter = ($event) ->
                    $event.stopPropagation() if $event?.stopPropagation
                    $scope.items = []

                # init directive
                # $scope.init()
    ]
