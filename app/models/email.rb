class Email < ApplicationRecord
  belongs_to :domain_search
  def status
    self[:status].to_s == "notVerified" ? "Not Verified" : "Verified"
  end
end
