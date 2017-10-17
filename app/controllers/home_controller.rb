require 'crawl'
class HomeController < ApplicationController
	before_action :set_agent, only: [:web_address , :crawl]
	include Crawl
	def crawl 
		get_data params
		respond_to do |format|
	      format.js { render :partial => "crawl" }
	    end
	end

	def web_address
		google = @agent.get(search_engine_url)

		form  = google.forms.first
		form['q'] = params[:company_name].to_s
		result = form.submit
		link = result.search('cite').first.text.strip
		# render js: "alert('#{link}')"
		link = "http://" + link if !link.include? 'http'
		render js: "window.open('#{link}');"
	end

	private
	def get_data params
		@jobs  = []
		home_page = @agent.get(job_site_url)
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
			j.initialize_job(job)
			@jobs  <<  j
		end
	end

end
