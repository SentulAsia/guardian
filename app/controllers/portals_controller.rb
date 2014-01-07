class PortalsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate, :except => :seed
  helper_method :sort_column, :sort_direction
  require 'uri'
  # GET /portals
  # GET /portals.json
  def index
    @now = Time.now
    @portals = Portal.search(params[:search], params[:type]).paginate(:page => params[:page], :per_page => 30).order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @portals }
      format.xml { render xml: @portals }
      format.xls
    end
  end

  # GET /portals/1
  # GET /portals/1.json
  def show
    @portal = Portal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @portal }
    end
  end

  # GET /portals/new
  # GET /portals/new.json
  def new
    @portal = Portal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @portal }
    end
  end

  # GET /portals/1/edit
  def edit
    @portal = Portal.find(params[:id])
    @portal.destruction_date = Time.now if @portal.status_string == 'Live'
  end

  # POST /portals
  # POST /portals.json
  def create
    @portal = Portal.new(params[:portal])

    respond_to do |format|
      if @portal.save
        format.html { redirect_to portals_url, notice: 'Portal was successfully created.' }
        format.json { render json: @portal, status: :created, location: @portal }
      else
        format.html { render action: "new" }
        format.json { render json: @portal.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /portals/seed
  def seed
    @portal = Portal.find_or_initialize_by_portal_guid(params[:portal_guid])
    @portal.agent_name = '@' + params[:agent_name]
    @portal.portal_name = URI.decode(params[:portal_name])
    @portal.captured_date = Time.at(params[:captured_date].to_f/1000)
    @portal.lng_coordinate = params[:lng_coordinate].to_f / 1000000
    @portal.lat_coordinate = params[:lat_coordinate].to_f / 1000000
    @portal.location = URI.decode(params[:location])
    @portal.link = 'http://ingress.com/intel?ll=' + @portal.lat_coordinate.to_s + ',' + @portal.lng_coordinate.to_s + '&z=17&pll=' + @portal.lat_coordinate.to_s + ',' + @portal.lng_coordinate.to_s + ';'
    @portal.day_of_150 = @portal.captured_date + 150.days
    @portal.status_string = "Live"
    @portal.destroyed_by = nil
    @portal.destruction_date = nil

    respond_to do |format|
      if @portal.save
        format.html { redirect_to portals_url, notice: 'Portal was successfully seeded.' }
        format.json { render json: @portal, status: :created, location: @portal }
      else
        format.html { render action: "new" }
        format.json { render json: @portal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /portals/1
  # PUT /portals/1.json
  def update
    @portal = Portal.find(params[:id])
    @page = params[:portal][:page] unless params[:portal][:page].blank?

    respond_to do |format|
      if @portal.update_attributes(params[:portal])
        format.html { redirect_to portals_url(:page => @page), notice: 'Portal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @portal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portals/1
  # DELETE /portals/1.json
  def destroy
    @portal = Portal.find(params[:id])
    @portal.destroy

    respond_to do |format|
      format.html { redirect_to portals_url }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
      Portal.column_names.include?(params[:sort]) ? params[:sort] : "captured_date"
  end

  def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  protected

  def authenticate
    unless request.format == :json or request.format == :xml or request.format == :xls
      authenticate_or_request_with_http_basic do |username, password|
        username == "smurftears" && password == "smurfcrycry"
      end
    end
  end
end
