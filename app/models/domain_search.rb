class DomainSearch < ApplicationRecord
  has_many :emails ,dependent: :destroy
  belongs_to :company
end
