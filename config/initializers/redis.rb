require 'redis'
Redis = Redis.new(host: ENV.fetch('REDIS_HOST', '192.168.99.100'))