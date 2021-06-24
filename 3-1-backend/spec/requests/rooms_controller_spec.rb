require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:json) { JSON.parse(response.body)}
  let(:current_user) { create(:user) }
  let(:user) { create(:user) }

  describe 'GET /rooms' do
    let(:room) { create(:room) }
    let(:auth_headers) { current_user.create_new_auth_token }
    let!(:e1) { create(:entry, user: current_user, room: room ) }
    let!(:e2) { create(:entry, user: user, room: room ) }
    context "認証済みのユーザーの場合" do
      it '正しいjsonを返すこと' do
        get "/api/v1/rooms", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json).to eq(
          "rooms" => [
            {
              "id" => room.id,
              "unread_message_count" => 0,
              "user" => {
                "id" => user.id,
                "name" => user.name,
                "image" => Variable::Default_image,
              }
            }
          ],
          "pagination" => {
            "current" => 1,
            "previous" => nil,
            "next" => nil,
            "limit_value" => 3,
            "pages" => 1,
            "count" => 1
          }
        )
      end
    end

    context "認証していないユーザーの場合" do
      it '401エラーを返すこと' do
        get "/api/v1/rooms"

        expect(response.status).to eq(401)
      end
    end
  end

  describe 'GET /rooms/:id/' do
    let(:room) { create(:room) }
    let(:auth_headers) { current_user.create_new_auth_token }

    let!(:message) { create(:message, user: current_user, room: room ) }
    let!(:e1) { create(:entry, user: current_user, room: room ) }
    let!(:e2) { create(:entry, user: user, room: room ) }
    context "roomに所属しているuserの場合" do
      it '正しいjsonを返すこと' do
        get "/api/v1/rooms/#{room.id}", headers: auth_headers

        expect(response.status).to eq(200)
        expect(json).to eq(
          "pagination" => {
            "count" => 1,
            "current" => 1,
            "limit_value" => 6,
            "next" => nil,
            "pages" => 1,
            "previous" => nil
          },
          "room" => {
            "id" => room.id,
            "messages" => [
              {
                "body" => "Test",
                "check" => false,
                "user_id" => current_user.id,
                "user" => {
                  "id" => current_user.id,
                  "image" => Variable::Default_image,
                  "name" => current_user.name
                }
              }
            ]
          }
        )
      end
    end

    context "roomに所属していないユーザーの場合" do
      let(:other_user) { create(:user) }
      let(:other_user_auth_headers) { other_user.create_new_auth_token }
      it '403エラーを返すこと' do
        get "/api/v1/rooms/#{room.id}", headers: other_user_auth_headers

        expect(response.status).to eq(403)
      end
    end

    context "認証していないユーザーの場合" do
      it '401エラーを返すこと' do
        get "/api/v1/rooms/#{room.id}"

        expect(response.status).to eq(401)
      end
    end
  end

  describe 'POST /users/:id/rooms' do
    let(:auth_headers) { current_user.create_new_auth_token }
    context "認証済みのユーザーの場合" do
      it 'roomを作成できること' do
        post "/api/v1/users/#{user.id}/rooms", params: {}, headers: auth_headers

        # 200？
        expect(response.status).to eq(200)
        expect(json.keys).to include('room')
      end
    end

    context "認証していないユーザーの場合" do
      it '401エラーを返すこと' do
        post "/api/v1/users/#{user.id}/rooms", params: {}

        expect(response.status).to eq(401)
      end
    end
  end
end