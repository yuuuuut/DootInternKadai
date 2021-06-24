require 'rails_helper'

url = '/api/v1'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'GET /users' do
    context "認証済みのユーザーの場合" do
      let(:auth_headers) { create(:user).create_new_auth_token }
      it '正常に動作すること' do

        get "#{url}/users", headers: auth_headers

        expect(response.status).to eq(200)
      end
    end

    context "認証していないユーザーの場合" do
      it '401エラーを返すこと' do
        get "#{url}/users"

        expect(response.status).to eq(401)
      end
    end
  end
end