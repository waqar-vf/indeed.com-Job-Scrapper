class Job < ApplicationRecord
	belongs_to :company
	belongs_to :batch
	# def initialize_job job_section , company_names
	# 		company 	 	 = 		job_section.search(".company").text.strip
	# 		self.city 		 = 		job_section.search(".location").text.strip
	# 		self.posted_date = 		job_section.search(".date").text.strip
	# 		self.title 		 = 		job_section.search(".jobtitle").text.strip
	# 		self.company_id  =      set_company company , company_names
	# end
	# def set_company company , company_names
	# 	matches =  company_names.select{|k, v | v == company.downcase ? k : nil}
	# 	matches.present? ? matches.first :  Company.create!(name: company).id 
	# end
end
