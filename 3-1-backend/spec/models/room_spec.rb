require 'rails_helper'

RSpec.describe 'RoomModel', type: :model do
  describe 'def self.room_add_necessary_information(rooms, current_user)' do
    # :user                 (roomに所属する、第2引数でないuser)
    # :last_message         (room内で最後にcreateされたmessage)
    # :unread_message_count (user_idが第2引数でないuserかつcheckがfalseのmessage数)

    let(:current_user) { build_stubbed(:user) }
    let(:user) { build_stubbed(:user) }
    let(:room) { build_stubbed(:room) }
    context "current_message、user_message の順でMessageが存在していた場合" do
      let(:current_message) { build_stubbed(:message, user: current_user, room: room) }
      let(:user_message) { build_stubbed(:message, user: user, room: room) }
      it '正しい値がroomに付与されること。' do
        mock_users_data = [current_user, user]
        mock_messages_data = [current_message, user_message]

        allow(room).to receive(:users).and_return(mock_users_data)
        allow(room).to receive(:messages).and_return(mock_messages_data)

        rooms = Room.room_add_necessary_information([room], current_user)

        expect(rooms[0]['id']).to eq(room.id)
        expect(rooms[0][:user]).to eq(user)
        expect(rooms[0][:last_message]).to eq(user_message)
        expect(rooms[0][:unread_message_count]).to eq(1)
      end
    end

    context "user_message のcheckがtrueだった場合" do
      let(:user_message) { build_stubbed(:message, check: true,  user: user, room: room) }
      it '正しい値がroomに付与されること。' do
        mock_users_data = [current_user, user]
        mock_messages_data = [user_message]

        allow(room).to receive(:users).and_return(mock_users_data)
        allow(room).to receive(:messages).and_return(mock_messages_data)

        rooms = Room.room_add_necessary_information([room], current_user)

        expect(rooms[0]['id']).to eq(room.id)
        expect(rooms[0][:user]).to eq(user)
        expect(rooms[0][:last_message]).to eq(user_message)
        expect(rooms[0][:unread_message_count]).to eq(0)
      end
    end

    context "user_message かつcheckがfalseのmessageが10存在した場合" do
      let(:user_messages) { build_stubbed_list(:message, 10, check: false,  user: user, room: room) }
      it '正しい値がroomに付与されること。' do
        mock_users_data = [current_user, user]
        mock_messages_data = user_messages

        allow(room).to receive(:users).and_return(mock_users_data)
        allow(room).to receive(:messages).and_return(mock_messages_data)

        rooms = Room.room_add_necessary_information([room], current_user)

        expect(rooms[0]['id']).to eq(room.id)
        expect(rooms[0][:user]).to eq(user)
        expect(rooms[0][:last_message]).to eq(user_messages[9])
        expect(rooms[0][:unread_message_count]).to eq(10)
      end
    end
  end
end