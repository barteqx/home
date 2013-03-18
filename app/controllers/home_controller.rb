class HomeController < ApplicationController

	before_filter :setdata

	def setdata
		update_title("Home", "icon-home")
	end

  def index
  	@post = Post.last
  	@projects = Project.all 	
	end
end
