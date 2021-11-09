# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, only: %i[show edit update destroy]

  # GET /chats or /chats.json
  def index
    @chats = @application.chats.all
    render json: @chats, include: { messages: { except: %i[id chat_id] } },
           except: %i[id application_id], status: 200
  end

  # GET /chats/{number}
  def show
    render json: @chat, include: { messages: { except: %i[id chat_id] } },
           except: %i[id application_id], status: 200
  end

  # GET /chats/new
  def new
    @chat = @application.chats.build(chat_params)
  end

  # POST /chats or /chats.json
  def create
    @chat = @application.chats.build(chat_params)

    if @chat.save
      render json: @chat, except: %i[id application_id], status: 200
    else
      render json: 'Failed to save entity', status: 500
    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    if @chat.update(number: params[:new_number])
      render json: @chat, except: %i[id application_id], status: :ok
    else
      render json: @chat.errors, except: %i[id application_id],status: :unprocessable_entity
    end
  end

  # DELETE /chats or /chats/1.json
  def destroy
    @chat.destroy
    render json: '', status: 204
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_application
    unless params[:token].present?
      render json: 'You need to send the application token to see the chats', status: 400
      return
    end
    begin
      @application = Application.find_by!(token: params[:token])
    rescue StandardError => e
      render json: "The application token you have sent doesn't belong to any application", status: 400
    end
  end

  def set_chat
    @chat = @application.chats.find_by!(number: params[:number])
  end

  # Only allow a list of trusted parameters through.
  def chat_params
    params.require(:chat).permit(:number)
  end
end
