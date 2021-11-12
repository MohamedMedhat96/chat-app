class MessageJob < ApplicationJob
  queue_as :default

  def perform(number, chat_number, token, data)
    chat = Application.find_by(token: token).chats.find_by(number: chat_number)
    @message = chat.messages.build(number: number, data: data)
    @message.save!
    return
  end
end