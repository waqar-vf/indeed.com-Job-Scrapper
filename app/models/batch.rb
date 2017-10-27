class Batch < ApplicationRecord
	has_many :jobs ,dependent: :destroy
	has_many :companies
	def search_params
		"#{query} , #{city}"
	end
	def self.del
		Batch.destroy_all
		Company.destroy_all
		DomainSearch.destroy_all
		Job.destroy_all
		Email.destroy_all
	end
end
