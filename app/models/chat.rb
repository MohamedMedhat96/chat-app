# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :application, counter_cache: true
  has_many :messages
end
