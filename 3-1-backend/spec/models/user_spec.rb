require 'rails_helper'

RSpec.describe 'UserModel', type: :model do
  describe 'def user_with_room(user)' do
    let(:current_user) { build_stubbed(:user) }
    let(:user) { build_stubbed(:user) }
    it 'userとのroomが存在する場合、そのroom_idとtrueを返すこと' do
      mock_room_id = 'jdj43n9fif-3dni3n9-nddnejb'
      mock_data = [{ id: mock_room_id }]

      allow(current_user).to receive(:rooms).and_return(mock_data)
      allow(user).to receive(:rooms).and_return(mock_data)

      room_id, is_room = current_user.user_with_room(user)

      expect(room_id).to eq(mock_room_id)
      expect(is_room).to eq(true)
    end

    it 'userとのroomが存在しない場合、空文字とfalseを返すこと' do
      room_id, is_room = current_user.user_with_room(user)

      expect(room_id).to eq('')
      expect(is_room).to eq(false)
    end
  end
end