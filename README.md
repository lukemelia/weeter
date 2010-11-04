Weeter accepts a set of Twitter users to follow, and makes a POST to your app with each new tweet (or tweet deletion).

Getting set up
==============

    $ bundle install

Make a copy of the weeter.conf.example file named weeter.conf. Modify its values for your environment. Configurable attributes include:

* _basic_auth_: Twitter account credentials for use in connecting to the streaming API. `{:username => "david", :password => "secr3tp2ssw0rd"}`
* _oauth_: OAuth credentials for use in connecting to the streaming API.

    {:consumer_key => 'consumerkey',  
     :consumer_secret => 'consumersecret',  
     :access_key => 'accesskey',  
     :access_secret => 'access_secret'}

* _subscriptions_url_: The URL at which to find JSON describing the Twitter users to follow (maximum 5,000 at the default API access level). Example content:
    `[{"twitter_user_id":"19466709"},{"twitter_user_id":"759251"}]`
* _publish_url_: The URL to which new tweets should be posted. Example POST body:
    `id=1111&twitter_user_id=19466709&text=Wassup`
* _delete_url_: The URL to which data about deleted tweets should be posted. Example DELETE body:
    `id=1111&twitter_user_id=19466709`
* _listening_port_: The port at which to listen for updated lists of Twitter users to follow. Default: 7337.
* _log_path_: Default: log/weeter.log

Running weeter
==============

    $ bin/weeter_control start

This starts weeter as a daemon. For other commands and options, run:

    $ bin/weeter_control --help


Running specs
=============

    $ bundle exec rspec spec/


To Do
=====
- Error reporting
- Gemify
- Don't hard-code tweet filtering strategy (re-tweets, replies, etc.)
