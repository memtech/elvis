# Description:
#   Announces github commits for Elvis!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLS:
#   /hubot/commit-webhook
#
# Authors:
# - dpritchett

module.exports = (robot) ->
  channels = (process.env.COMMIT_LOG_CHANNELS || '').split(",") || []
  werckerLink = "http://bit.ly/elvis-builds"

  sayIn = (channel, text) ->
    envelope = { room: channel }
    robot.send envelope, text

  parseCommit = (commit) ->
    "New commit by [#{commit.author.username}]: #{commit.message} (#{commit.url}) Build log: at http://bit.ly/elvis-builds"

  robot.router.post "/hubot/commit-webhook", (req, res) ->
    commits = req.body.commits

    for commit in commits
      parsed = parseCommit(commit)

      # silent commits can be fun!
      unless parsed.match(/#quiet|#silent/)?
        for channel in channels
          console.log "Saying in #{channel}: #{parsed}"
          sayIn channel, parsed

    res.end "Thanks bro."
