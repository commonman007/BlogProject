# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :load_blog, only: %i[edit update destroy show]
  load_and_authorize_resource

  def index
    @blogs = Blog.paginate(page: params[:page], per_page: 10)
  end

  def new
    @blog = @current_user.blogs.build
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      flash.now[:success] = 'Blog Created Successfully'
      redirect_to blogs_path
    else
      flash.now[:warning] = 'Blog Creation Failed!'
      render 'new'
    end
  end

  def edit; end

  def update
    if @blog.update_attributes(blog_params)
      flash.now[:success] = 'Blog Successfully Updated'
    else
      flash.now[:warning] = 'Blog Updation failed'
    end
    redirect_to blog_path(@blog)
  end

  def destroy
    if @blog.destroy
      flash.now[:success] = 'Blog destroyed Successfully'
    else
      flash.now[:warning] = 'Blog deletion failed'
    end
    redirect_to blogs_path
  end

  def show; end

  private

  def blog_params
    params.require(:blog).permit(:title, :description, :image)
  end

  def load_blog
    @blog = Blog.find(params[:id])
  end
end
