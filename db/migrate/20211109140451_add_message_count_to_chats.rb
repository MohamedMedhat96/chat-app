class AddMessageCountToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :message_count, :integer, default: 0
  end
end
