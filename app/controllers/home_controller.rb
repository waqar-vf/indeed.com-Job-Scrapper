class HomeController < ApplicationController
	def crawl 
		@jobs = []
		respond_to do |format|
	      format.js { render :partial => "crawl" }
	    end
	end
end
