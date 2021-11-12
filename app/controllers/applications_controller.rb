# frozen_string_literal: true

require 'securerandom'

class ApplicationsController < ApplicationController
  before_action :set_application, except: %i[create index]
  rescue_from ::ActiveRecord::RecordNotUnique, with: :name_duplicated
  # GET /applications or /applications.json
  def index
    @applications = Application.all
    render json: @applications,
           include: { chats: { include: { messages: { except: %i[id chat_id] } }, except: %i[id application_id] } }, except: [:id], status: 200, test: 'test'
  end

  # GET /applications/1 or /applications/1.json
  def show
    render json: @application, except: %i[id], status: 200
  end

  # POST /applications
  def create
    @application = Application.new(token: SecureRandom.hex, name: application_params[:name])

    if @application.save
      render json: @application, except: [:id], status: 200
    else
      render json: { error: 'Failed to save entity' }.to_json, status: 500
    end
  end

  # PATCH/PUT /applications/1 or /applications/1.json
  def update
    if @application.update(name: application_params[:name])
      render json: @application, except: [:id], status: :ok
    else
      render json: { error: @application.errors }.to_json, status: :unprocessable_entity
    end
  end

  # DELETE /applications/1 or /applications/1.json
  def destroy
    @application.destroy
    render json: '', status: 204
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_application
    @application = Application.find_by!(token: params[:token])
  end

  # Only allow a list of trusted parameters through.
  def application_params
    params.require(:application).permit(:name, :token)
  end

  def name_duplicated
    render json: { error: 'The name you entered already exists, enter a different name' }.to_json, status: 400
  end
end
