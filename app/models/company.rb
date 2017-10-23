class Company < ApplicationRecord
  has_many :jobs
  has_many :domain_searches
end
