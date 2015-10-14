class ShortenedUrl < ActiveRecord::Base

  validates :long_url, :presence => true
  validates :short_url, :presence => true
  validates :user_id, :presence => true

  def self.create_for_user_and_long_url!(user, long_url)
    options = {long_url: long_url,
               short_url: ShortenedUrl.random_code,
               user_id: user.id}
    ShortenedUrl.create!(options)
  end

  def self.random_code
    code = nil

    until !code.nil? && !ShortenedUrl.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64(16)
    end

    code
  end

  belongs_to :submitter,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id

  has_many :visitors,
    :through => :visits
    :source => :users

end
