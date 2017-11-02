class BatchCompany < ApplicationRecord
  belongs_to :company
  belongs_to :batch
end
