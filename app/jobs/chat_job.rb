class ChatJob < ApplicationJob
  queue_as :default

  def perform(number, token)
    application = Application.find_by(token: token)
    @chat = application.chats.build(number: number)
    @chat.save!
    return
  end
end
