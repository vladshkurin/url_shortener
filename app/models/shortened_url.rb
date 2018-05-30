class ShortenedUrl < ApplicationRecord
  UNIQUE_ID_LENGTH = 6
  VALID_URL = /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
  validates :original_url, presence: true, on: :create
  validates_format_of :original_url, with: VALID_URL
  before_create :generate_short_url
  before_create :sanitize

  def generate_short_url
    url = [*('a'..'z'), *('0'..'9')].sample(UNIQUE_ID_LENGTH).join
    old_url = ShortenedUrl.where(short_url: url).last
    if old_url.present?
      generate_short_url
    else
      self.short_url = url
    end
  end

  def find_duplicate
    ShortenedUrl.find_by_sanitize_url(sanitize_url)
  end

  def new_url?
    find_duplicate.nil?
  end

  def sanitize
    original_url.strip!
    self.sanitize_url = original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, '')
    self.sanitize_url = "https://#{sanitize_url}"
  end
end
