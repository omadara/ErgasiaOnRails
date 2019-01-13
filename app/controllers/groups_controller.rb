class GroupsController < ApplicationController

  #GET /groups
  def index
    @new_group= Chatroom.new
    @my_groups = Chatroom.where('user_id = ?',@current_user.id)
    @all_groups = Chatroom.where('title IS NOT NULL and user_id != ?',@current_user.id)
  end


  def create
    @new_group = Chatroom.new
    @new_group.title = params[:group_name]
    @new_group.user_id = @current_user.id
    @new_group.user_ids = @current_user.id
    if @new_group.save
      redirect_to groups_path, :flash => { :success => "Group created successfully"}
    else
      redirect_to groups_path, :flash => { :error => "Failed to create the group"}
    end


  end

  def destroy
    chatroom = Chatroom.find(params[:id])
    if chatroom.user_id == @current_user.id
      if chatroom.destroy
        redirect_to groups_path, flash: {success: "Group deleted."}
      else
        redirect_to groups_path, flash: {error: "Something went wrong."}
      end
    else
      redirect_to groups_path, flash: {error: "You are not the creator of this group."}
    end

  end

  def join
    chatroom = Chatroom.find(params[:id])
    if !chatroom.contains_user? @current_user.id
      chatroom.user_ids+=[@current_user.id]
      if chatroom.save
        redirect_back fallback_location: root_path, flash: {success: "Joined the group."}
      else
        redirect_back fallback_location: root_path, flash: {error: "Something went wrong."}
      end
    else
      redirect_back fallback_location: root_path, flash: {error: "You are already in that group."}
    end
  end

  def leave
    chatroom = Chatroom.find(params[:id])
    if chatroom.user_id == @current_user.id
      redirect_back fallback_location: root_path, flash: {warning: "You have to transfer ownership to be able to leave the group"}
      return
    end
    if chatroom.contains_user? @current_user.id
      chatroom.user_ids-=[@current_user.id]
      if chatroom.save
        redirect_back fallback_location: root_path, flash: {success: "You left the group"}
      else
        redirect_back fallback_location: root_path, flash: {error: "Something went wrong."}
      end
    else
      redirect_back fallback_location: root_path, flash: {error: "You are not in that group."}
    end

  end

  def transfer
    chatroom = Chatroom.find(params[:id])
    if chatroom.user_id == @current_user.id
      chatroom.user_id = params[:chatroom][:user_id]
      if chatroom.save
        redirect_back fallback_location: root_path
      else
        redirect_back fallback_location: root_path
      end
    else
      redirect_back fallback_location: root_path
    end

  end

end