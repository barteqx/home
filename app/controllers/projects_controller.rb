class ProjectsController < ApplicationController
	before_filter :setdata
	 before_filter :admin?, only: [:create, :new, :edit, :destroy, :update]

	def setdata
		params[:title] = "Projects"
		params[:headertitle] = params[:title] + " - zasieczny.com"
		params[:icon] = "icon-wrench"
	end

	def index
		if params[:tag]
      @projects = Project.tagged_with(params[:tag])
    else
      @projects = Project.all
    end
    @projects.reverse!
	end

	def new
		@project = Project.new

		respond_to do |format|
      format.html # show.html.erb
    end
	end

	 def show
    @project = Project.find(params[:id])
    @user = @project.user

    @can_edit = current_user && ((@user.id == current_user.id) or (current_user.permissions == a))

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def destroy
  	@project = Project.find(params[:id])
  	@project.destroy
  	render "index"
  end

  def create
    @project = Project.new(params[:project])
    @project.user_id = current_user.id

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Post was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
end
