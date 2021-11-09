class AddIndexToMessagesChatIdAndNumber < ActiveRecord::Migration[5.2]
  def change
    add_index :messages, %i[chat_id number], unique: true
  end
end
