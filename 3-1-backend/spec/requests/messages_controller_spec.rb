require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :request do
  let(:json) { JSON.parse(response.body) }
  let(:current_user) { create(:user) }
  let(:user) { create(:user) }
  let(:room) { create(:room) }
  let(:auth_headers) { current_user.create_new_auth_token }

  let!(:entry1) { create(:entry, user: current_user, room: room ) }
  let!(:entry2) { create(:entry, user: user, room: room ) }

  describe 'POST /rooms/:id/messages' do
    context "認証済みのユーザーの場合" do
      it 'Messageを作成できること' do
        post "/api/v1/rooms/#{room.id}/messages", params: { message: { body: 'Test' } }, headers: auth_headers

        expect(response.status).to eq(200)
        expect(json).to eq(
          "message" => {
            "id" => Message.find_by(body: 'Test').id,
            "body" => 'Test',
            "user_id" => current_user.id
          }
        )
      end
    end

    context "認証していないユーザーの場合" do
      it '401エラーを返すこと' do
        post "/api/v1/rooms/#{room.id}/messages", params: { body: 'Test' }

        expect(response.status).to eq(401)
      end
    end
  end

  describe 'PUT /rooms/:id/messages' do
    context "認証済みのユーザーの場合" do
      let!(:current_user_message) { create(:message, user: current_user, room: room ) }
      let!(:user_message) { create(:message, user: user, room: room ) }
      it 'UserのMessageを更新できること' do
        expect(user_message.check).to eq(false)

        put "/api/v1/rooms/#{room.id}/messages", params: {}, headers: auth_headers

        expect(response.status).to eq(204)
        expect(Message.find(user_message.id).check).to eq(true)
      end

      it 'CurrentUserのMessageは更新しないこと' do
        expect(current_user_message.check).to eq(false)

        put "/api/v1/rooms/#{room.id}/messages", params: {}, headers: auth_headers

        expect(response.status).to eq(204)
        expect(Message.find(current_user_message.id).check).to eq(false)
      end
    end

    context "認証していないユーザーの場合" do
      it '401エラーを返すこと' do
        put "/api/v1/rooms/#{room.id}/messages", params: {}

        expect(response.status).to eq(401)
      end
    end
  end
end