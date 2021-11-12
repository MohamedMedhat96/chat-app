# frozen_string_literal: true

class DefaultWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
  end
end
