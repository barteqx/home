class UsersController < ApplicationController

  def new
  	update_title("Create user", "icon-magic")
	  @user = User.new
	end

	def create
		update_title("Create user", "icon-magic")
		usersempty = User.all.empty?
	  @user = User.new(params[:user])
	  if usersempty then @user.permissions = "a" end
	  if @user.save
	    redirect_to root_url, :notice => "Signed up!"
	  else
	    render "new"
	  end
	end

	def index
		update_title("Users", "icon-magic")
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    update_title(@user.login, "icon-magic")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    update_title(@user.login, "icon-magic")
    owner_or_admin? @user.id
  end

  def destroy
  	@user = User.find(params[:id])
    owner_or_admin? @user.id
  	@user.destroy
  end

  def update
    @user = User.find(params[:id])
    owner_or_admin? @user.id

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
