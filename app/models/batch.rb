class Batch < ApplicationRecord
	has_many :jobs ,dependent: :destroy
	has_many :batch_companies
	has_many :companies , through: :batch_companies
	def search_params
		# "#{query} , #{city}"
		if batch_type == "import"
			return "import xlsx #{created_at.strftime('%c')}"
		else
			str = "#{query.capitalize}"
			str = str + ", #{city.capitalize}" if city.present?
			str
		end

	end
	def self.del
		Batch.destroy_all
		Company.destroy_all
		DomainSearch.destroy_all
		Job.destroy_all
		Email.destroy_all
	end
	default_scope {where(:batch_type => "search")}

end
