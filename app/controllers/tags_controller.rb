class TagsController < ApplicationController
  before_filter :setdata

  def setdata
    update_title("Tags", "icon-edit")
  end

  def show
    @posts = Post.tagged_with(params[:id])
    @projects = Project.tagged_with(params[:id])
  end

 end