# frozen_string_literal: true

Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['ELASTICSEARCH_URL']
begin
  unless Message.__elasticsearch__.index_exists?
    Message.__elasticsearch__.create_index!
    Message.import force: true
  end
rescue StandardError
  puts 'Failed to load elasticsearch at'
  return
end
