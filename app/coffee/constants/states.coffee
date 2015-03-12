###
app - Criteo
(c) 2014
###
define [], ->
    "use strict"

    host : [
        {
            id : 0
            state : 'Up'
        },
        {
            id : 1
            state : 'Down'
        },
        {
            id : 2
            state : 'Unreachable'
        },
        {
            id : 3
            state : 'Pending'
        }
    ]

    service : [
        {
            id : 0
            state : 'Ok'
        },
        {
            id : 1
            state : 'Warning'
        },
        {
            id : 2
            state : 'Critical'
        },
        {
            id : 3
            state : 'Unknown'
        },
        {
            id : 4
            state : 'Pending'
        }
    ]

    criticity : [
        {
            id : 0
            state : 'Minor'
        },
        {
            id : 1
            state : 'Major'
        }
    ]
