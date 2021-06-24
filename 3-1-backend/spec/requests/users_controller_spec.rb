require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:json) { JSON.parse(response.body)}
  let(:current_user) { create(:user) }
  let(:user) { create(:user) }

  describe 'GET /users' do
    context "認証済みのユーザーの場合" do
      let!(:users) { create_list(:user, 10) }
      let(:auth_headers) { current_user.create_new_auth_token }
      it '正しいjsonを返すこと' do
        get "/api/v1/users", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json).to eq(
          "users" => [
            {
              "id" => users[0].id,
              "name" => users[0].name,
              "image" => "https://cdn.vuetifyjs.com/images/john.jpg"
            },
            {
              "id" => users[1].id,
              "name" => users[1].name,
              "image" => "https://cdn.vuetifyjs.com/images/john.jpg"
            },
            {
              "id" => users[2].id,
              "name" => users[2].name,
              "image" => "https://cdn.vuetifyjs.com/images/john.jpg"
            }
          ],
          "pagination" => {
            "current" => 1,
            "previous" => nil,
            "next" => 2,
            "limit_value" => 3,
            "pages" => 4,
            "count" => 11
          }
        )
      end
    end

    context "認証していないユーザーの場合" do
      it '401エラーを返すこと' do
        get "/api/v1/users"

        expect(response.status).to eq(401)
      end
    end
  end

  describe 'GET /users/:id' do
    let(:auth_headers) { current_user.create_new_auth_token }
    context "認証済みのユーザーの場合" do
      it '正しいjsonを返すこと' do
        get "/api/v1/users/#{current_user.id}", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json).to eq(
          "user" => {
            "id" => current_user.id,
            "name" => current_user.name,
            "image" => "https://cdn.vuetifyjs.com/images/john.jpg"
          }
        )
      end
    end

    context "id が current_user.id と一致する場合" do
      it '正しいjsonを返すこと' do
        get "/api/v1/users/#{current_user.id}", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json).to eq(
          "user" => {
            "id" => current_user.id,
            "name" => current_user.name,
            "image" => "https://cdn.vuetifyjs.com/images/john.jpg"
          }
        )
      end
    end

    context "id が user.id と一致する場合" do
      it '正しいjsonを返すこと' do
        get "/api/v1/users/#{user.id}", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json).to eq(
          "user" => {
            "id" => user.id,
            "name" => user.name,
            "image" => "https://cdn.vuetifyjs.com/images/john.jpg",
            "isRoom" => false,
            "roomId" => ''
          }
        )
      end
    end

    context "userとのroomが存在する場合" do
      let(:room) { create(:room) }
      let!(:e1) { create(:entry, user: current_user, room: room ) }
      let!(:e2) { create(:entry, user: user, room: room ) }
      it '正しいjsonを返すこと' do
        get "/api/v1/users/#{user.id}", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json).to eq(
          "user" => {
            "id" => user.id,
            "name" => user.name,
            "image" => "https://cdn.vuetifyjs.com/images/john.jpg",
            "isRoom" => true,
            "roomId" => room.id
          }
        )
      end
    end

    context "認証していないユーザーの場合" do
      it '401エラーを返すこと' do
        get "/api/v1/users/#{user.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end