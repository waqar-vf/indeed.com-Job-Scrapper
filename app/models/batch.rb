class Batch < ApplicationRecord
	has_many :jobs
	def search_params
		"#{query} , #{city}"
	end
end
