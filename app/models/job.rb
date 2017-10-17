class Job < ApplicationRecord
	def initialize_job job_section
			self.company 	 = 		job_section.search(".company").text.strip
			self.city 		 = 		job_section.search(".location").text.strip
			self.posted_date = 		job_section.search(".date").text.strip
			self.title 		 = 		job_section.search(".jobtitle").text.strip
	end
end
