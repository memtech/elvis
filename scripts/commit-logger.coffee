# Description:
#   A simple interaction with the built in HTTP Daemon
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
  channels = process.env.COMMIT_LOG_CHANNELS.split(",") || []

  sayIn = (channel, text) ->
    envelope = { room: channel }
    robot.send envelope, text

  parseCommit = (commit) ->
    "New commit by [#{commit.author.username}]: #{commit.message} (#{commit.url})"

  robot.router.post "/hubot/commit-webhook", (req, res) ->
    commits = req.body.commits

    for commit in commits
      parsed = parseCommit(commit)
      for channel in channels
        console.log "Saying in #{channel}: #{parsed}"
        sayIn channel, parsed
