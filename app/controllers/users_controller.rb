# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show follow unfollow]
  before_action :authenticate_user!
  def index
    @users = if params[:query].present?
               User.search(params[:query])
             else
               User.all
             end
  end

  def follow
    # @relationship=Relationship.new(follower_id:current_user.id,followee_id:@user.id)
    # if @relationship.save
    #  redirect_to @user
    # end
    redirect_to @user if @user.followers << current_user
  end

  def unfollow
    # Relationship.find_by(follower_id: current_user.id, followee_id: @user.id).destroy
    # redirect_to user_path(@user)
    redirect_to @user if current_user.followings.destroy(@user)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
