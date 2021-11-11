class GuestsCleanupJob < ApplicationJob
  queue_as :default

  def perform(number, chat_number, token)
    chat = Application.find_by(token: token).chats.find_by(number: chat_number)
    chat.messages.build(message_params.merge(number: number))
    @chat_counter = Redis.get(token+"-#{chat_number}-total-message-number-counter")
    chat.update(messages_count: @chat_counter)
  end
end