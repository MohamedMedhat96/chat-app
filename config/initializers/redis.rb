require 'redis'
unless ENV['REDIS_HOST'] == nil
  Redis.current = Redis.new(url: 'redis://redis',
                            port: "6379/0",
                            db:   "0")
end