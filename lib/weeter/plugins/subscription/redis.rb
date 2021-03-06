require 'multi_json'

module Weeter
  module Plugins
    module Subscription
      class Redis
        include Weeter::Plugins::Net::Redis

        def initialize(client_app_config)
          @config = client_app_config
        end

        def get_initial_filters(&block)
          deferred_get = redis.get(@config.subscriptions_key) do |value|
            if value.nil?
              raise "Expected to find subscription data at redis key #{@config.subscriptions_key}"
            end
            yield MultiJson.decode(value)
          end
          deferred_get.errback do |message|
            Weeter.logger.error(message)
          end
        end

        def listen_for_filter_update(tweet_consumer)
          channel = @config.subscriptions_changed_channel
          pub_sub_redis.subscribe(channel) do |message|
            Weeter.logger.info [:message, channel, message]
            Weeter.logger.info("Retrieving updated filters from redis")
            get_initial_filters do |filter_params|
              Weeter.logger.info("Triggering reconnect Twitter stream with new filters")
              tweet_consumer.reconnect(filter_params)
            end
          end
        end

      protected

        def redis
          @redis ||= create_redis_client
        end

        def pub_sub_redis
          @pub_sub_redis ||= create_redis_client.pubsub
        end

      end
    end
  end
end
