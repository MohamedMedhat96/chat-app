# frozen_string_literal: true

json.extract! chat, :id, :number, :created_at, :updated_at
json.url chat_url(chat, format: :json)
