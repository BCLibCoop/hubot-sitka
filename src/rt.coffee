# Description:
#   Generates links to RT tickets
#
# Commands:
#   @rt <ticketid> - generates a link to that RT ticket

module.exports = (robot) ->

  robot.hear /\@rt (\d+)/i, (msg) ->

    msg.send "https://support.sitka.bclibraries.ca/Ticket/Display.html?id=" + msg.match[1]

