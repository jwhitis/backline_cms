module ApplicationHelper

  def tweet_time tweet
    time = tweet.created_at
    time.to_date == Date.today ? time.strftime("%l:%M%P") : time.strftime("%-m/%-d/%y")
  end

end
