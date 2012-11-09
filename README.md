# Pigstream

Pigstream is a twitterbot that taunts people who can't beat a level on angry birds, powering the [@GloatingPig](http://twitter.com/GloatingPig) account.  It's a typical twitter reply bot.

![screenshot](https://raw.github.com/mroth/pigstream/master/screenshots/ss2.png)

However, most twitter reply-bots (including the earlier version of this bot, which used the popular chatterbot framework) have to constantly poll Twitter, and maintain some sort of state to avoid spamming the shit out of everything.

Here, we instead use the twitter streaming API, which has the following benefits:

 - No polling!  Save your rate limit for actually performing actions writing into Twitter.
 - No state to maintain! Twitter only sends us new events in realtime (in theory).
 - It's more fun when a reply-bot responds instantly to someone, not 10 minutes later.  This makes that easy.

All this makes pigstream very efficient, and it happily runs in a free Heroku instance.

Almost all the "work" here is done by the `twitter` and `tweetstream` gems -- that said, I'll probably abstract this pattern into a ruby gem at some point if I find others would like to use it that way instead of modifying my code.

## Setup

Clone, `bundle install` to get dependencies.  Pigstream uses the typical Heroku pattern of putting keys in config vars, see https://devcenter.heroku.com/articles/config-vars for more details on that if you aren't familiar.  For local development, drop them in a `.env` file, and then do `foreman start` to run the process.

Note: this program uses a minor idiom that require ruby 1.9.3 (in particular, passing a range to `rand()`).  I prefer clean code over reverse compatibility here -- deal with it!

