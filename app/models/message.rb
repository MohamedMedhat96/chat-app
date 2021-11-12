# frozen_string_literal: true

class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat, counter_cache: true

  settings index: {
    "number_of_shards": 1,
    analysis: {
      analyzer: {
        edge_ngram_analyzer: { type: 'custom', tokenizer: 'standard', filter:
          %w[lowercase edge_ngram_filter stop kstem] }
      },
      filter: {
        edge_ngram_filter: { type: 'edge_ngram', min_gram: '3', max_gram:
          '20' }
      }
    },
  } do
    mapping do
      indexes :data, type: 'text', analyzer: 'edge_ngram_analyzer'
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      query: {
        multi_match: {
          query: query,
          fuzziness: 'AUTO',
          fields: [:data]
        }
      }
    ).records.to_a
  end
end
