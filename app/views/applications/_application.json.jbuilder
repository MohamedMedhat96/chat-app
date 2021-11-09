# frozen_string_literal: true

json.extract! application, :id, :token, :name, :created_at, :updated_at
json.url application_url(application, format: :json)
