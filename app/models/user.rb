class User < ActiveRecord::Base

  validates :email, :presence => true

  has_many :submitted_urls,
    :class_name => "ShortenedUrl",
    :foreign_key => :user_id,
    :primary_key => :id

end
