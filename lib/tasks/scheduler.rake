namespace :tweets do

  desc "Discard old tweets in exchange for new ones"
  task refresh: :environment do
    puts "Refreshing tweets..."
    TweetRefresher.refresh
    puts "All done."
  end

end