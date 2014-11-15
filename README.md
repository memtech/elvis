### Click here to see recent Elvis build history
[![wercker status](https://app.wercker.com/status/c7d82813f21d79049b027779bd4781e4/m "wercker status")](https://app.wercker.com/project/bykey/c7d82813f21d79049b027779bd4781e4)

## Get started contributing
* Install [NodeJS](http://nodejs.org/)
* Clone this repo: `git clone git@github.com:memtech/elvis.git`
* Add a script to `/scripts/`
* Push to github

## Testing your additions locally
Run `bin/hubot` to start up a local console that you can talk to without having to mess around with IRC.

```sh
$ bin/hubot
... stuff happens...
Hubot> hubot rb 1*10
Hubot> Shell: => 10
```


## Where to find more scripts:
* http://hubot-script-catalog.herokuapp.com/
* Any of the ones listed at [github/hubot-scripts](https://github.com/github/hubot-scripts) can be included just by adding the filename to `hubot-scripts.json`.

## Add an annoying image macro
  Just edit [scripts/image_macro_responder.coffee](scripts/image_macro_responder.coffee) and if it doesn't break the build it will auto-deploy.

# Hubot

This is a version of GitHub's Campfire bot, hubot. He's pretty cool.

This version is designed to be deployed on [Heroku][heroku]. This README was generated for you by hubot to help get you started. Definitely update and improve to talk about your own instance, how to use and deploy, what functionality he has, etc!

[heroku]: http://www.heroku.com

### Testing Hubot Locally

You can test your hubot by running the following.

    % bin/hubot

You'll see some start up output about where your scripts come from and a
prompt.

    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading adapter shell
    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading scripts from /home/tomb/Development/hubot/scripts
    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading scripts from /home/tomb/Development/hubot/src/scripts
    Hubot>

Then you can interact with hubot by typing `hubot help`.

    Hubot> hubot help

    Hubot> animate me <query> - The same thing as `image me`, except adds a few
    convert me <expression> to <units> - Convert expression to given units.
    help - Displays all of the help commands that Hubot knows about.
    ...

# Help, I don't have node/python/ruby/redis on my machine but I want to contribute!

We've got a few avenues for you.
1) You can just write new code directly in Github.  If you're lucky it might work.
2) You can download this and run `vagrant up` to run Elvis in a vagrant virtual machine.  You'll need to install VirtualBox and Vagrant first but they run pretty much anywhere.
3) You can install docker and fig and then run `fig build; fig run hubot bin/connect` and he'll log right into IRC.
