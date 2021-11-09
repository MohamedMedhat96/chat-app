# frozen_string_literal: true

class AddChatIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :chat_id, :integer
    add_index :messages, :chat_id
  end
end
