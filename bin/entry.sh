#!/bin/bash
set -x

if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup
bundle exec rails s -p 3000 -b '0.0.0.0'