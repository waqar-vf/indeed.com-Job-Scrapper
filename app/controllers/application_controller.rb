class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  def job_site_url
  	"https://www.indeed.com"
  end
  def search_engine_url
  	"http://www.google.com"
  end
end
