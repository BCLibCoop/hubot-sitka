# Description:
#   Interacts with Evergreen's SuperCat API
#
# Commands:
#   hubot show bib <bibid> - Shows MARCTXT of that bib
#   hubot show opac bib <bibid> - Shows bib in OPAC
#   hubot show marcxml bib <bibid> - Shows bib in MARCXML

baseurl = "catalogue.bclibraries.ca"

module.exports = (robot) ->

  robot.respond /show (.+?)?\s?(bib|authority) (\d+)/i, (msg) ->

    if msg.match[1] in ['opac','marcxml','mods32']
        format = msg.match[1]
    else
        format = 'marctxt'
    
    bibid = msg.match[3]

    rectype = 'record' 
    rectype = 'authority' if msg.match[2] == 'authority'

    recUrl   = "http://" + baseurl + "/opac/extras/supercat/retrieve/" + escape(format) + "/" + rectype + "/" + escape(bibid)

    msg.send recUrl

