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

  def num_clicks
    self.visits.select(:id).count
  end

  def num_uniques
    self.visitors.select(:id).count
    # self.visitors.select(:id).distinct.count
  end

  def num_recent_uniques
    self.visitors.select(:id).where(self.created_at < 10.minutes.ago).count
    # self.visitors.select(:id).where(self.created_at < 10.minutes.ago).distinct.count
  end

  belongs_to :submitter,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id

  has_many :visitors,
    Proc.new { distinct },
    :through => :visits,
    :source => :users

end
