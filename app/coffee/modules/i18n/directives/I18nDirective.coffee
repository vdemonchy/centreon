###
RackMonkey - Criteo
(c) 2014
###
define [], ->
    "use strict"

    # jshint maxlen: false

    ###*
    # @ngdoc directive
    # @name app-directives.i18nDirective
    # @description
    #
    # Angular app i18n directive.
    #
    # <h2>Settings</h2>
    # <pre>
    # <style type="text/css">
    # </style>
    # </pre>
    ###
    [
        "$log"
        "$sce"
        "i18nService"
        (
            $log
            $sce
            i18nService
        ) ->

            restrict: "A"
            scope: false
            ###*
            # @ngdoc function
            # @name compile
            # @methodOf app-directives.i18nDirective
            # @function
            # @description TODO
            ###
            compile: (tElement, tAttrs, transclude) ->

                ###*
                # @ngdoc function
                # @name setElement
                # @methodOf app-directives.i18nDirective
                # @function
                # @description update attributes to the current i18n element
                ###
                setElement = (attr, attrValue) ->
                    i18nEl = i18nService.getLabel attrValue
                    tAttrs.$set attr, $sce.getTrustedHtml i18nEl

                ###*
                # @ngdoc function
                # @name translate
                # @methodOf app-directives.i18nDirective
                # @function
                # @description retrieve the bundle according to the key
                ###
                translate = (attr, elmt) ->
                    unless attr.i18n is ""
                        html = $sce.getTrustedHtml(
                            i18nService.getLabel attr.i18n
                        )
                        if attr.i18nReplace
                            elmt.replaceWith html
                        else if attr.i18nPrepend
                            elmt.prepend html
                        else
                            elmt.append html

                setElement "title", tAttrs.i18nTitle if tAttrs.i18nTitle
                setElement "alt", tAttrs.i18nAlt if tAttrs.i18nAlt
                setElement "name", tAttrs.i18nName if tAttrs.i18nName
                setElement "href", tAttrs.i18nHref if tAttrs.i18nHref
                setElement "placeholder", tAttrs.i18nPlaceholder if tAttrs.i18nPlaceholder
                translate tAttrs, tElement if tAttrs.i18n

                pre: preLink = (scope, iElement, iAttrs, controller) ->

                post: postLink = (scope, iElement, iAttrs, controller) ->
    ]
