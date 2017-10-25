class DomainSearch < ApplicationRecord
  has_many :emails
  belongs_to :company
end
