require 'multi_json'

module Weeter

  class TweetItem
    def initialize(tweet_hash)
      @tweet_hash = tweet_hash
    end

    def deletion?
      !@tweet_hash['delete'].nil?
    end

    def retweeted?
      !@tweet_hash['retweeted_status'].nil? || @tweet_hash['text'] =~ /^RT @/i
    end

    def reply?
      !@tweet_hash['in_reply_to_user_id_str'].nil? || @tweet_hash['text'] =~ /^@/
    end

    def publishable?
      !retweeted? && !reply?
    end

    def [](val)
      @tweet_hash[val]
    end

    def to_json
      MultiJson.encode(@tweet_hash)
    end

    def limiting_facets
      self['entities']['hashtags'].map do |tag|
        tag['text'].downcase.chomp
      end
    end
  end
end
