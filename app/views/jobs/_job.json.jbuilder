json.extract! job, :id, :title, :company, :city, :state, :posted_date, :created_at, :updated_at
json.url job_url(job, format: :json)
