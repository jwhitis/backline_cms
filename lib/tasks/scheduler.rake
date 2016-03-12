namespace :tweets do

  desc "Discard old tweets in exchange for new ones"
  task refresh: :environment do
    TweetRefresher.refresh_all
  end

end