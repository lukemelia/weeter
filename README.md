Weeter accepts a set of Twitter users to follow and terms to track, subscribes using Twitter's streaming API, and makes a POST to your app with each new tweet (or tweet deletion).

Getting set up
==============

    $ bundle install

Make a copy of the weeter.conf.example file named weeter.conf. Twitter configuration, client app configuration and weeter configuration are defined in separate
blocks. To configure how you connect to Twitter (basic auth or oauth), modify the twitter section of the configuration. 

To configure how weeter connects to your client app -- its (optional) authentication, and urls -- modify the client app configuration section:

* _subscriptions_url_: The URL at which to find JSON describing the Twitter users to follow (maximum 5,000 at the default API access level) and the terms to track (maximum 400 at the default API access level). Example content:
    `{"follow":"19466709", "759251"},{"track":"#lolcats","#bieber"}`
* _publish_url_: The URL to which new tweets should be posted. Request will be sent with POST method. Example body:
    `id=1111&twitter_user_id=19466709&text=Wassup`
* _delete_url_: The URL to which data about deleted tweets should be posted. Request will be sent with DELETE method. Example body:
    `id=1111&twitter_user_id=19466709`

Weeter is configured to use 7337 as a default listening port. If you have changes to your subscriptions data, POST the full JSON to the weeter's root URL. This will trigger weeter to reconnect to Twitter with the updated filters in place.

Running weeter
==============

You have two options. Run it as a standalone daemon, or run it as a rack app under thin.

Running weeter as a daemon
--------------------------

    $ bin/weeter_control start

This starts weeter as a daemon. For other commands and options, run:

    $ bin/weeter_control --help

Running weeter as a rack app under thin
---------------------------------------

    $ bundle exec thin start -R config.ru -p 7337


Running specs
=============

    $ bundle exec rspec spec/

To Do
=====
- Error reporting
- Make tweet filtering strategy (re-tweets, replies, etc.) more flexible
- Add specs for client app proxy
- integration tests

Credits
======
Thanks to Weplay for initial development and open sourcing weeter. In particular, credit goes to Noah Davis and Joey Aghion. Further development by Luke Melia at Yapp.

License
=======
weeter is available under the terms of the MIT License http://www.opensource.org/licenses/mit-license.php
