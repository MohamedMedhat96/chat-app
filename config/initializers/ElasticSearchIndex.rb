puts ENV['ELASTICSEARCH_URL']
Elasticsearch::Model.client = Elasticsearch::Client.new(host: ENV['ELASTICSEARCH_URL'])
unless Message.__elasticsearch__.index_exists?
  puts "HEREEE"
  Message.__elasticsearch__.create_index!
  Message.import force: true
end