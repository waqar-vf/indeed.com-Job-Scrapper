class Job < ApplicationRecord
	belongs_to :company
	belongs_to :batch
	def has_emails?
		self.company.present? ? self.company.domain_search.present? ? self.company.domain_search.emails.present? ? true : false : false : false
	end
end
