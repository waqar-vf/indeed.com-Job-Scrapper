require 'snovio'
class Company < ApplicationRecord
  has_many :jobs
  has_one :domain_search
  def create_domain_search

    access_token = Snovio.get_access_token
    puts "--------------------#{self.inspect}------------------#{self.domain_search.inspect}-----------------"
    self.domain_search = DomainSearch.new(domain: self.trim_web_address)
    domain_search = self.domain_search #.present? ? self. find_or_create_by!(domain: self.trim_web_address)
    @emails = Snovio.get_emails domain_search.domain , access_token
    # @domain_search = @company.domain_search.find_or_create_by!(domain: web_address)

    @emails["emails"].each do |email|
      	domain_search.emails.find_or_create_by(email: email["email"]) do |email_row|
      		email_row.address_type = email["type"]
      		email_row.status = email["status"]
      		email_row.first_name = email["firstName"]
      		email_row.last_name = email["lastName"]
      		email_row.position = email["position"]
      		email_row.source_page = email["sourcePage"]
      		email_row.twitter = email["twitter"]
      	end
    end
    domain_search.emails
  end
  def trim_web_address
    web_address = Addressable::URI.parse(self.web_address).host.to_s
    web_address.slice! "www."
    web_address
  end
  def self.check
    Snovio.get_access_token
  end
end
