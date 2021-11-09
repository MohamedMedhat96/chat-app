# frozen_string_literal: true

class AddIndexToApplicationsName < ActiveRecord::Migration[5.2]
  def change
    add_index :applications, :name, unique: true
  end
end
