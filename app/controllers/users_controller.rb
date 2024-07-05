class UsersController < ApplicationController
  
  def my_portfolio
    @user=current_user
    @tracked_stocks= current_user.stocks
  end
  def my_friends
    @tracking_friends= current_user.friends
  end

  def show
    
    @user=User.find(params[:id])
    @tracked_stocks=  @user.stocks

  end
  def search
    if params[:friend].present?
      @friends=User.search(params[:friend])
      @friends=current_user.expect_current_user(@friends)
      if @friends
        respond_to do |format|  
            format.js { render partial:'users/friendsearchResult' }
        end
      else 
        respond_to do |format|
            flash.now[:alert]='No User Found!'
            format.js{render partial:'users/friendsearchResult' }
        end

      end
    else
      respond_to do |format|
        flash.now[:alert]='Please Enter name or Email'
        format.js{render partial:'users/friendsearchResult' }
    end

    end

  end
end
