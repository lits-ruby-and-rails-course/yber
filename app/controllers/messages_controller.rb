class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_users
  layout "dashboard.html"

  # GET /messages
  # GET /messages.json
  def index
    @to_id = params[:id]
    @messages = Message.where(from_id: current_user.id, to_id: @to_id)||Message.where(to_id: current_user.id, from_id: @to_id)
    @message = Message.new
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @messages = Message.where(from_id: current_user.id, to_id: @to_id)
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  def new_message
    @to_id = params[:id]
    @message = Message.new
  end

  def index_all
    @messages = Message.where(from_id: current_user.id) || Message.where(to_id: current_user.id)
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    #@message.update_attribute(:text, params["new_text"])
    respond_to do |format|
      if @message.update_attribute(:text, params["new_text"])
        #format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        #format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    def set_users
      @users = current_user.rider? ? User.where(role: User.roles[:driver]) : User.where(role: User.roles[:rider])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:from_id, :to_id, :text)
    end
end
