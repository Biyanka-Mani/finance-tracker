class FriendshipsController < ApplicationController
  
  def create
    friend=params[:friend]
    @user_friend=Friendship.create(user_id:current_user.id,friend_id:friend)
    @user_friend.save
    flash[:notice]="You started to follow a new User"
    redirect_to my_friends_path
  end

  def destroy
    friend_id=params[:id]
    user_friend= Friendship.where(user_id: current_user.id,friend_id:friend_id).first
    user_friend.destroy
    flash[:notice]="User  is successfully removed from your Friends list"
    redirect_to my_friends_path
  end
end
