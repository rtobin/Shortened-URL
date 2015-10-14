class ShortenedUrl < ActiveRecord::Base

  validates :long_url, :presence => true
  validates :short_url, :presence => true
  validates :user_id, :presence => true


  def self.random_code
    code = nil

    until !code.nil? && !ShortenedUrl.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64(16)
    end

    code
  end

end
