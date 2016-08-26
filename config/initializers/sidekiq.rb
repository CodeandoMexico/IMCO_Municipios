if ENV["REDISTOGO_URL"]
    $redis = Redis.new(url: ENV['REDISTOGO_URL' || "redis://127.0.0.1::6379/"])
end
