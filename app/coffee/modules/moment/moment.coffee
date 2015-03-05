###
centreon - Criteo
(c) 2015
###
define [
    'angular'
    'angular-animate'
    'angular-route'
    'angular-resource'
    'angular-cookies'
    'angular-sanitize'
    'angular-bootstrap'
    'angular-local-storage'
    'modules/i18n/directives'
    'modules/i18n/factories'
    'modules/i18n/services'
],(
    angular
) ->
    'use strict'
    angular
    .module('angular-timeago', [])
    .directive('timeAgo', [
        'timeAgo', 'nowTime'
        (timeAgo, nowTime) ->
            restrict: 'EA'
            link: (scope, elem, attrs) ->
                fromTime = undefined
                # Track the fromTime attribute
                attrs.$observe 'fromTime', (value) ->
                    fromTime = timeAgo.parse(value)
                # Track changes to time difference
                scope.$watch (->
                    nowTime() - fromTime
                ), (value) ->
                angular.element(elem).text timeAgo.inWords(value)

    ])
    .factory('nowTime', [
      '$window'
      '$rootScope'
      ($window, $rootScope) ->
        nowTime = Date.now()

        updateTime = ->
          $window.setTimeout (->
            $rootScope.$apply ->
              nowTime = Date.now()
              updateTime()
              return
            return
          ), 1000
          return

        updateTime()
        ->
          nowTime
    ])
    .factory('timeAgo', ->
        service = {}
        service.settings =
            refreshMillis: 60000
            allowFuture: false
            strings:
                'en_US':
                    prefixAgo: null
                    prefixFromNow: null
                    suffixAgo: 'ago'
                    suffixFromNow: 'from now'
                    seconds: 'less than a minute'
                    minute: 'about a minute'
                    minutes: '%d minutes'
                    hour: 'about an hour'
                    hours: 'about %d hours'
                    day: 'a day'
                    days: '%d days'
                    month: 'about a month'
                    months: '%d months'
                    year: 'about a year'
                    years: '%d years'
                    numbers: []
                'de_DE':
                    prefixAgo: 'vor'
                    prefixFromNow: null
                    suffixAgo: null
                    suffixFromNow: 'from now'
                    seconds: 'weniger als einer Minute'
                    minute: 'ca. einer Minute'
                    minutes: '%d Minuten'
                    hour: 'ca. einer Stunde'
                    hours: 'ca. %d Stunden'
                    day: 'einem Tag'
                    days: '%d Tagen'
                    month: 'ca. einem Monat'
                    months: '%d Monaten'
                    year: 'ca. einem Jahr'
                    years: '%d Jahren'
                    numbers: []
                'he_IL':
                    prefixAgo: null
                    prefixFromNow: null
                    suffixAgo: 'לפני'
                    suffixFromNow: 'מעכשיו'
                    seconds: 'פחות מדקה'
                    minute: 'כדקה'
                    minutes: '%d דקות'
                    hour: 'כשעה'
                    hours: 'כ %d שעות'
                    day: 'יום'
                    days: '%d ימים'
                    month: 'כחודש'
                    months: '%d חודשים'
                    year: 'כשנה'
                    years: '%d שנים'
                    numbers: []
                'pt_BR':
                    prefixAgo: null
                    prefixFromNow: 'daqui a'
                    suffixAgo: 'atrás'
                    suffixFromNow: null
                    seconds: 'menos de um minuto'
                    minute: 'cerca de um minuto'
                    minutes: '%d minutos'
                    hour: 'cerca de uma hora'
                    hours: 'cerca de %d horas'
                    day: 'um dia'
                    days: '%d dias'
                    month: 'cerca de um mês'
                    months: '%d meses'
                    year: 'cerca de um ano'
                    years: '%d anos'
                    numbers: []
                'fr_FR':
                    prefixAgo: 'il y a'
                    prefixFromNow: null
                    suffixAgo: null
                    suffixFromNow: 'from now'
                    seconds: 'moins d\'une minute'
                    minute: 'environ une minute'
                    minutes: '%d minutes'
                    hour: 'environ une heure'
                    hours: 'environ %d heures'
                    day: 'un jour'
                    days: '%d jours'
                    month: 'environ un mois'
                    months: '%d mois'
                    year: 'environ un an'
                    years: '%d ans'
                    numbers: []

        service.inWords = (distanceMillis) ->
            lang = document.documentElement.lang
            $l = service.settings.strings[lang]

            substitute = (stringOrFunction, number) ->
                string = if angular.isFunction(stringOrFunction) then stringOrFunction(number, distanceMillis) else stringOrFunction
                value = $l.numbers and $l.numbers[number] or number
                string.replace /%d/i, value

            if typeof $l == 'undefined'
                $l = service.settings.strings['en_US']
            prefix = $l.prefixAgo
            suffix = $l.suffixAgo
            if service.settings.allowFuture
                if distanceMillis < 0
                    prefix = $l.prefixFromNow
                    suffix = $l.suffixFromNow
            seconds = Math.abs(distanceMillis) / 1000
            minutes = seconds / 60
            hours = minutes / 60
            days = hours / 24
            years = days / 365
            words = seconds < 45 and substitute($l.seconds, Math.round(seconds)) or seconds < 90 and substitute($l.minute, 1) or minutes < 45 and substitute($l.minutes, Math.round(minutes)) or minutes < 90 and substitute($l.hour, 1) or hours < 24 and substitute($l.hours, Math.round(hours)) or hours < 42 and substitute($l.day, 1) or days < 30 and substitute($l.days, Math.round(days)) or days < 45 and substitute($l.month, 1) or days < 365 and substitute($l.months, Math.round(days / 30)) or years < 1.5 and substitute($l.year, 1) or substitute($l.years, Math.round(years))
            separator = if $l.wordSeparator == undefined then ' ' else $l.wordSeparator
            if lang == 'he_IL'
                [
                    prefix
                    suffix
                    words
                ].join(separator).trim()
            else
                [
                    prefix
                    words
                    suffix
                ].join(separator).trim()

        service.parse = (iso8601) ->
            if angular.isNumber(iso8601)
                return parseInt(iso8601, 10)
            if iso8601 instanceof Date
                return iso8601
            s = (iso8601 or '').trim()
            s = s.replace(/\.\d+/, '')
            # remove milliseconds
            s = s.replace(/-/, '/').replace(/-/, '/')
            s = s.replace(/T/, ' ').replace(/Z/, ' UTC')
            s = s.replace(/([\+\-]\d\d)\:?(\d\d)/, ' $1$2')
            # -04:00 -> -0400
            new Date(s)

        service

    )
    .filter 'timeAgo', [
        'nowTime', 'timeAgo'
        (nowTime, timeAgo) ->
            (value) ->
                fromTime = timeAgo.parse(value)
                diff = nowTime() - fromTime
                timeAgo.inWords diff
    ]
