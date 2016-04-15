require 'resque'

module Resque
  module Scheduler
    module Redis
      attr_reader :namespace

      def namespace=(ns)
        @namespace = ns
        # Reset redis namespace object so that it will get re-created
        @redis = nil
      end

      # Returns the current Redis connection. If none has been created, will
      # create a new one.
      def scheduler_redis
        return @redis if @from_redis.equal?(Resque.redis)
        @from_redis = Resque.redis
        @redis = @from_redis.clone
        @redis.namespace = namespace unless namespace.nil?
        @redis
      end
    end
  end
end
