require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  it 'is invalid without a url' do
    url = build(:shortened_url, original_url: nil)
    expect(url.valid?).not_to be true
  end
  it 'is valid with a url' do
    url = build(:shortened_url)
    expect(url.valid?).to be true
  end

  it 'is invalid with an invalid url' do
    url = build(:shortened_url, original_url: 'abc')
    expect(url.valid?).not_to be true
  end

  describe 'original_url' do
    before :each do
      @url_github = create(:shortened_url)
      @url_github.save
    end

    it 'should get 6 letters as a short_url' do
      url = build(:shortened_url)
      url.save
      expect(url.short_url).to match(/\A[a-z\d]{6}\z/i)
    end

    it 'should get 6 letters as a short_url' do
      url = build(:shortened_url)
      url.save
      expect(url.short_url).to match(/\A[a-z\d]{6}\z/i)
    end

    it '#find_duplicate finds a duplicate' do
      url = create(:shortened_url)
      expect(url.find_duplicate).to eq @url_github
    end

    it '#new? false if there is no url in DB' do
      url = build(:shortened_url, original_url: 'http://qw.er')
      expect(url.new_url?).to eq true
    end

    it '#new_url? false if url exists in DB' do
      url = create(:shortened_url)
      expect(url.new_url?).to eq false
    end
  end
end
