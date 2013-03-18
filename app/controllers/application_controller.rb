class ApplicationController < ActionController::Base
	protect_from_forgery

	private

	def current_user
		user = User.find_by_id(session[:user_id])
		if not user
			session[:user_id] = nil
		end
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def admin?
		if not current_user or not current_user.permissions == "a"
			redirect_to root_url, :notice => "You do not have access to this subpage!"
		end
	end

	def update_title(newtitle, newicon="")
		params[:title] = newtitle
		params[:headertitle] = params[:title] + " - zasieczny.com"
		if not newicon.empty? then params[:icon] = newicon end
	end

	def owner_or_admin?(user_id)
		if not current_user or not (current_user.permissions == "a" or user_id == current_user.id)
			redirect_to root_url, :notice => "You do not have access to this subpage!"
		end
	end

	def logged_in?
		if not current_user
			redirect_to root_url, :notice => "You do not have access to this subpage!"
		end
	end

	helper_method :admin?
	helper_method :user_or_admin?
	helper_method :current_user
	helper_method :update_title
	helper_method :logged_in?
end
