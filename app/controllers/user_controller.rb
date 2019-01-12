class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def send_friend_request
    if Friend.create(user1_id: current_user.id, user2_id: params[:id], accepted: false)
      flash[:info] = 'Friend request sent.'
      NotificationChannel.friendRequest(current_user.full_name, params[:id])
    else
      flash[:warning] = 'Could not sent friend request.'
    end
    redirect_back fallback_location: root_path
  end

  def accept_friend_request
    friend_request = Friend.find_by(user1_id: params[:id], user2_id: current_user.id, accepted: false)
    if friend_request.update_attributes(accepted: true)
      flash[:success] = 'Friend request accepted.'
    else
      flash[:warning] = 'Could not accept friend request.'
    end
    redirect_back fallback_location: root_path
  end

  def decline_friend_request
    friend_request = Friend.find_by(user1_id: params[:id], user2_id: current_user.id, accepted: false)
    if friend_request.destroy
      flash[:info] = 'Friend request rejected.'
    else
      flash[:warning] = 'Could not reject friend request.'
    end
    redirect_back fallback_location: root_path
  end

  def remove_friend
    friend = Friend.where('(user1_id = ? AND user2_id = ?) OR (user1_id = ? AND user2_id = ?)',
                          current_user.id, params[:id], params[:id], current_user.id).first
    if friend.destroy
      flash[:info] = 'Friend removed.'
    else
      flash[:warning] = 'Could not remove friend.'
    end
    redirect_back fallback_location: root_path
  end

end
