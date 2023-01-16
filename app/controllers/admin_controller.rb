class AdminController < ApplicationController
  before_action :is_admin!
  def index
  end

  def posts
    @posts = Post.all.includes(:user, :category)
  end

  def categories
    @categories = Category.all.order(title: :asc)
  end

  def comments
  end

  def users
  end

  def show_post
    @post = Post.includes(:user, comments: [:user, :rich_text_body]).find(params[:id])
  end

  def show_category
    @category = Category.find(params[:id])
  end
end
