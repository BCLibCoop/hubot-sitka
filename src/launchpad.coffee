# Description:
#   Generates links to LP tickets
#
# Commands:
#   @lp <ticketid> - generates a link to that launchpad bug

module.exports = (robot) ->

  robot.hear /\@lp (\d+)/i, (msg) ->

    msg.send "https://bugs.launchpad.net/bugs/" + msg.match[1]

