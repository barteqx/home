class CommentsController < ApplicationController
  before_filter :setdata


  def setdata
    update_title("Comments", "icon-edit")
  end

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    owner_or_admin? @comment.user_id
  end

  # POST /comments
  # POST /comments.json
  def create
    logged_in?
    @comment = Comment.new()
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    @comment.project_id = params[:project_id]
    @comment.content = params[:content]

    if @comment.post_id
      @source = Post.find @comment.post_id
    elsif @comment.project_id
      @source = Project.find @comment.project_id
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @source, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render @source }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    if @comment.post_id
      @source = Post.find @comment.post_id
    elsif @comment.project_id
      @source = Project.find @comment.project_id
    end

    owner_or_admin? @comment.user_id
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @source, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])

    if @comment.post_id
      @source = Post.find @comment.post_id
    elsif @comment.project_id
      @source = Project.find @comment.project_id
    end

    owner_or_admin? @comment.user_id
    @comment.destroy 
    respond_to do |format|
      format.html { redirect_to @source }
      format.json { head :no_content }
    end
  end
end
