# Hubot Mute

Allows channels to mute Hubot if quiet is required for whatever reasons. Hubot will not respond to any commands in a muted channel (other than `mute` commands).

[![Build Status](https://travis-ci.org/alexhouse/hubot-mute.png)](https://travis-ci.org/alexhouse/hubot-mute) [![NPM version](https://badge.fury.io/js/hubot-mute.png)](http://badge.fury.io/js/hubot-mute)

## Usage

List all channels currently muted: `hubot mute list`
Mute the channel you're on: `hubot mute`
Mute a specific channel: `hubot mute #development`
Mute **all** channels: `hubot mute all`

Unmute by swapping `mute` for `unmute` above.

## Configuration

This script requires the env variable `HUBOT_MUTE_ROOM_PREFIX` to be set. This is used in determining how to respond to the channel.

For example, if you're on IRC or Slack you'll probably want this setting as `#`. Basecamp should be able to leave it as blank.

## Installation

Add the package `"hubot-mute": "*"` as a dependency in your Hubot package.json file. Then add `"hubot-mute"` to the list in the `external-scripts.json` file.
