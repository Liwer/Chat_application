class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  # GET /chats
  # GET /chats.json
  def index
    @chats = Chat.all
    @messages = Message.unread_by(current_user)
    @message_count = @messages.count
    @current_user_chats = current_user.chats
  end

  # GET /chats/1
  # GET /chats/1.json
  def show
    @chat = Chat.find(params[:id])
    if @chat.users.include?(current_user) == true
      @messages = @chat.messages
      @messages.mark_as_read! :all, :for => current_user
      @users_in_chat = @chat.users
      @current_chat = @chat.user_chats.where(:user_id => current_user.id)
    else 
      redirect_to :back
    end
  end

  # GET /chats/new
  def new
    @chat = Chat.new
    @users = User.all_except(current_user)
  end

  # GET /chats/1/edit
  def edit
    @chat = Chat.find(params[:id])
    if @chat.users.include?(current_user) == true
      @users = User.all_except(current_user)
    else
      redirect_to :back
    end 
  end

  # POST /chats
  # POST /chats.json
  def create
    @users = User.all_except(current_user)
    @chat = Chat.new(chat_params)
    user_ids = params[:chat][:user_ids] 
    user_ids.delete("")
    users = User.where(id: user_ids)
    @chat.users << users
    if @chat.users == [] 
      redirect_to :back
    else 
      @chat.users << current_user
      respond_to do |format|
        if @chat.save
          format.html { redirect_to @chat, notice: 'Chat was successfully created.' }
          format.json { render :show, status: :created, location: @chat }
        else
          format.html { render :new }
          format.json { render json: @chat.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  # PATCH/PUT /chats/1
  # PATCH/PUT /chats/1.json
  def update
    @chat = Chat.find(params[:id])
    @chat.users = [] 
    user_ids = params[:chat][:user_ids]
    user_ids.delete("")
    users = User.where(id: user_ids)
    @chat.users << users
    @chat.users << current_user
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to @chat, notice: 'Chat was successfully updated.' }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /chats/1
  # DELETE /chats/1.json
  def destroy 
    if @chat.users.include?(current_user) == true
      @chat.destroy
      respond_to do |format|
        format.html { redirect_to chats_url, notice: 'Chat was successfully destroyed.' }
        format.json { head :no_content }
      end 
    else 
      redirect_to :back
    end
  end

  def create_message
    @chat = Chat.find(params[:chat_id])
    @chat.messages.build(text: params[:message][:text], user_id: current_user.id).save
    current_user[:messages_count] = current_user.messages.count
    respond_to do |format|
      if @chat.save
        format.html { redirect_to @chat, notice: 'Message sent.' }
        format.json { render :show, status: :created, location: @chat }
      else
        format.html { render :show }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end
  #Use callbacks to share common setup or constraints between actions.
  def set_chat
    @chat = Chat.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def chat_params
    params.require(:chat).permit(:id, :name, :users => [:id, :username])
  end
end
