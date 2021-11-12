# frozen_string_literal: true

class AddIndexToChatsApplicationsIdAndNumber < ActiveRecord::Migration[5.2]
  def change
    add_index :chats, %i[application_id number], unique: true
  end
end
