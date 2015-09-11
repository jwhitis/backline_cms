class Site < ActiveRecord::Base
  validates_presence_of :homepage_id

  def reload options = nil
    @homepage = nil
    super
  end

  def homepage
    @homepage ||= Page.find(self.homepage_id)
  end

end
