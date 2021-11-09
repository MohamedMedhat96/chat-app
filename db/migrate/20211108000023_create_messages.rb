# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :number
      t.text :data
      t.timestamps
    end
  end
end
