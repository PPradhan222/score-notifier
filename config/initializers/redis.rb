$redis = Redis::Namespace.new("score-notifier", :redis => Redis.new)