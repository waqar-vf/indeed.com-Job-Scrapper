class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
    @active_batch = Batch.unscoped.find_by_id(params[:active_batch])
    respond_to do |format|
      format.js do

      end
      format.html
    end
  end
  def import_csv
    begin
    Company.import(params[:file])
    render js: "$('#waiting_bar').modal('hide'); alert('import Successfull')"
    rescue => error
      puts "-------------+++++++#{error.inspect}-----------------------"
      render js: "$('#waiting_bar').modal('hide'); alert('Something went wrong')"
    end

  end
  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    @active_batch = Batch.unscoped.find_by_id(params[:batch_id])
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to active_batch_path(params[:batch_id]), notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
        format.js {  redirect_to active_batch_path(params[:batch_id]), notice: 'Company was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }

      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :web_address, :invalid_address, :active_batch)
    end
end
