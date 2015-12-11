require 'resque'

module ResqueScheduler
  class << self
    def namespace=(ns)
      @namespace = ns
      @redis = nil  # Reset redis namespace object so that it will get re-created
    end
    
    def namespace
      @namespace
    end
    
    # Returns the current Redis connection. If none has been created, will
    # create a new one.
    def redis
      return @redis if @from_redis.equal?(Resque.redis)
      @from_redis = Resque.redis
      @redis = @from_redis.clone
      @redis.namespace = namespace unless namespace.nil?
      @redis
    end
  end
end