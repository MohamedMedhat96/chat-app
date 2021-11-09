# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages
end
