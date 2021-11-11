Elasticsearch::Model.client = Elasticsearch::Client.new host: 'localhost:9200/'
unless Message.__elasticsearch__.index_exists?
  puts "HEREEE"
  Message.__elasticsearch__.create_index!
  Message.import force: true
end