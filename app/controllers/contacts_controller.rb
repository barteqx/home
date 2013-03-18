class ContactsController < ApplicationController
	before_filter :setdata
	 before_filter :admin?, only: [:create, :new, :edit, :destroy, :update]

	def setdata
		update_title("Contacts", "icon-envelope")
	end

  def index
  	@contacts = Contact.all
	end

	def new
		@contact = Contact.new

		respond_to do |format|
      format.html # show.html.erb
    end
	end

  def edit
    @contact = Contact.find(params[:id])
  end

  def show
    redirect_to contacts_path
  end

  def destroy
  	@contact = Contact.find(params[:id])
  	@contact.destroy
  	redirect_to contacts_path
  end

    def create
    @contact = Contact.new(params[:contact])
    @contact.user_id = current_user.id

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Post was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @contact, notice: 'contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end
end
