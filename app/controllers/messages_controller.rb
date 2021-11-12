# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_application_and_chat
  before_action :set_message, only: %i[show edit update destroy]

  # GET /messages or /messages.json
  def index
    @messages = @chat.messages.all
    render json: @messages, except: %i[id chat_id], status: 200
  end

  # GET /messages/1 or /messages/1.json
  def show
    render json: @message, except: %i[id chat_id], status: 200
  end

  # POST /messages or /messages.json
  def create
    @returnedNumber = Redis.current.incr(@application.token+"-#{@chat.number}-message-number-counter")
    @message = @chat.messages.build(number: @returnedNumber)
    if @message.valid?
      MessageJob.perform_later(@returnedNumber, @chat.number, @application.token, message_params[:data])
       render json: {message_number: @returnedNumber, chat_number: @chat.number}.to_json, status: 200
    else
      Redis.current.DECRBY(@application.token+"-#{@chat.number}-message-number-counter", 1)
      render json: 'Failed to save entity', status: 500
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    if @message.update(data: params[:data])
      render json: @message, except: %i[id chat_id], status: :ok
    else
      render json: {error: @application.errors}.to_json, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy
    render json: '', status: 204
  end

  def search
    return unless params[:query].present?
    @messages = @chat.messages
    @response = @messages.search(params[:query])
    render json: @response, except: %i[id chat_id], status: 200
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_application_and_chat
    unless params[:token].present?
      render json: {error: 'You need to send the application token to see the messages'}.to_json, status: 400
      return
    end
    unless params[:chat_number].present?
      render json: {error: 'You need to send the chat number to see the messages'}.to_json, status: 400
      return
    end
    begin
      @application = Application.find_by!(token: params[:token])
    rescue StandardError => e
      render json: {error: "The application token you have sent doesn't belong to any application"}.to_json, status: 400
      return
    end

    begin
      @chat = @application.chats.find_by!(number: params[:chat_number])
    rescue StandardError => e
      render json:{error: "The chat number you have sent doesn't belong to any chat in this application"}.to_json, status: 400
      return
    end
  end

  def set_message
    @message = @chat.messages.find_by!(number: params[:number])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:data)
  end
end
