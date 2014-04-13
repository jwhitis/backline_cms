desc "Save new tweets and discard old tweets"
task refresh_tweets: :environment do
  puts "Refreshing tweets..."
  TweetRefresher.refresh
  puts "All done."
end
