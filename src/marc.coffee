# Description:
# Show MARC stuff.  Loosely based on Ed Summers' Supybot MARC module
#
# Dependencies:
# "xml2js": "0.1.14"
#
# Configuration:
# None
#
# Commands:
# @marc 245 - show description for MARC field 245
# @marc 245 a - show description for MARC field 245 subfield a
# @marc 245 ind2 - show description for MARC field 245 indicator 2
#
# Author:
# jamesrf

xml2js = require 'xml2js'
fs = require 'fs'

util = require 'util'

module.exports = (robot) ->
  robot.hear /^@marc (\d{3})\s?(ind)?(.)?$/i, (msg) ->
    tag = msg.match[1]
    if msg.match[2] == 'ind'
        indicator = msg.match[3]
    else
        subfield = msg.match[3]
    try
        fs.readFile '/opt/sitkabot/scripts/marcdoc.xml', (err, data) ->
            parser = new xml2js.Parser()
            parser.parseString data, (err, result) ->
                for r in result['fields']['field'] when r['$']['tag'] is tag
                    if indicator
                        for s in r['indicator'] when s['$']['position'] is indicator
                            msg.send s['description']
                    else if subfield
                        for s in r['subfield'] when s['$']['code'] is subfield
                            msg.send s['description']
                    else
                        msg.send r['description'] for r in result['fields']['field'] when r['$']['tag'] is tag

    catch error
        console.log('Error with MARC plugin')


