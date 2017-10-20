require 'crawl'
class HomeController < ApplicationController
	before_action :set_agent, only: [:web_address , :crawl , :get_domains]
	include Crawl
	def crawl 
		get_data params
		respond_to do |format|
	      format.js { render :partial => "crawl" }
	    end
	end
	def get_domains
		@jobs = Batch.last.jobs.includes(:company)
		@jobs.each do |job|
			if !job.company.web_address.present?
				sleep rand(1..2)
				link = crawl_company_address job.company.name
				job.company.update(web_address: link)
			end
		end
		respond_to do |format|
			format.js { render :partial => "crawl"}
		end

	end
	def web_address
		link = crawl_company_address params[:company_name].to_s
		render js: "window.open('#{link}');"
	end


	private
	def get_data params
		@jobs  = []
		# @company_names||= Company.all.pluck(:id, :name).to_h
		home_page = @agent.get(job_site_url)
		search_form = home_page.forms.first
		search_form['q'] = params[:crawl][:keyword]
		search_form['l'] = params[:crawl][:city]
		results_page = search_form.submit
		@batch =  Batch.create!(query: params[:crawl][:keyword] , city: params[:crawl][:city])
		paginate_through results_page
		i = 2
		loop do
			break if results_page.link_with(text: "#{i.to_s}").nil?
			results_page = results_page.link_with(text: "#{i.to_s}").click
			i = i + 1
			paginate_through results_page
		end
	end
	def paginate_through page
		get_page_data page
	end
	def get_page_data page
		page.search('#resultsCol .result').each do |job_section|
			company 	 	 = 		job_section.search(".company").text.strip
			city 		 		 = 		job_section.search(".location").text.strip
			posted_date  = 		job_section.search(".date").text.strip
			title 		   = 		job_section.search(".jobtitle").text.strip
			@company     =    Company.where(name: company).first_or_create
			job          =    Job.create!(company_id: @company.id ,  batch_id: @batch.id, city: city , posted_date: posted_date , title: title)
			@jobs << job
		end
	end
	def crawl_company_address company_name
		google = @agent.get(search_engine_url)
		form  = google.forms.first
		form['q'] = company_name
		result = form.submit
		website_address = result.search('cite').first
		link = website_address.present? ? website_address.text.strip : ""
		link = "http://" + link if (link.present? and !link.include? 'http')
		link
	end
end
