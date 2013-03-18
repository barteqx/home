class SessionsController < ApplicationController
	
	before_filter :setdata

	def setdata
		params[:title] = "Log in"
		params[:headertitle] = params[:title] + " - zasieczny.com"
		params[:icon] = "icon-magic"
	end

	def new
	end

	def create
	  user = User.find_by_email(params[:email])
	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect_to root_url, :notice => "Logged in!"
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
	end

	def destroy
	  session[:user_id] = nil
	  redirect_to root_url, :notice => "Logged out!"
	end
end
