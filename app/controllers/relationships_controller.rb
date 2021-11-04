class RelationshipsController < ApplicationController
    
        
    def create
        follower = current_user.relationships.build(followed_id: params[:user_id])
        follower.save
        redirect_to request.referrer || root_path
    end
    
    def destroy
        follower = current_user.relationships.find_by(followed_id: params[:user_id])
        follower.destroy
        redirect_to request.referrer || root_path
    end
    
    # ↓フォロワーする側の機能
  def follower
    @user = User.find(params[:id])
    @follower = @user.followers
  end

  def followed
    @user = User.find(params[:id])
    @followed = @user.followeds
  end
  # ↑フォロワーされる側の機能
    
end
