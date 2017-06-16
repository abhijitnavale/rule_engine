class Engine
  require 'redis'
  
  def hello
    puts 'Hello'
  end

  def connect_redis
    redis = Redis.new(
      host: 'localhost',
      port: 6379
      # password: TODO
    )
    puts 'connected to redis'
    redis.set('foo', 'bar');
    puts 'values set'
  end

  def read_data_stream
    value = redis.get('foo');
    puts 'priting value'
    puts value
  end

  def read_rules
  end

  def process_rules
  end
end
