# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def postlike
    @post = Post.find(params[:id])
    @like = Like.new(likeable: @post, liked_by: current_user.id)
    @like.save
    redirect_to @post
  end

  def commentlike
    @comment = Comment.find(params[:cid])
    @post = Post.find(params[:id])
    @like = Like.new(likeable: @comment, liked_by: current_user.id)
    @like.save
    redirect_to @post
  end
end
