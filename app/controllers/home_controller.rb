class HomeController < ApplicationController
	# bofore_action :set_job
	def crawl 
		get_data params
		respond_to do |format|
	      format.js { render :partial => "crawl" }
	    end
	end
	private
	def get_data params
		@jobs  = []
		agent = Mechanize.new
		home_page = agent.get("https://www.indeed.com.pk")
		search_form = home_page.forms.first
		search_form['q'] = params[:crawl][:keyword]
		search_form['l'] = params[:crawl][:city]
		results_page = search_form.submit
		paginate_through results_page
	end
	def paginate_through page 
		get_page_data page
	end
	def get_page_data page
		page.search('#resultsCol .result').each do |job|
			j = Job.new
			j.company = job.search(".company").text.strip
			j.city = job.search(".location").text.strip
			j.posted_date = job.search(".date").text.strip
			j.title = job.search(".jobtitle").text.strip
			@jobs << j
		end
	end
end
