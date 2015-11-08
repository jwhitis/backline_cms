module SubscribersHelper

  def formatted_subscriber_message
    if @site.subscriber_message.present?
      message = @site.subscriber_message
    else
      message = default_subscriber_message
    end

    simple_format(message)
  end

  def default_subscriber_message
    "Just tell us a few things about yourself to access this content. You'll only have to do this once, then you can access everything on our website!\n\nWe won't share your information with anyone, and we won't spam you. We just want to know more about our fans and share occasional announcements with them. And, of course, you'll have the opportunity to opt out of any communications.\n\nThanks!"
  end

end