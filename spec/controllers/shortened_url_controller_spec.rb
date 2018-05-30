require 'rails_helper'

RSpec.describe ShortenedUrlsController, type: :controller do
  describe 'index' do
    it 'should get status OK' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'show' do
    before :each do
      @url = create(:shortened_url, short_url: 'qwer')
    end

    it 'should get full URL' do
      get :show, params: { short_url: @url.short_url }
      expect(assigns(:url)).to eq @url
    end
  end

  describe 'create' do
    context 'with valid params' do
      context 'with new url' do
        it 'creates a new url' do
          expect do
            post :create, params: { original_url: 'http://someaddres.com' }
          end.to change(ShortenedUrl, :count).by(1)
        end
      end
      context 'with existing url' do
        before :each do
          @url = create(:shortened_url)
        end
        it 'should not add new url' do
          expect do
            post :create, params: { original_url: 'http://github.com' }
          end.not_to change(ShortenedUrl, :count)
        end
      end
    end
    context 'with invalid params' do
      it 'should not create null url' do
        expect do
          post :create, params: { original_url: nil }
        end.not_to change(ShortenedUrl, :count)
      end
    end
  end
end
