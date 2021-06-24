require 'rails_helper'

url = '/api/v1'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:json) { JSON.parse(response.body)}
  describe 'GET /users' do
    context "認証済みのユーザーの場合" do
      let!(:users) { create_list(:user, 10) }
      let(:auth_headers) { create(:user).create_new_auth_token }
      it '正常に動作すること' do
        get "#{url}/users", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json['users'].size).to eq(3)
        expect(json['pagination']['limit_value']).to eq(3)
        expect(json['pagination']['count']).to eq(11)
      end
    end

    context "認証していないユーザーの場合" do
      it '401エラーを返すこと' do
        get "#{url}/users"

        expect(response.status).to eq(401)
      end
    end
  end

  describe 'GET /users/:id' do
    let(:current_user) { create(:user) }
    let(:user) { create(:user) }
    let(:auth_headers) { current_user.create_new_auth_token }
    context "認証済みのユーザーの場合" do
      it '正常に動作すること' do
        get "#{url}/users/#{current_user.id}", headers: auth_headers

        expect(response.status).to eq(200)
      end
    end

    context "id が current_user.id と一致する場合" do
      it '正しいjsonが返されること' do
        get "#{url}/users/#{current_user.id}", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json['user'].keys).to include('id', 'name', 'image')
        expect(json['user']['id']).to eq(current_user.id)
      end
    end

    context "id が user.id と一致する場合" do
      it '正しいjsonが返されること' do
        get "#{url}/users/#{user.id}", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json['user'].keys).to include('id', 'name', 'image', 'isRoom', 'roomId')
        expect(json['user']['id']).to eq(user.id)
        expect(json['user']['isRoom']).to eq(false)
        expect(json['user']['roomId']).to eq('')
      end
    end

    context "userとのroomが存在する場合" do
      let(:room) { create(:room) }
      it '正しいjsonが返されること' do
        create(:entry, user: current_user, room: room )
        create(:entry, user: user, room: room )

        get "#{url}/users/#{user.id}", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json['user'].keys).to include('id', 'name', 'image', 'isRoom', 'roomId')
        expect(json['user']['id']).to eq(user.id)
        expect(json['user']['isRoom']).to eq(true)
        expect(json['user']['roomId']).to eq(room.id)
      end
    end

    context "認証していないユーザーの場合" do
      it '401エラーを返すこと' do
        get "#{url}/users/#{user.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end