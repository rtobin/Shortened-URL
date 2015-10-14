class Visit < ActiveRecord::Base

  validates :url_id, :user_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(url_id: shortened_url.id, user_id: user.id)
  end

  belongs_to :users,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id

  belongs_to :shortened_urls,
    :class_name => "ShortenedUrl",
    :foreign_key => :url_id,
    :primary_key => :id


end
