class User::ChatsController < ApplicationController
  before_action :block_non_related_users, only: [:index, :show]

  def index
    @rooms = Room.all
    @user = @current_user
    @currentEntries = @current_user.entries
    myRoomIds = []
    @currentEntries.each do | entry |
      myRoomIds << entry.room.id
    end
    @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id != ?', @user.id)
  end

  def show
    @user = User.find(params[:id])
    rooms = current_user.entries.pluck(:room_id)
    entries = Entry.find_by(user_id: @user.id, room_id: rooms)
    unless entries.nil?
      @room = entries.room
    else
      @room = Room.new
      @room.save
      Entry.create(user_id: current_user.id, room_id: @room.id)
      Entry.create(user_id: @user.id, room_id: @room.id)
    end
      @chats = @room.chats
      @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    render :validate unless @chat.save
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def block_non_related_users
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(user)
    end
  end


end
