class Video < ActiveRecord::Base
  validates_presence_of :title, :embed

  def pretty_created_at
    created_at.strftime("%-m-%-d-%Y")
  end

  def self.published
    where(published: true)
  end

end
