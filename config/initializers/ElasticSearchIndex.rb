Elasticsearch::Model.client = Elasticsearch::Client.new host: 'http://192.168.99.100:9200/'
unless Message.__elasticsearch__.index_exists?
  puts "HEREEE"
  Message.__elasticsearch__.create_index!
  Message.import force: true
end