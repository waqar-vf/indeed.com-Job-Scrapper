require 'snovio'
class Company < ApplicationRecord
  has_many :jobs ,dependent: :destroy
  has_one :domain_search ,dependent: :destroy
  belongs_to :batch
  def create_domain_search

    access_token = Snovio.get_access_token
    self.domain_search = DomainSearch.find_or_initialize_by(domain: self.trim_web_address) #find_or_initialize_by here WAQAR
    domain_search = self.domain_search
    # WARING please check if API call is needed here WAQAR
    #At snovio same domain address can be called multiple times without affecting remaining credit
    @emails = Snovio.get_emails domain_search.domain , access_token
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
    web_address = self.web_address.include?("http") ?  (Addressable::URI.parse(self.web_address).host.to_s) : (self.web_address)
    web_address.slice! "www."
    web_address
  end
  def self.check
    Snovio.get_access_token
  end
  def self.import file
    # raise "somthing went"
    xlsx = Roo::Spreadsheet.open(file)
    spreadsheet = xlsx.sheet(0)
    company_name = spreadsheet.row(1).first
    company_url = spreadsheet.row(1).second
    spreadsheet.each(c: company_name, u: company_url) do |row|
      this_company = find_or_create_by!(:name => row[:c] ) do |company|
        company.web_address = row[:u]
        # company.create_domain_search
      end
+

this_company.create_domain_search

    end

  end
end
