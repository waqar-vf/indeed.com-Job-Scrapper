require 'crawl'
require 'csv'
class HomeController < ApplicationController
	before_action :set_agent, only: [:web_address , :crawl , :get_domains]
	before_action :set_batch, only: [:index , :get_domains ,:crawl]
	include Crawl
	def index
    @jobs = @active_batch.present? ? @active_batch.jobs : nil
	end
	def crawl
		# debugger
		get_data params
		respond_to do |format|
	      format.js { render :partial => "crawl" }
	    end
	end
	def get_domains
		@jobs = @active_batch.jobs.includes(:company)
		begin
			@jobs.each do |job|
				if !job.company.web_address.present?
					delay 1
					link = crawl_company_address job.company.name
					job.company.update(web_address: link)
				end
			end
			respond_to do |format|
				format.js { render :partial => "crawl"}
			end
		rescue => error
			$!.backtrace

			render js: "something_went_wrong(#{error.inspect});"
		end
	end
	def web_address
		link = crawl_company_address params[:company_name].to_s
		render js: "window.open('#{link}');"
	end
	def get_company
		@company = Company.find_by_id(params[:id])
		respond_to do |format|
			format.js
			format.html
		end
	end
	def get_emails
		@job = Job.find_by_id(params[:job_id])
		@company = Company.find(params[:id])
		@emails = get_domain_search_emails @company
		respond_to do |format|
			format.js
		end
	end
	def get_all_emails
		@batch = Batch.find_by_id(params[:batch_id])
		begin
			@batch.jobs.each do |job|
				get_domain_search_emails job.company
			end
			render js: "get_all_emails_success();"
		rescue => error

		end
		respond_to do |format|
			format.js
		end
	end
	def csv_download
    @batch = params[:batch_id].present? ? Batch.find_by_id(params[:batch_id]) : Batch.last
    @jobs = @batch.jobs.includes(company: {domain_search: :emails})
		respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"Contacts-list.csv\""
        headers['Content-Type'] ||= 'text/csv'

      end

		end
	end
	def job_csv_download
		@jobs = []
		job = Job.find_by_id(params[:job_id])
		puts "--------#{job.inspect}------"
		@jobs << job
		respond_to do |format|
			format.csv do
				headers['Content-Disposition'] = "attachment; filename=\"Contact-list.csv\""
				headers['Content-Type'] ||= 'text/csv'
				render 'csv_download'
			end
		end
	end
	private

	def get_data params
		puts "----------------------#{params.inspect}------------------------------"
		@jobs  = []
		home_page = @agent.get(job_site_url)
		search_form = home_page.forms.first
		search_form['q'] = params[:keyword]
		search_form['l'] = params[:city]
		results_page = search_form.submit
		@active_batch =  Batch.find_or_create_by!(query: params[:keyword].downcase , city: params[:city].downcase)
		paginate_through results_page
		i = 2
		loop do
			break if results_page.link_with(text: "#{i.to_s}").nil?
			results_page = results_page.link_with(text: "#{i.to_s}").click
			# delay 1..2
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
			@company     =    Company.where(name: company).first_or_create do |comp|
				comp.batch_id = @active_batch.id
			end
			job          =    Job.find_or_create_by!(company_id: @company.id ,  batch_id: @active_batch.id, city: city , posted_date: posted_date , title: title)

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
	def set_batch
    @batches =  Batch.all
		@unscoped_batches = Batch.unscoped.all
    @active_batch = params[:batch_id].present? ? Batch.find_by_id(params[:batch_id]) :  @batches.last

	end
	def delay secs
		sleep rand(secs)
	end
	def get_domain_search_emails company
		begin
			if company.domain_search.present?
				emails = company.domain_search.emails
			else
				emails = company.create_domain_search
			end
		rescue
			company.update(invalid: true)
		end
		emails
	end
end
